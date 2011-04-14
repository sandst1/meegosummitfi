/*
 * MeeGoSummitFI - Timetable application for MeeGo Summit Finland
 * Copyright (C) 2011 Topi Santakivi <topi.santakivi@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */
#include "xmlparser.h"
#include "summititems.h"

#include <QDebug>

#include <QDeclarativeView>
#include <QDir>
#include <QDomElement>
#include <QDomNode>
#include <QDomNodeList>

#include <QDateTime>

#include <QTextStream>

#define XMLPATH ".config/meegosummitfi"
#define XMLFILE "/.config/meegosummitfi/program.xml"
#define XMLURL "http://koti.kapsi.fi/~sh8dfwk/meegosummitfi/program.xml"

#define HTTP_OK 200

XMLParser::XMLParser(QDeclarativeContext* context, QObject *parent) :
    QObject(parent),
    m_doc("SummitProgram"),
    m_xmlfile(),
    m_daysModel(NULL),
    m_lists(),
    m_context(context),
    m_networkManager(NULL),
    m_currentSessions(NULL)
{
    m_daysModel     = new ListModel(new DayItem, this);
    m_networkManager = new QNetworkAccessManager(this);

    connect(m_networkManager, SIGNAL(finished(QNetworkReply*)),
            this, SLOT(programXMLDownloaded(QNetworkReply*)));

    // Check if we need to download the program XML
    if ( !(updateXML(false)) )
    {
        qDebug("XMLParser: no need to update xml, calling parse()");
        parse();
        updateCurrentSessions(false);
    }    
}

XMLParser::~XMLParser()
{}

void XMLParser::parse()
{
    qDebug("XMLParser::parse");   

    m_xmlfile.setFileName(QDir::homePath() + XMLFILE);

    bool success = m_xmlfile.open(QIODevice::ReadOnly);
    if ( success )
    {
        qDebug("program.xml successfully opened");
        if ( m_doc.setContent(&m_xmlfile, false) )
            qDebug("XML parsed to DOMDocument");
        else
            qDebug("Failed to set file to DOMDocument!");

        m_xmlfile.close();
    }
    else
    {
        qDebug("XMLParser failed to open program.xml!");
    }

    QDomElement docelem = m_doc.documentElement();

    // TODO: Free the memory allocated by the lists
    m_lists.clear();
    //m_daysModel->clear();
    delete m_daysModel;
    m_daysModel     = new ListModel(new DayItem, this);
    m_context->setContextProperty("daysModel", m_daysModel);

    qDebug() << "DocElem:" << docelem.tagName();

    // Parse days
    QDomNodeList days = docelem.elementsByTagName("day");
    for ( int i = 0; i < days.size(); i++ )
    {
        QDomNode day = days.at(i);
        QDomElement dayElem = days.at(i).toElement();

        QString dayName = dayElem.attribute("name");

        // Create a model for the Tracks happening at this day
        ListModel* tracksModel = new ListModel(new TrackItem, this);
        m_lists[dayName] = tracksModel;

        DayItem *dayItem = new DayItem(dayName,
                                       dayElem.attribute("date"),
                                       m_daysModel);

        qDebug() << "XMLParser: Loaded day" << dayName;

        // Put the name to the day item's data so
        // we know where to go next when the day is selected
        dayItem->setChildList(dayName);

        // Add the day to the list model
        m_daysModel->appendRow(dayItem);

        // Get the data for the Tracks
        QDomNodeList tracks = day.childNodes();
        for ( int j = 0; j < tracks.size(); j++ )
        {
            QDomNode track = tracks.at(j);

            QDomElement trackElem = track.toElement();

            // Create a list item for the track
            QString trackName = trackElem.attribute("name");
            QString trackLocation = trackElem.attribute("location");
            TrackItem *trackItem = new TrackItem(trackName,
                                                 trackLocation,
                                                 tracksModel);

            qDebug() << "Found track " << dayName << ": " << trackName;

            // Session model
            ListModel* sessionsModel = new ListModel(new SessionItem, this);
            // Use Day+Track Name to identify a list of sessions
            trackName = dayName + ", " + trackName + " (" + trackLocation + ")";
            qDebug() << "Setting sessionsModel with the name " << trackName << ".";
            m_lists[trackName] = sessionsModel;

            trackItem->setChildList(trackName);

            // Add the Track to the list model
            tracksModel->appendRow(trackItem);

            // Get the Sessions for this Track
            QDomNodeList sessions = track.childNodes();
            for ( int k = 0; k < sessions.size(); k++ )
            {
                QDomNode sessionNode = sessions.at(k);
                QDomElement sessionElem = sessionNode.toElement();

                SessionItem *sessionItem = new SessionItem(sessionElem.attribute("name"),
                                                           sessionElem.attribute("speaker"),
                                                           sessionNode.namedItem("start").childNodes().at(0).nodeValue(),
                                                           sessionNode.namedItem("end").childNodes().at(0).nodeValue(),
                                                           sessionNode.namedItem("description").childNodes().at(0).nodeValue(),
                                                           "",
                                                           false,
                                                           sessionsModel);
                // Add the Session to the list model
                sessionsModel->appendRow(sessionItem);
            }
        }
    }
    emit this->dataAvailable();
    qDebug("XMLParser::parse exit");
}

void XMLParser::setTracksModel(const QString& modelName)
{
    qDebug() << "XMLParser::setTracksModel: " << modelName;
    if ( m_context != NULL )
    {
        ListModel *model = m_lists[modelName];
        m_context->setContextProperty("tracksModel", model);
    }
}

void XMLParser::setSessionsModel(const QString& modelName)
{
    qDebug() << "XMLParser::setSessionsModel: " << modelName;
    if ( m_context != NULL )
    {
        ListModel *model = m_lists[modelName];
        m_context->setContextProperty("sessionsModel", model);
    }
}

bool XMLParser::updateXML(bool forceUpdate)
{
    // Create the XML path if it doesn't exist
    QDir::home().mkpath(XMLPATH);

    // Check if there's already an XML in the config directory
    if ( !forceUpdate && QFile(QDir::homePath() + XMLFILE).exists() )
    {
        qDebug("XMLParser::updateXML, file already exists!");
        return false;
    }

    if ( !forceUpdate )
    {
        emit this->startingDataUpdate();
    }

    // Check if there's network available
    if ( m_networkManager->networkAccessible() == QNetworkAccessManager::NotAccessible )
    {
        emit this->dataUpdateFailed();
        return false;
    }

    QUrl url(XMLURL);
    m_networkManager->get(QNetworkRequest(url));

    return true;
}

void XMLParser::programXMLDownloaded(QNetworkReply* networkReply)
{
    qDebug("XMLParser::programXMLDownloaded");

    if ( networkReply->error() == QNetworkReply::NoError )
    {
        int status = networkReply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toUInt();

        qDebug("HTTP Status code %d", status);

        if ( status == HTTP_OK )
        {
            QString programFileStr(QDir::homePath() + QString(XMLFILE));
            QFile::remove(programFileStr);

            QFile programFile(programFileStr);
            programFile.open(QIODevice::WriteOnly);

            QString programBuffer = QString::fromUtf8(networkReply->readAll().data());

            QTextStream out(&programFile);
            out << programBuffer;

            programFile.close();
        }
        else
        {
            qDebug("Download failed!");
            emit this->dataUpdateFailed();
        }


    }

    this->parse();
    this->updateCurrentSessions(false);
}

Q_INVOKABLE void XMLParser::updateCurrentSessions(bool sendCompleteNotification)
{
    qDebug("XMLParser::updateCurrentSessions");
    if ( m_currentSessions )
    {
        m_currentSessions->clear();
        //delete m_currentSessions;
        //m_currentSessions = NULL;
    }


    QDomElement docelem = m_doc.documentElement();

    qDebug() << "DocElem:" << docelem.tagName();

    // Parse days
    QDomNodeList days = docelem.elementsByTagName("day");
    for ( int i = 0; i < days.size(); i++ )
    {
        QDomNode day = days.at(i);
        QDomElement dayElem = days.at(i).toElement();


        QString xmlDate = dayElem.attribute("date");
        QString curDate = QDateTime::currentDateTime().toString("yyyy-MM-dd");

        qDebug() << "XMLParser: Loaded day" << xmlDate << ", today: " << curDate;

        if ( xmlDate != curDate )
        {
            qDebug("No sessions ongoing");
            continue;
        }

        // Model for the current sessions
        m_currentSessions = new ListModel(new SessionItem, this);

        // Get the data for the Tracks
        QDomNodeList tracks = day.childNodes();
        for ( int j = 0; j < tracks.size(); j++ )
        {
            QDomNode track = tracks.at(j);

            QDomElement trackElem = track.toElement();

            // Create a list item for the track
            QString trackName = trackElem.attribute("name");
            QString trackLocation = trackElem.attribute("location");
            trackName += " (" + trackLocation + ")";

            // Get the Sessions for this Track
            QDomNodeList sessions = track.childNodes();
            for ( int k = 0; k < sessions.size(); k++ )
            {
                QDomNode sessionNode = sessions.at(k);
                QDomElement sessionElem = sessionNode.toElement();

                QString startTime = sessionNode.namedItem("start").childNodes().at(0).nodeValue();
                QString endTime   = sessionNode.namedItem("end").childNodes().at(0).nodeValue();

                // In the case the whole track hasn't started,
                // just take the first session and move on
                if ( k == 0 && !(hasSessionStarted(startTime)) )
                {
                    qDebug("SESSION HASN't STARTED!!!");

                    SessionItem *sessionItem = new SessionItem(sessionElem.attribute("name"),
                                                               sessionElem.attribute("speaker"),
                                                               startTime,
                                                               endTime,
                                                               sessionNode.namedItem("description").childNodes().at(0).nodeValue(),
                                                               trackName,
                                                               true,
                                                               m_currentSessions);

                    // Add the Session to the list mode
                    m_currentSessions->appendRow(sessionItem);

                    // Move to next track
                    break;
                }

                if ( this->isSessionCurrent(startTime, endTime) )
                {
                    // Take the current and next session for this track
                    SessionItem *sessionItem = new SessionItem(sessionElem.attribute("name"),
                                                               sessionElem.attribute("speaker"),
                                                               startTime,
                                                               endTime,
                                                               sessionNode.namedItem("description").childNodes().at(0).nodeValue(),
                                                               trackName,
                                                               false,
                                                               m_currentSessions);

                    // Add the Session to the list mode
                    m_currentSessions->appendRow(sessionItem);

                    // Take the next session of the track only if there is a next session
                    if ( (k+1) < sessions.size() )
                    {
                        sessionNode = sessions.at(k+1);
                        sessionElem = sessionNode.toElement();
                        sessionItem = new SessionItem(sessionElem.attribute("name"),
                                                      sessionElem.attribute("speaker"),
                                                      sessionNode.namedItem("start").childNodes().at(0).nodeValue(),
                                                      sessionNode.namedItem("end").childNodes().at(0).nodeValue(),
                                                      sessionNode.namedItem("description").childNodes().at(0).nodeValue(),
                                                      trackName,
                                                      false,
                                                      m_currentSessions);

                        // Add the Session to the list mode
                        m_currentSessions->appendRow(sessionItem);
                    }

                    // Time to break
                    break;
                }
            }
        }
    }

    // Publish the current sessions to the QML side
    m_context->setContextProperty("currentSessionsModel", m_currentSessions);


    if ( sendCompleteNotification )
        emit this->currentSessionsUpdated();

    qDebug("XMLParser::updateCurrentSessions exit");

}

//var curDate = Qt.formatDateTime(new Date(), "yyyy-MM-dd")

//if ( curDate.toString() == trackScreen.date )
//{
//    var curTime = Qt.formatDateTime(new Date(), "hh:mm");
//    if ( startTime <= curTime && endTime > curTime ) {
//        return true;
//    }
//    else {
//        return false;
//    }

bool XMLParser::isSessionCurrent(const QString &startTime, const QString &endTime)
{
    QTime start = QTime::fromString(startTime, "hh:mm");
    QTime end   = QTime::fromString(endTime, "hh:mm");
    QTime cur   = QTime::currentTime();

    if ( start <= cur && end > cur )
        return true;

    return false;
}

bool XMLParser::hasSessionStarted(const QString& startTime)
{
    QTime start = QTime::fromString(startTime, "hh:mm");
    QTime cur   = QTime::currentTime();
    if ( cur < start )
        return false;
    return true;
}

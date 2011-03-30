#include "xmlparser.h"
#include "summititems.h"

#include <QDebug>

#include <QDeclarativeView>
#include <QDir>
#include <QDomElement>
#include <QDomNode>
#include <QDomNodeList>

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
    m_networkManager(NULL)
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

    // TODO: Change this to an actual download!
    //if ( !(QFile::copy(":/xml/program.xml", QDir::homePath() + QString(XMLFILE))) )
    //{
    //    qDebug("XMLParser::updateXml, XML Download FAILED!");
    //}
    QUrl url(XMLURL);
    m_networkManager->get(QNetworkRequest(url));

    // TODO: programXMLDownloaded needs to be connected
    // to the signal coming when the xml download is ready
    //this->programXMLDownloaded();

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
}







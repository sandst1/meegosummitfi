#include "xmlparser.h"
#include "summititems.h"

#include <QDebug>

#include <QDeclarativeView>
#include <QDomElement>
#include <QDomNode>
#include <QDomNodeList>

XMLParser::XMLParser(QObject *parent) :
    QObject(parent),
    m_doc("SummitProgram"),
    m_xmlfile(),
    m_daysModel(NULL),
    m_lists(),
    m_context(NULL)
{
    m_daysModel     = new ListModel(new DayItem, this);

    m_xmlfile.setFileName(":/xml/program.xml");

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
}

XMLParser::~XMLParser()
{}

void XMLParser::parse(QDeclarativeContext* context)
{

    qDebug("XMLParser::parse");

    if ( context == NULL )
    {
        qDebug("Error: declarativecontext == NULL!");
    }
    m_context = context;

    QDomElement docelem = m_doc.documentElement();

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
    emit this->xmlParsed();
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








#ifndef XMLPARSER_H
#define XMLPARSER_H

#include <QObject>
#include <qdom.h>
#include <QFile>
#include <QMap>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QString>
#include <QVector>
#include <QDeclarativeContext>

#include "listmodel.h"

class XMLParser : public QObject
{
    Q_OBJECT
public:
    explicit XMLParser(QDeclarativeContext* context, QObject *parent = 0);
    ~XMLParser();

    void parse();

    ListModel* getDaysModel() { return m_daysModel; }

    Q_INVOKABLE void setTracksModel(const QString& modelName);
    Q_INVOKABLE void setSessionsModel(const QString& modelName);

    Q_INVOKABLE bool updateXML(bool forceUpdate);

    Q_INVOKABLE void updateCurrentSessions();

signals:
    void dataAvailable();
    void dataUpdateFailed();
    void startingDataUpdate();
public slots:
    void programXMLDownloaded(QNetworkReply*);
private:
    bool isSessionCurrent(const QString& startTime, const QString& endTime);
    bool hasSessionStarted(const QString& startTime);

    QDomDocument m_doc;
    QFile        m_xmlfile;

    ListModel*   m_daysModel;
    QMap<QString, ListModel*> m_lists;
    QDeclarativeContext* m_context;

    QNetworkAccessManager* m_networkManager;
    ListModel*   m_currentSessions;
};

#endif // XMLPARSER_H

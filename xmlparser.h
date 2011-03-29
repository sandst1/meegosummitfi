#ifndef XMLPARSER_H
#define XMLPARSER_H

#include <QObject>
#include <qdom.h>
#include <QFile>
#include <QMap>
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

    Q_INVOKABLE bool updateXML(bool forceUpdate = false);

signals:
    void dataAvailable();
public slots:
    void programXMLDownloaded();
private:
    QDomDocument m_doc;
    QFile        m_xmlfile;

    ListModel*   m_daysModel;
    //ListModel*   m_tracksModel;
    //ListModel*   m_sessionsModel;
    QMap<QString, ListModel*> m_lists;
    QDeclarativeContext* m_context;
};

#endif // XMLPARSER_H

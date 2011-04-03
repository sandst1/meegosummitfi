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

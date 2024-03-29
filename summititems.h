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
#ifndef SUMMITITEMS_H
#define SUMMITITEMS_H

#include "listmodel.h"

class DayItem : public ListItem
{
  Q_OBJECT

public:
    enum Roles
    {
        NameRole = Qt::UserRole+1,
        DateRole,
        ChildListRole
    };

public:
    DayItem(QObject *parent = 0): ListItem(parent) {}
    explicit DayItem(const QString &name,
                     const QString &date,
                     QObject *parent = 0);
    QVariant data(int role) const;
    QHash<int, QByteArray> roleNames() const;
    inline QString id() const { return m_name; }
    inline QString name() const { return m_name; }
    inline QString date() const { return m_date; }

    inline void setChildList(const QString& listname) { m_childlist = listname; }
    inline QString getChildList() const { return m_childlist; }

private:
    QString m_name;
    QString m_date;
    QString m_childlist;
};


class TrackItem : public ListItem
{
  Q_OBJECT

public:
    enum Roles
    {
        NameRole = Qt::UserRole+1,
        LocationRole,
        ChildListRole
    };

public:
    TrackItem(QObject *parent = 0): ListItem(parent) {}
    explicit TrackItem(const QString &name,
                       const QString &location,
                       QObject *parent = 0);
    QVariant data(int role) const;
    QHash<int, QByteArray> roleNames() const;
    inline QString id() const { return m_name; }
    inline QString name() const { return m_name; }
    inline QString location() const { return m_location; }

    inline void setChildList(const QString& listname) { m_childlist = listname; }
    inline QString getChildList() const { return m_childlist; }

private:
    QString m_name;
    QString m_location;
    QString m_childlist;
};

class SessionItem : public ListItem
{
  Q_OBJECT

public:
    enum Roles
    {
        NameRole = Qt::UserRole+1,
        SpeakerRole,
        StartTimeRole,
        EndTimeRole,
        DescriptionRole,
        TrackRole,
        FirstSessionRole
    };

public:
    SessionItem(QObject *parent = 0): ListItem(parent) {}
    explicit SessionItem(const QString &name,
                         const QString &speaker,
                         const QString &starttime,
                         const QString &endtime,
                         const QString &description,
                         const QString &track = QString(),
                         bool firstSessionOfTrack = false,
                         QObject *parent = 0);
    QVariant data(int role) const;
    QHash<int, QByteArray> roleNames() const;
    inline QString id() const { return m_name; }
    inline QString name() const { return m_name; }
    inline QString speaker() const { return m_speaker; }
    inline QString starttime() const { return m_starttime; }
    inline QString endtime() const { return m_endtime; }
    inline QString description() const { return m_description; }
    inline QString track() const { return m_track; }
    inline bool firstSession() const { return m_firstSession; }

private:
    QString m_name;
    QString m_speaker;
    QString m_starttime;
    QString m_endtime;
    QString m_description;    
    QString m_track;
    bool    m_firstSession;
};

#endif // SUMMITITEMS_H

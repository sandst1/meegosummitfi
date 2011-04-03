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
#include "summititems.h"

DayItem::DayItem(const QString &name,
                 const QString &date,
                 QObject *parent)
    : ListItem(parent),
      m_name(name),
      m_date(date),
      m_childlist()
{}

QHash<int, QByteArray> DayItem::roleNames() const
{
    QHash<int, QByteArray> names;
    names[NameRole] = "name";
    names[DateRole] = "date";
    names[ChildListRole] = "childlist";
    return names;
}

QVariant DayItem::data(int role) const
{
    switch(role)
    {
        case NameRole:
            return name();

        case DateRole:
            return date();

        case ChildListRole:
            return getChildList();

        default:
            return QVariant();
    }
}


TrackItem::TrackItem(const QString &name,
                     const QString &location,
                     QObject *parent)
    : ListItem(parent),
      m_name(name),
      m_location(location),
      m_childlist()
{}

QHash<int, QByteArray> TrackItem::roleNames() const
{
    QHash<int, QByteArray> names;
    names[NameRole]     = "name";
    names[LocationRole] = "location";
    names[ChildListRole] = "childlist";
    return names;
}

QVariant TrackItem::data(int role) const
{
    switch(role)
    {
        case NameRole:
            return name();

        case LocationRole:
            return location();

        case ChildListRole:
            return getChildList();

        default:
            return QVariant();
    }
}



SessionItem::SessionItem(const QString &name,
                         const QString &speaker,
                         const QString &starttime,
                         const QString &endtime,
                         const QString &description,
                         const QString &track,
                         bool firstSessionOfTrack,
                         QObject *parent)
    : ListItem(parent),
      m_name(name),
      m_speaker(speaker),
      m_starttime(starttime),
      m_endtime(endtime),
      m_description(description),
      m_track(track),
      m_firstSession(firstSessionOfTrack)
{}

QHash<int, QByteArray> SessionItem::roleNames() const
{
    QHash<int, QByteArray> names;
    names[NameRole]         = "name";
    names[SpeakerRole]      = "speaker";
    names[StartTimeRole]    = "starttime";
    names[EndTimeRole]      = "endtime";
    names[DescriptionRole]  = "description";
    names[TrackRole]        = "track";
    names[FirstSessionRole] = "firstSession";
    return names;
}

QVariant SessionItem::data(int role) const
{
    switch(role)
    {
        case NameRole:
            return name();

        case SpeakerRole:
            return speaker();

        case StartTimeRole:
            return starttime();

        case EndTimeRole:
            return endtime();

        case DescriptionRole:
            return description();

        case TrackRole:
            return track();

        case FirstSessionRole:
            return firstSession();

        default:
            return QVariant();
    }
}









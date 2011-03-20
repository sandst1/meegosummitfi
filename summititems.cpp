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
                         QObject *parent)
    : ListItem(parent),
      m_name(name),
      m_speaker(speaker),
      m_starttime(starttime),
      m_endtime(endtime),
      m_description(description)
{}

QHash<int, QByteArray> SessionItem::roleNames() const
{
    QHash<int, QByteArray> names;
    names[NameRole]         = "name";
    names[SpeakerRole]      = "speaker";
    names[StartTimeRole]    = "starttime";
    names[EndTimeRole]      = "endtime";
    names[DescriptionRole]  = "description";
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

        default:
            return QVariant();
    }
}









/*
 * MeeGoSummitFI - Timetable application for MeeGo Summit Finland
 * Copyright (C) 2011 Topi Santakivi <topi.santakivi@gmail.com>
 * Copyright (C) 2011 Mikko Rosten <mikko.rosten@iki.fi>
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
import Qt 4.7

MenuItem {
    id: curSessionsDelegate
    height: sessionBar.height

    function isCurrent(startTime, endTime) {
        var curDate = Qt.formatDateTime(new Date(), "yyyy-MM-dd")
        var curTime = Qt.formatDateTime(new Date(), "hh:mm");
        if ( startTime <= curTime && endTime > curTime ) {
            return true;
        }
        else {
            return false;
        }
    }

    Column {
        width: parent.width

        Rectangle{

            width: parent.width
            height: 3
            //color: index%2==0 ?  "#eb2a8a": "#57585b"
            color : "#57585b"
        }

        StyledText {
            id: trackName
            color: "#eb2a8a"
            text: track
            visible: (isCurrent(starttime, endtime) || firstSession) ? true : false
        }

        Row {
            height: sessionName.height + sessionSpeaker.height + 30
            width: parent.width
            spacing: 15
            Rectangle{
                id: sessionBar
                height: parent.height
                width: 10
                color: index%2==0 ?  "#eb2a8a": "#1476bb"
            }

            StyledText {
                id: sessionTime
                text: starttime + "-" + endtime
                color: isCurrent(starttime, endtime) ? "yellow" : "#1476bb"
            }

            Column {
                height: children.height
                width: parent.width
                StyledText {
                    id: sessionName
                    text: name
                    wrapMode: Text.WordWrap
                    width: parent.width - (sessionBar.width + sessionTime.width + 30)
                }
                StyledText {
                    id: sessionSpeaker
                    text: speaker
                    color: "#54b87b"
                    visible:  speaker == "" ? "false" : "true"
                    wrapMode: Text.WordWrap
                    width: parent.width - (sessionBar.width + sessionTime.width + 30)
                }
            }
        }
    }
}

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

Screen {
    id: mainScreen   

    Column {
        id: listColumn
        anchors.top: parent.top
        //anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: 240

        ListView {
            id: mainView
            boundsBehavior: Flickable.StopAtBounds

            width: parent.width
            height: 200
            model: daysModel
            delegate: DaysDelegate {
                id: daysDelegate;
            }
        }
    }

    MenuItem {
        id: curSessions
        anchors.top: listColumn.bottom
        height: 100

        MenuText {
            width: parent.width*0.75
            id: dayName
            text: "Now and next";
            color: "#1476bb"
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent;

            onPressed: {
                XMLParser.updateCurrentSessions(true);
            }
        }
    }

    Connections {
        target: XMLParser
        onCurrentSessionsUpdated: {
            screenSwitcher.loadScreen(true, 4, "Now and next", "");
        }
    }

    Component.onCompleted: console.log("MainScreen loaded")
}

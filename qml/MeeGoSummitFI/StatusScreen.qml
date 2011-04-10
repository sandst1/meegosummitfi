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
    id: statusScreen

    function setActiveEvent(){
        //active.text=statusScreen.name

    }

    Timer {
        id:reload
        interval: 60000
        onTriggered: {
            setActiveEvent()
            meegofi.reload
        }
        repeat: true
    }

    Column{
        spacing: 15
        width: parent.width
        height: parent.height
//        StyledText{
//            id: active
//            anchors.horizontalCenter: parent.horizontalCenter
//            text: "#meego"
//        }
        TwitterModel{
            id:meegofi
            phrase: statusScreen.name.replace(/#/,"")
        }
        TwitterDelegate{
            id:twitterDelegate
        }

        ListView{
            id: twitter
            model: meegofi.model
            delegate: twitterDelegate
            width: parent.width
            //height: parent.height - active.height -15
            height: parent.height
            clip: true

            header:
                Text {
                    id: nameText
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: statusScreen.name
                    font.family: "Helvetica"
                    font.bold: true
                    font.pointSize: 18
                    color: "#e80b8a"
                }
        }
    }
    onHideScreen: reload.stop
    onShowScreen: {
        meegofi.reload();
        reload.start();
    }
}

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
    id: mapScreen
    width: 800
    height: 480
    //x: 0
    //y: 0
    anchors.fill: parent
    anchors.centerIn: parent

    Flickable {
        width: 800; height: 420
        contentWidth: image.width; contentHeight: image.height
        boundsBehavior: Flickable.StopAtBounds
        anchors.centerIn: parent

        Image { id: image; source: "../../images/map.png" }
    }
    Rectangle{
        color: "black"
        anchors {
        left: parent.left;
        bottom: parent.bottom;
        bottomMargin: 18;
        leftMargin: 18;
        }
        width: mapBack.width+4
        height: mapBack.height+4
        radius: 10
    }

    TextButton{
        id: mapBack
        anchors {
            left: parent.left;
            bottom: parent.bottom;
            bottomMargin: 20;
            leftMargin: 20;
        }
        text: "Back"

        onClicked:  {
            mapScreen.switchToPrevScreen();
            appViewer.setOrientation(2); // ScreenOrientationAuto
        }
    }

//    Rectangle {
//        color: "#181818"
//        anchors.bottom: parent.bottom
//        width: 200; height: 100
//        StyledText {
//            color: "#FFFFFF"
//            text: "Back"
//        }
//        MouseArea {
//            anchors.fill: parent
//            onPressed: { console.log("onPressed"); }
//            onReleased: { console.log("onReleased"); }
//            onCanceled: { console.log("onCanceled"); }
//            //onClicked: {
//                //mapScreen.openPrevScreen();
//                //appViewer.setOrientation(2); // ScreenOrientationAuto
//        }
//    }
}

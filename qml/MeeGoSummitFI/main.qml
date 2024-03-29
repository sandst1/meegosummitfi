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

// Thanks to Kunal Parmar for providing an example
// about screen switching with QML in his blog:
//
// http://kunalmaemo.blogspot.com/2010/12/simple-view-switching-animation-with-qt.html

Rectangle {
    id: screenSwitcher
    //width: 480
    //height: 800
    width: 800
    height: 480
    color: "#181818"//"#3A3A3C"

    property int curScreen: 0
    property int prevScreen: 0

    function isPortrait() {
        if ( screenSwitcher.width < 500 )
            return true;
        return false;
    }

    Image {
        id: summitLogo
        source: "../../images/summit_logo.png"
        width: 324
        height: 150
        anchors.left: parent.left
        anchors.leftMargin: isPortrait() ? 78 : 0
        anchors.top: parent.top

    }

    Item {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        width: 350
        height: 200

        Text {
            id: nameText
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: screens[curScreen].name
            font.family: "Helvetica"
            font.bold: true
            font.pointSize: 18
            color: "#e80b8a"
            wrapMode: Text.WordWrap
            width: 300

            visible: isPortrait() ? false : true
        }
    }

//        spacing: parent.width/2-updateXMLBtn.width/2-showMapBtn.width/2-status.width/2-10
//        width: parent.width
//        height: backbtn.height
//        anchors.bottom: parent.bottom
        TextButton {
            id:backbtn
            anchors {
                left: parent.left;
                bottom: parent.bottom;
                bottomMargin: 20;
                leftMargin: isPortrait() ? 20 : 115
            }
            text: "Back"

            onClicked:  {
                screens[curScreen].openPrevScreen();
            }
            visible: curScreen > 0 && curScreen != 5 ? true : false
        }
        TextButton {
            id: showMapBtn
            anchors.bottom : parent.bottom
            anchors.bottomMargin : 20
            anchors.left: parent.left
            anchors.leftMargin: 20

            text: "Map"

            visible: curScreen == 0 ? true : false
            onClicked:   {
                appViewer.setOrientation(1); // ScreenOrientationLockLandscape
                screenSwitcher.loadScreen(true, 5, "Tampere map", "")
            }
        }


        TextButton {
            id: updateXMLBtn
            anchors.bottom : parent.bottom
            anchors.bottomMargin : 20
            anchors.horizontalCenter: parent.horizontalCenter
            //anchors.leftMargin: 20
            text: "Update program"

            onClicked:  {
                console.log("UpdateXMLBtn pressed");
                updateXMLDialog.show("Updating the program...");
                XMLParser.updateXML(true);
                updateXMLBtn.visible = false;
            }
            visible: curScreen == 0 ? true : false
        }

        ImageButton{
            id:status
            height: updateXMLBtn.height+10
            width: height
            anchors.bottom : parent.bottom
            anchors.bottomMargin : 20
            anchors.rightMargin: 20
            anchors.right: parent.right
            fillMode: Image.PreserveAspectFit
            source: "../../images/twitter_newbird_blue.png"

            onClicked: screenSwitcher.loadScreen(true, 3, "#meegofi", Qt.formatDateTime(Date(), "dd.MM.yy"));
            visible: curScreen == 0 ? true : false
        }

    ProgressDialog {
        id: updateXMLDialog;
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 20
        width: 300
        height: 50
    }
    Connections {
        target: XMLParser
        onStartingDataUpdate: updateXMLDialog.show("Downloading the program...")
    }

    function loadScreen(goingFwd, screenNumber, screenName, screenDate) {
        prevScreen = curScreen;
        curScreen = screenNumber;

        console.log("main.qml::loadScreen, prev screen: " + prevScreen + ", curScreen: " + curScreen);        

        screens[prevScreen].hide();
        screens[curScreen].show();

        if ( curScreen > 0 && curScreen != 5) {
            updateXMLBtn.visible = false
        } else {
            updateXMLBtn.visible = true
        }

        if ( goingFwd ) {
            screens[curScreen].setNameDate(screenName, screenDate)
        }
    }

    property list<Item> screens: [
        MainScreen {
            parent: screenSwitcher
            onOpenNextScreen:  {
                screenSwitcher.loadScreen(true, 1, screenName, screenDate);
            }
        },
        DayScreen {
            parent: screenSwitcher
            onOpenNextScreen:  {
                screenSwitcher.loadScreen(true, 2, screenName, screenDate);
            }
            onOpenPrevScreen: {
                screenSwitcher.loadScreen(false, 0);
            }
        },
        TrackScreen {
            parent: screenSwitcher
            onOpenPrevScreen: {
                screenSwitcher.loadScreen(false, 1);
            }
        },
        StatusScreen{
            parent: screenSwitcher
            onOpenPrevScreen: {
                screenSwitcher.loadScreen(false, 0);
            }
        },
        CurrentSessionsScreen {
            id: currentSessionsScreen
            parent: screenSwitcher
            onOpenPrevScreen: {
                screenSwitcher.loadScreen(false, 0);
            }
        },
        MapScreen {
            id: tampereMap
            parent: screenSwitcher
            onOpenPrevScreen: {
                screenSwitcher.loadScreen(false, 0);
            }
        }

    ]

    Component.onCompleted: {
        console.log("ScreenSwitcher ready");
        screenSwitcher.curScreen = 0;
        screenSwitcher.prevScreen = 0;
        for (var i = 0; i < 6; i++ ) {
            screens[i].hide();
        }

        screens[0].show();
    }
}

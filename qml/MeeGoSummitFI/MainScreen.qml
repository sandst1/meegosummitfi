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
                screenSwitcher.loadScreen(true, 4, "Now and next", "");
            }
        }
    }
    Component.onCompleted: console.log("MainScreen loaded")
}

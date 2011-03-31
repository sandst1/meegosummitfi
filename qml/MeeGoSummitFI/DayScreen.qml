import Qt 4.7

Screen {
    id: dayScreen

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: parent.height

        ListView {
            id: dayView
            anchors.horizontalCenter: parent.horizontalCenter

            height: parent.height
            width: parent.width
            model: tracksModel
            delegate: TracksDelegate {}

            header: ScreenHeader {
                width: dayScreen.width
                headerText: dayScreen.name
            }
        }

        TextButton {
            id:backbtn
            anchors { left: parent.left; bottom: parent.bottom; bottomMargin:10; leftMargin:10 }
            text: "Back"

            onClicked:  {
                dayScreen.openPrevScreen();
            }
        }
    }

}

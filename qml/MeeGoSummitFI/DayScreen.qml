import Qt 4.7

Screen {
    id: dayScreen

    ListView {
        id: dayView
        anchors.fill: parent
        model: tracksModel
        delegate: TracksDelegate {}
    }

    TextButton {
        anchors { left: parent.left; bottom: parent.bottom; margins: 20 }
        text: "Back"

        onClicked:  {
            dayScreen.openPrevScreen();
        }
    }
}

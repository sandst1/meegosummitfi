import Qt 4.7

Screen {
    id: trackScreen

    ListView {
        id: mainView
        anchors.fill: parent
        model: sessionsModel
        delegate: SessionsDelegate {}
    }

    TextButton {
        anchors { left: parent.left; bottom: parent.bottom; margins: 20 }
        text: "Back"

        onClicked:  {
            trackScreen.openPrevScreen();
        }
    }

}

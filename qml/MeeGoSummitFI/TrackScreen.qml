import Qt 4.7

Screen {
    id: trackScreen

    ListView {
        id: mainView
        width: parent.width
        anchors.top: parent.top
        anchors.bottom: backbtn.top

        snapMode:ListView.SnapToItem
        model: sessionsModel
        delegate: SessionsDelegate {}
    }

    TextButton {
        anchors { left: parent.left; bottom: parent.bottom ; bottomMargin:10; leftMargin:10}
        text: "Back"
        id: backbtn
        onClicked:  {
            trackScreen.openPrevScreen();
        }
    }

}

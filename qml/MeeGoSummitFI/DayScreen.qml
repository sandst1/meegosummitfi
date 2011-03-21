import Qt 4.7

Screen {
    id: dayScreen




    ListView {
        id: dayView
        anchors.horizontalCenter: parent.horizontalCenter

        anchors.top: parent.top
        anchors.bottom: backbtn.top
        width: parent.width

        snapMode:ListView.SnapToItem

        model: tracksModel
        delegate: TracksDelegate {}
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

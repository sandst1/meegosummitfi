import Qt 4.7

Screen {
    id: trackScreen

    Column{
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: parent.height

        ListView {
            id: trackView
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height
            width: parent.width

            model: sessionsModel
            delegate: SessionsDelegate {}

            header: ScreenHeader {
                width: trackScreen.width
                headerText: trackScreen.name
            }
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
}

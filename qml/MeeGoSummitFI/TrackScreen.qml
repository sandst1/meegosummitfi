import Qt 4.7

Screen {
    id: trackScreen
    Column{
        //anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: parent.height
        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            id: summitLogo
            source: "../../images/summit_logo.png"
            width: 324
            height: 150
            visible: parent.width>parent.height ? "false" : "true"
        }
        ListView {
            id: mainView
            width: parent.width
            anchors.top: parent.width>parent.height ? parent.top : summitLogo.bottom
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
}

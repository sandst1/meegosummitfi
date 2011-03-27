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

        Text {
            id: nameText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.width>parent.height ? parent.top : summitLogo.bottom
            text: trackScreen.name
            font.family: "Helvetica"
            font.bold: true
            font.pointSize: 14
            color: "#e80b8a"
        }

        ListView {
            id: mainView
            width: parent.width
            anchors.top: nameText.bottom
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

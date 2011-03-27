import Qt 4.7

Screen {
    id: dayScreen

    Column{
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: parent.height       

        Image {
            id: summitLogo
            anchors.horizontalCenter: parent.horizontalCenter            
            source: "../../images/summit_logo.png"
            width: 324
            height: 150
            visible: parent.width>parent.height ? "false" : "true"
        }

        Text {
            id: nameText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.width>parent.height ? parent.top : summitLogo.bottom
            text: dayScreen.name
            font.family: "Helvetica"
            font.bold: true
            font.pointSize: 14
            color: "#e80b8a"
        }

        ListView {
            id: dayView
            anchors.horizontalCenter: parent.horizontalCenter

            anchors.top: nameText.bottom
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

}

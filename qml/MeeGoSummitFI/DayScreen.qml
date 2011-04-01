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
            clip: true

            height: parent.height
            width: parent.width
            model: tracksModel
            delegate: TracksDelegate { id: tracksDelegate }

            header:
                Text {
                    id: nameText
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: dayScreen.name
                    font.family: "Helvetica"
                    font.bold: true
                    font.pointSize: 14
                    color: "#e80b8a"
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

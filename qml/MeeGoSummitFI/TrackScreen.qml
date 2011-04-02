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
            clip: true

            model: sessionsModel
            delegate: SessionsDelegate {}

            header: Text {
                id: nameText
                anchors.horizontalCenter: parent.horizontalCenter
                text: trackScreen.name
                font.family: "Helvetica"
                font.bold: true
                font.pointSize: 14
                color: "#e80b8a"
            }
        }
    }
}

import Qt 4.7

Screen {
    id: curSessionsScreen

    Column{
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: parent.height

        ListView {
            id: curSessionsView
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height
            width: parent.width
            clip: true

            model: currentSessionsModel
            delegate: CurrentSessionsDelegate {}

            header: Text {
                id: nameText
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Now and next"
                font.family: "Helvetica"
                font.bold: true
                font.pointSize: 14
                color: "#e80b8a"
            }
        }
    }
}

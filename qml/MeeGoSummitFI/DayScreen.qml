import Qt 4.7


Screen {
    id: dayScreen

    Column {
        width: parent.width
        height: parent.height

        ListView {
            id: dayView
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
                    font.pointSize: 18
                    color: "#e80b8a"
                }                        
        }
    }
}

import Qt 4.7

Item {
    id: screenHeader
    width: summitLogo.width
    height: summitLogo.height + 40

    property string headerText: ""
    property bool headerImageVisible: true

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        Image {
            id: summitLogo
            source: "../../images/summit_logo.png"
            width: 324
            height: 150
            visible: screenHeader.headerImageVisible
        }

        Text {
            id: nameText
            anchors.horizontalCenter: parent.horizontalCenter
            text: screenHeader.headerText
            font.family: "Helvetica"
            font.bold: true
            font.pointSize: 14
            color: "#e80b8a"
        }
    }
}

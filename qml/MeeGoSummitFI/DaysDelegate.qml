import Qt 4.7

MenuItem {
    id: daysDelegate

    MenuText {
        text: name;
    }

    MouseArea {
        anchors.fill: parent;
        onClicked: {
            XMLParser.setTracksModel(childlist);
            mainScreen.switchToNextScreen();
        }
    }
}

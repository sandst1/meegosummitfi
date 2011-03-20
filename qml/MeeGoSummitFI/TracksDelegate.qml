import Qt 4.7

MenuItem {
    id: tracksDelegate

    MenuText {
        text: name + " " + location
    }

    MouseArea {
        anchors.fill: parent;
        onClicked: {
            XMLParser.setSessionsModel(childlist);
            dayScreen.switchToNextScreen();
        }
    }            
}

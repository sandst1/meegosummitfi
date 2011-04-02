import Qt 4.7

MenuItem {
    id: daysDelegate   

    function setTextColor(newColor) {
        dayName.color = newColor;
    }

    MenuText {
        width: parent.width*0.75
        height: 100
        id: dayName
        text: name;
        color: "#1476bb"
        anchors.verticalCenter: parent.verticalCenter
    }

    MouseArea {
        anchors.fill: parent;

        onPressed: {
            XMLParser.setTracksModel(childlist);
            mainScreen.switchToNextScreen(name, date);
        }
    }
}

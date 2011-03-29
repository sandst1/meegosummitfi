import Qt 4.7

MenuItem {
    id: daysDelegate   

    function setTextColor(newColor) {
        dayName.color = newColor;
    }

    MenuText {
        id: dayName
        text: name;
        color: "#1476bb"
    }

    MouseArea {
        anchors.fill: parent;

        onReleased: {
            XMLParser.setTracksModel(childlist);
            mainScreen.switchToNextScreen(name, date);
        }                
    }
}

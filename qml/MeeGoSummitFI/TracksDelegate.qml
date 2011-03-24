import Qt 4.7

MenuItem {
    id: tracksDelegate

    Column {
        width: tracksDelegate.ListView.view.width
        Rectangle{
            id: dividerBar
            anchors.horizontalCenter:parent.horizontalCenter
            width: parent.width*0.5
            height: 3
            color: "#57585b"
            //visible: index == 0 ? "false" : "true"
        }
        MenuText {

            text: name + " " + "(" + location + ")"

            color: index % 2 == 0 ? "#1476bb" : "#ffffff"

        }

    }
    MouseArea {

        anchors.fill: parent;

        onClicked: {
            XMLParser.setSessionsModel(childlist);
            dayScreen.switchToNextScreen();
        }
    }
}

import Qt 4.7

MenuItem {
    id: sessionsDelegate    

    Row {
        spacing: 15

        StyledText {
            text: starttime + "-" + endtime
        }

        Column {
            StyledText {
                text: name
            }
            StyledText {
                text: "Speaker: " + speaker
            }
        }
    }

    /*MouseArea {
        anchors.fill: parent;
    }*/
}

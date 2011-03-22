import Qt 4.7

MenuItem {
    id: sessionsDelegate    
    height: 75
    Column {
        width: parent.width

        Rectangle{

            width: parent.width
            height: 3
            //color: index%2==0 ?  "#eb2a8a": "#57585b"
            color : "#57585b"
        }

        Row {
            spacing: 15
            Rectangle{
                height: parent.height
                width: 10
                color: index%2==0 ?  "#eb2a8a": "#1476bb"
            }

            StyledText {
                text: starttime + "-" + endtime
            }

            Column {
                StyledText {
                    text: name
                }
                StyledText {
                    text: "Speaker: " + speaker
                    color: "#54b87b"
                }
            }
        }
    }

    /*MouseArea {
        anchors.fill: parent;
    }*/
}

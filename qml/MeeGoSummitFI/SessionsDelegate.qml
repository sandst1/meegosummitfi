import Qt 4.7

MenuItem {
    id: sessionsDelegate    
    height: 75

    function isCurrent(startTime, endTime) {
        var curDate = Qt.formatDateTime(new Date(), "yyyy-MM-dd")

        if ( curDate.toString() == trackScreen.date )
        {
            var curTime = Qt.formatDateTime(new Date(), "hh:mm");
            if ( startTime <= curTime && endTime > curTime ) {
                return true;
            }
            else {
                return false;
            }
        }
    }

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
                color: isCurrent(starttime, endtime) == true ? "yellow" : "#1476bb"
            }

            Column {
                StyledText {
                    text: name
                }
                StyledText {
                    text: "Speaker: " + speaker
                    color: "#54b87b"
                    visible:  speaker == "" ? "false" : "true"
                }
            }
        }
    }

    /*MouseArea {
        anchors.fill: parent;
    }*/
}

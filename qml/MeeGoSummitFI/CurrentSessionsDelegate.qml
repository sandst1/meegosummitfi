import Qt 4.7

MenuItem {
    id: curSessionsDelegate
    height: sessionBar.height

    function isCurrent(startTime, endTime) {
        var curDate = Qt.formatDateTime(new Date(), "yyyy-MM-dd")
        var curTime = Qt.formatDateTime(new Date(), "hh:mm");
        if ( startTime <= curTime && endTime > curTime ) {
            return true;
        }
        else {
            return false;
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

        StyledText {
            id: trackName
            color: "#eb2a8a"
            text: track
            visible: (isCurrent(starttime, endtime) || firstSession) ? true : false
        }

        Row {
            height: sessionName.height + sessionSpeaker.height + 30
            width: parent.width
            spacing: 15
            Rectangle{
                id: sessionBar
                height: parent.height
                width: 10
                color: index%2==0 ?  "#eb2a8a": "#1476bb"
            }

            StyledText {
                id: sessionTime
                text: starttime + "-" + endtime
                color: isCurrent(starttime, endtime) ? "yellow" : "#1476bb"
            }

            Column {
                height: children.height
                width: parent.width
                StyledText {
                    id: sessionName
                    text: name
                    wrapMode: Text.WordWrap
                    width: parent.width - (sessionBar.width + sessionTime.width + 30)
                }
                StyledText {
                    id: sessionSpeaker
                    text: speaker
                    color: "#54b87b"
                    visible:  speaker == "" ? "false" : "true"
                }
            }
        }
    }
}

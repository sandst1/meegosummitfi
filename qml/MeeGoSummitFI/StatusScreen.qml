import Qt 4.7

Screen {
    id: statusScreen

    function setActiveEvent(){
        //active.text=statusScreen.name

    }

    Timer {
        id:reload
        interval: 1000
        onTriggered: {
            setActiveEvent()
            meegofi.reload
        }
        repeat: true
    }

    Column{
        spacing: 15
        width: parent.width
        height: parent.height
//        StyledText{
//            id: active
//            anchors.horizontalCenter: parent.horizontalCenter
//            text: "#meego"
//        }
        TwitterModel{
            id:meegofi
            phrase: statusScreen.name.replace(/#/,"")
        }
        TwitterDelegate{
            id:twitterDelegate
        }

        ListView{
            id: twitter
            model: meegofi.model
            delegate: twitterDelegate
            width: parent.width
            //height: parent.height - active.height -15
            height: parent.height
            clip: true

            header:
                Text {
                    id: nameText
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: statusScreen.name
                    font.family: "Helvetica"
                    font.bold: true
                    font.pointSize: 18
                    color: "#e80b8a"
                }
        }
    }
    onHideScreen: reload.stop
    onShowScreen: {
        meegofi.reload();
        reload.start();
    }
}

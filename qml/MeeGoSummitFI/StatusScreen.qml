import Qt 4.7

Screen {
    id: statusScreen

    function setActiveEvent(){
        active.text="Active Event"
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
        StyledText{
            id: active
            anchors.horizontalCenter: parent.horizontalCenter
            text: "active event"
        }
        TwitterModel{
            id:meegofi
            phrase: "meegofi"
        }
        TwitterDelegate{
            id:twitterDelegate
        }

        ListView{
            id: twitter
            model: meegofi.model
            delegate: twitterDelegate
            width: parent.width
            height: parent.height - active.height -15
            clip: true
        }
    }
    onHideScreen: reload.stop
    onShowScreen: {
        meegofi.reload();
        reload.start();
    }
}

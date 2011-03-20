import Qt 4.7

Screen {
    id: mainScreen

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        Image {
            id: summitLogo
            source: "../../images/summit_logo.png"
            width: 324
            height: 150
        }

        ListView {
            boundsBehavior: Flickable.StopAtBounds
            id: mainView
            anchors.top: summitLogo.bottom
            anchors.fill: parent
            model: daysModel
            delegate: DaysDelegate {}
        }
    }

    Component.onCompleted: console.log("MainScreen loaded")
}

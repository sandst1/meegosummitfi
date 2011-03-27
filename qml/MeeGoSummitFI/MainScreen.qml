import Qt 4.7

Screen {
    id: mainScreen

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: parent.height
        Image {
            id: summitLogo
            anchors.horizontalCenter: parent.horizontalCenter            
            source: "../../images/summit_logo.png"
            width: 324
            height: 150
        }

        ListView {
            boundsBehavior: Flickable.StopAtBounds
            id: mainView

            width: parent.width
            height: parent.height - summitLogo.height            
            model: daysModel
            delegate: DaysDelegate {}
        }
    }

    Component.onCompleted: console.log("MainScreen loaded")
}

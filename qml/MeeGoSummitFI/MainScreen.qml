import Qt 4.7

Screen {
    id: mainScreen   

    Column {
        anchors.top: parent.top
        anchors.topMargin: 80
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: parent.height

        ListView {
            id: mainView
            boundsBehavior: Flickable.StopAtBounds

            width: parent.width
            height: parent.height - summitLogo.height            
            model: daysModel
            delegate: DaysDelegate {
                id: daysDelegate;
            }
        }
    }
    Component.onCompleted: console.log("MainScreen loaded")
}

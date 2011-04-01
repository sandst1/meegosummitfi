import Qt 4.7

Screen {
    id: mainScreen   

    Column {
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

        ProgressDialog {
            id: updateXMLDialog;
            anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter; }
        }

        TextButton {
            id: updateXMLBtn
            anchors { bottom: parent.bottom; bottomMargin:20; horizontalCenter: parent.horizontalCenter; }
            text: "Update program XML"

            onClicked:  {
                console.log("UpdateXMLBtn pressed")
                updateXMLDialog.show("Updating Program XML")
                XMLParser.updateXML(true)
            }
        }
    }

    Component.onCompleted: console.log("MainScreen loaded")
}

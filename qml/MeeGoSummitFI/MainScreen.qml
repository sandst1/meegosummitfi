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

        Connections {
            target: XMLParser
            onDataAvailable: updateXMLDialog.hide()
        }
    }

    Component.onCompleted: console.log("MainScreen loaded")
}

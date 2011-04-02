import Qt 4.7

Image {
    id: imageButton
    width: 48
    height: 48
    signal clicked
    MouseArea{
        anchors.fill: parent
        onClicked: imageButton.clicked()
    }
}

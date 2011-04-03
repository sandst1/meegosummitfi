import Qt 4.7

Image {
    id: imageButton
    width: 64
    height: 64
    signal clicked
    MouseArea{
        anchors.fill: parent
        onClicked: imageButton.clicked()
    }
}

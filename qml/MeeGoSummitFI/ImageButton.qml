import QtQuick 1.0

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

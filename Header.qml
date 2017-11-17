import QtQuick 2.7

//лейбл приложения

Item {
    width: 500
    height: 70

    Rectangle {
        id: rectHeader
        anchors.fill: parent
        color: color10

        Text {
            id: text1
            text: qsTr("Парсер уникальных слов")
            font.weight: Font.Bold
            font.family: "Tahoma"
            font.pixelSize: 14
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft

            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                margins: 20
            }
        }
    }
}

import QtQuick 2.7
import QtQuick.Controls 2.2

// Панель основных кнопок ("Назад", "Обработать", "Выход")

Item {

    property alias buttonBack: buttonBack       // Кнопка Назад
    property alias buttonProcess: buttonProcess // Кнопка Обработать
    property alias buttonExit: buttonExit       // Кнопка Выход

    width: 500
    height: 50

    Rectangle {
        id: rectangleButtPanel
        color: color13
        anchors.fill: parent

        Button {
            id: buttonBack
            width: 100
            text: qsTr("< Назад")
            highlighted: true
            font.pointSize: 10
            font.family: "Verdana"

            anchors {
                right: buttonProcess.left
                rightMargin: 5
                verticalCenter: parent.verticalCenter
            }

            contentItem: Text {
                text: buttonBack.text
                font: buttonBack.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideLeft
                color: buttonBack.enabled ? buttonBack.down ? color11 : color11 : color12
            }

            background: Rectangle {
                anchors.fill: buttonBack
                color: buttonBack.down ? color12 : color10
                radius: 3
                border.width: 1
                border.color: color12
            }
            onClicked: {
                backend.on_startReadFile(false);
                pageFirst()
                buttonPanel.buttonProcess.enabled = true
            }
        }

        Button {
            id: buttonProcess
            width: 100
            text: qsTr("Обработать")
            highlighted: true
            font.pointSize: 10
            font.family: "Verdana"

            anchors {
                right: buttonExit.left
                rightMargin: 5
                leftMargin: 5
                verticalCenter: parent.verticalCenter
            }

            contentItem: Text {
                text: buttonProcess.text
                font: buttonProcess.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideLeft
                color: buttonProcess.enabled ? buttonProcess.down ? color11 : color11 : color12
            }

            background: Rectangle {
                anchors.fill: buttonProcess
                color: buttonProcess.down ? color12 : color10
                radius: 3
                border.width: 1
                border.color: color12
            }

            onClicked: {
                pageThree()
            }
        }

        Button {
            id: buttonExit
            width: 100
            text: qsTr("Выход")
            highlighted: true
            font.pointSize: 10
            font.family: "Verdana"

            anchors {
                right: parent.right
                rightMargin: 20
                verticalCenter: parent.verticalCenter
            }

            contentItem: Text {
                text: buttonExit.text
                font: buttonExit.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideLeft
                color: buttonExit.enabled ? buttonExit.down ? color11 : color11 : color12
            }

            background: Rectangle {
                anchors.fill: buttonExit
                color: buttonExit.down ? color12 : color10
                radius: 3
                border.width: 1
                border.color: color12
            }

            onClicked: {
                Qt.quit();
            }
        }
    }
}

import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.platform 1.0

//основной экран (Информация и ввод)

Item {
    property alias textProcessMessage: textProcessMessage                   //Инфо работы
    property alias textFieldFileUrl: textFieldFileUrl                       //Поле ввода
    property alias buttonViewFile: buttonViewFile                           //Кнопка Обзор

    property alias textCountLine: textCountLine                             //Текст первой строки
    property alias textCountLineResult: textCountLineResult                 //Текст результата кол-ва строк

    property alias textCountUniqueWords: textCountUniqueWords               //Текст второй строки
    property alias textCountUniqueWordsResult: textCountUniqueWordsResult   //Текст результата кол-ва уник.слов

    property alias fileDialog: fileDialog                                   //Менеджер файлов

    width: 500
    height: 130

    Rectangle {
        id: rectView
        anchors.fill: parent
        color: color13

        Text {
            id: textProcessMessage            
            text: qsTr("Обработка")
            horizontalAlignment: Text.AlignHCenter            
            font.pixelSize: 14            

            anchors {
                top: parent.top
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
        }

        TextField {
            id: textFieldFileUrl
            font.pixelSize: 12
            height: buttonViewFile.height
            placeholderText : qsTr("Выберете файл...")
            horizontalAlignment: Text.AlignLeft
            clip: true

            anchors {
                left: parent.left
                top: textProcessMessage.bottom
                right: buttonViewFile.left

                topMargin: 10
                leftMargin: 20
                rightMargin: 5
            }

            onTextChanged: {
                buttonPanel.buttonProcess.enabled = true
                filePath  = textFieldFileUrl.text
            }
        }

        Button {
            id: buttonViewFile
            width: 100
            text: qsTr("Обзор")
            font.pointSize: 10
            highlighted: true
            font.family: "Verdana"

            anchors {
                top: textFieldFileUrl.top
                right: parent.right
                rightMargin: 20
                leftMargin: 5
            }

            contentItem: Text {
                text: buttonViewFile.text
                font: buttonViewFile.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideLeft
                color: buttonViewFile.enabled ? buttonViewFile.down ? color11 : color11 : color12
            }

            background: Rectangle {
                anchors.fill: buttonViewFile
                color: buttonViewFile.down ? color12 : color10
                radius: 3
                border.width: 1
                border.color: color12
            }

            onClicked: {
                on_fileDialog = true
            }
        }

        Row {
            id: rowResult1
            width: parent.width

            anchors {
                top: textFieldFileUrl.visible ? textFieldFileUrl.bottom : textProcessMessage.bottom
                left: parent.left
                topMargin: 15
                leftMargin: 30
            }

            Text {
                id: textCountLine
                text: qsTr("Количество найденных строк: ")
                font.pixelSize: 12
                width: parent.width / 2.5
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                id: textCountLineResult
                text: countLine
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Row {
            id: rowResult2
            width: parent.width

            anchors {
                top: rowResult1.bottom
                left: parent.left
                topMargin: 5
                leftMargin: 30
            }

            Text {
                id: textCountUniqueWords
                text: qsTr("Количество уникальных слов: ")
                font.pixelSize: 12
                width: parent.width / 2.5
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                id: textCountUniqueWordsResult
                text: countUniqueWords
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    FileDialog {
        property string url: file
        id: fileDialog
        visible: on_fileDialog
        folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        fileMode: FileDialog.OpenFile
        nameFilters: ["Text files (*.txt)"]

        onAccepted: {
            //console.log("accepted file dialog: " + fileDialog.url)
            on_fileDialog = false
            pageTwo()
        }

        onRejected:     {
            //console.log("close file dialog")
            on_fileDialog = false
        }
    }
}

import QtQuick 2.7
import QtQuick.Controls 2.0


ApplicationWindow {

    property string filePath: ""                //путь+имя файла
    property int countLine: 0                   //количество строк (найденых)
    property int countUniqueWords: 0            //количество уникальных найденных слов

    property bool on_fileDialog: false          //показ менеджера файлов

    property color color10: "#ffffff"           //white
    property color color11: "#000000"           //black
    property color color12: "#bebdbd"           //gray
    property color color13: "#f7f7f7"           //light_gray

    id: mainWindow
    objectName: "mainWindow"
    visible: true
    width: 500
    height: 250
    title: qsTr("Parser of unique words")

    visibility: setMaximumHeight(mainWindow.height) || setMinimumHeight(mainWindow.height) || setMaximumWidth(mainWindow.width) || setMinimumWidth(mainWindow.width)
    flags:  Qt.Window |Qt.WindowMinimizeButtonHint | Qt.WindowCloseButtonHint | Qt.WindowTitleHint |Qt.WindowSystemMenuHint

    Component.onCompleted: {
        pageFirst()
    }

    Column {

        Header {
            //Лейбл приложения
        }

        Rectangle {
            id: separator1
            width: parent.width
            height: 1
            color: color12
        }

        PrimaryView {
            //Основная часть экрана
            id: primaryView
        }

        Rectangle {
            id: separator2
            width: parent.width
            height: 1
            color: color12
        }

        ButtonPanel {
            //Панель кнопок
            id: buttonPanel
        }

    }

    //Первое состояние интерфейса. Начало работы
    function pageFirst() {
        buttonPanel.buttonBack.visible = false
        buttonPanel.buttonProcess.enabled = false

        primaryView.buttonViewFile.enabled = true
        primaryView.textCountLine.visible = false

        primaryView.textCountLineResult.visible = false
        primaryView.textCountUniqueWords.visible = false
        primaryView.textCountUniqueWordsResult.visible = false        

        primaryView.textFieldFileUrl.enabled = true
        primaryView.textFieldFileUrl.visible = true

        primaryView.buttonViewFile.visible = true

        primaryView.textProcessMessage.text = "Выберите файл для обработки"

        countLine = 0
        countUniqueWords = 0
    }

    //Второе состояние интерефейса. Выбрали файл для обработки
    function pageTwo() {
        countLine = 0
        countUniqueWords = 0

        buttonPanel.buttonBack.visible = false
        buttonPanel.buttonProcess.enabled = true

        primaryView.buttonViewFile.enabled = true

        primaryView.textCountLine.visible = false
        primaryView.textCountLineResult.visible = false
        primaryView.textCountUniqueWords.visible = false
        primaryView.textCountUniqueWordsResult.visible = false

        primaryView.textFieldFileUrl.visible = true
        primaryView.textFieldFileUrl.enabled = true                

        filePath = primaryView.fileDialog.url
        primaryView.textFieldFileUrl.text = filePath

        primaryView.textProcessMessage.text = "Обработать файл?"                
    }

    //Третье состояние интерфейса. Обработка файла и вывод результатов.
    function pageThree() {
        countLine = 0
        countUniqueWords = 0

        buttonPanel.buttonBack.visible = true
        buttonPanel.buttonProcess.enabled = false

        primaryView.buttonViewFile.enabled = false

        primaryView.textCountLine.visible = true
        primaryView.textCountLineResult.visible = true
        primaryView.textCountUniqueWords.visible = true
        primaryView.textCountUniqueWordsResult.visible = true

        primaryView.textFieldFileUrl.visible = true
        primaryView.textFieldFileUrl.enabled = false

        primaryView.textProcessMessage.text = "Обрабатываю..."

        backend.on_startReadFile(true);
        backend.on_readFile(filePath)
    }

    //Четвертое состояние. завершение работы и вывод результатов.
    function pageFour() {
        primaryView.buttonViewFile.enabled = true

        primaryView.textFieldFileUrl.enabled = true
        primaryView.textFieldFileUrl.visible = false

        primaryView.buttonViewFile.visible = false

        primaryView.textProcessMessage.text = "Завершено!"
    }

}

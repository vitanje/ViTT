#include "backend.h"

#include <QtDebug>
#include <QtCore/QThread>

//основной

Backend::Backend(QObject *parent) :
    QObject(parent), backend(this)
{
    QTextCodec* codec = QTextCodec::codecForName("UTF-8");
    QTextCodec::setCodecForLocale(codec);

    p_engine = new QQmlApplicationEngine();
    p_engine->load(QUrl(QLatin1String("qrc:/main.qml")));

    if (p_engine->rootObjects().isEmpty())
        exit(0);

    mainWindow = p_engine->rootObjects().value(0);
    p_engine->rootContext()->setContextProperty("backend", this);
}

//Инициализация дополнительного потока и обработчика файлов (parser).
void Backend::init()
{
    QThread * p_thread = new QThread();
    p_parser = new Parser();

    QObject::connect(p_thread, &QThread::finished, backend, &QObject::deleteLater);
    QObject::connect(p_thread, &QThread::finished, p_thread, &QObject::deleteLater);
    QObject::connect(p_thread, &QThread::finished, p_parser, &QObject::deleteLater);

    QObject::connect(backend, &Backend::readFile, p_parser, &Parser::on_readFile);
    QObject::connect(backend, &Backend::startReadFile, p_parser, &Parser::on_startReadFile);//, Qt::DirectConnection);
    QObject::connect(p_parser, &Parser::endProcessing, backend, &Backend::on_endProcessing);
    QObject::connect(p_parser, &Parser::countLine, backend, &Backend::on_countLine);
    QObject::connect(p_parser, &Parser::countUniqueWords, backend, &Backend::on_countUniqueWords);
    QObject::connect(p_parser, &Parser::errorOpenFile, backend, &Backend::on_errorOpenFile);

    p_parser->moveToThread(p_thread);
    p_thread->start();
}

//Слот (из QML) для передачи парсеру пути файла
void Backend::on_readFile(QUrl filePath)
{
    emit readFile(filePath);
}

//Слот (из QML) для запуска или остановки файлового парсера
void Backend::on_startReadFile(bool on_off)
{    
    emit startReadFile(on_off);
}

//Слот (от Parser) завершение работы парсера
void Backend::on_endProcessing()
{    
    QMetaObject::invokeMethod(mainWindow, "pageFour");
}

//Слот (от Parser) обновляет переменную в QML (кол-во считанных строк)
void Backend::on_countLine(int countLine)
{    
    mainWindow->setProperty("countLine", countLine);
}

//Слот (от Parser) обновляет переменную в QML (кол-во уникальных слов)
void Backend::on_countUniqueWords(int countUniqueWords)
{    
    mainWindow->setProperty("countUniqueWords", countUniqueWords);
}

//Слот ошибка чтения файла
void Backend::on_errorOpenFile()
{
    QMetaObject::invokeMethod(mainWindow, "errorOpenFile");
}


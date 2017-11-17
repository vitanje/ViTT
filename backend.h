#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTextCodec>

#include "parser.h"

class Backend : public QObject
{
    Q_OBJECT
public:
    explicit Backend(QObject *parent = nullptr);
    void init();
signals:
    void readFile(QUrl filePath);       //Задать путь к файлу
    void startReadFile(bool on_off);    //Пуск/стоп чтения файла
public slots:    
    void on_readFile(QUrl filePath);    //Путь к файлу
    void on_startReadFile(bool on_off); //Пуск/стоп алгоритма чтения+обработки файла
    void on_endProcessing();            //Слот завершения работы парсера
    void on_countLine(int);             //Слот колиичество найденных строк
    void on_countUniqueWords(int);      //Количество кникальных слов
    void on_errorOpenFile();            //Слот ошибка чтения файла
private:
    Backend * backend;
    Parser * p_parser;
    QQmlApplicationEngine * p_engine;
    QObject * mainWindow;
};


#endif // BACKEND_H

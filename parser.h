#ifndef PARSER_H
#define PARSER_H

#include <QObject>
#include <QSet>
#include <QUrl>

class Parser : public QObject
{
    Q_OBJECT
public:
    explicit Parser();
    void parser(QString line);
signals:
    void endProcessing();               //Завершения работы парсера
    void countLine(int count);          //Колиичество найденных строк
    void countUniqueWords(int count);   //Количество кникальных слов

public slots:    
    void on_readFile(QUrl filePath);    //Путь к файлу
    void on_startReadFile(bool on_off); //Пуск/стоп алгоритма чтения+обработки файла
private:
    QSet<QString> * bookWords;          //Словарь слов
    bool b_readFile = false;            //Флаг остановки цикла
};

#endif // PARSER_H
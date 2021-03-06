#include "parser.h"

#include <QFile>
#include <QTextStream>
#include <QDebug>
#include <QCoreApplication>     // Для QCoreApplication::processEvents();


// файловый парсер считывающий построчно текстовый файл
Parser::Parser()
{    
    bookWords =  new QSet<QString>; // Инициализация словаря слов
}

// Фильтр и наполнение словаря уникальными словами
inline void Parser::parser(QString line)
{    
    QString str = line.remove(QRegExp("[?!.;,:]"));
    QStringList list = str.split(" ", QString::SkipEmptyParts);

    // Алгоритм определения уникальности слова
    foreach(QString word, list) {
        if(!bookWords->contains(word)) {            
            bookWords->insert(word);
            emit countUniqueWords(bookWords->count());
        }
    }
}

// Слот (от Backend) установка пути файла для чтения
void Parser::on_readFile(QUrl filePath)
{    
    bookWords->clear();
    int _countLine = 0; // Количество строк (найденых)

    QFile file(filePath.toLocalFile());    
    if (!file.open(QFile::ReadOnly | QFile::Text))
    {
        qDebug() << "file not open:" << filePath;
        emit errorOpenFile();
    } else {
        QTextStream in(&file);
        while(!in.atEnd() && b_readFile) // Флаг остановки цикла
        {                        
            parser(in.readLine());
            emit countLine(++_countLine);
            QCoreApplication::processEvents();// Проверка очереди EventLoop
        }        

        // Штатное завершение работы чтения файла.
        if(b_readFile) {
            emit endProcessing();
        }
        file.close();
    }
}

// Слот флага остановки чтения файла
void Parser::on_startReadFile(bool on_off)
{        
    b_readFile = on_off; 
}


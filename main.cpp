#include "backend.h"
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QDateTime>
#include <QFile>
#include <QTextStream>

#include <QTextCodec>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);    

    Backend backend;
    backend.init();

    qDebug() << "Start";

    return app.exec();
}

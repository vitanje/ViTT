#include "backend.h"

#include <QApplication>


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);    

    Backend backend;
    backend.init();    

    return app.exec();
}

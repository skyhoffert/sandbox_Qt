
#include <stdio.h>

#include <QApplication>
#include <QDebug>
#include <QWidget>

int main(int argc, char* argv[]) {
    printf("Hello from printf.\n");

    QApplication app(argc, argv);

    qDebug() << "Hello from qdebug.";

    QWidget window;
    
    window.resize(250, 150);
    window.setWindowTitle("Simple example");
    window.show();

    return app.exec();
}

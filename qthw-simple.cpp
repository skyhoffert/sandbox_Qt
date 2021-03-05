
#include <stdio.h>

#include <QString>

int main(int argc, char* argv[]) {
    printf("Hello from printf.\n");

    QString str = "Hello from qdebug (QString).";

    qDebug("%s", qUtf8Printable(str));

    return 0;
}

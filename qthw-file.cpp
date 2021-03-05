
#include <stdio.h>

#include <QString>
#include <QFile>
#include <QTextStream>
#include <QDateTime>

QString GenHeading();

int main(int argc, char* argv[]) {
    printf("Hello from printf.\n");

    QString str = "Hello from qdebug (QString).";

    qDebug("%s", qUtf8Printable(str));

    qsrand(QDateTime::currentMSecsSinceEpoch());

    QFile file("file.txt");

    if (file.open(QIODevice::WriteOnly | QIODevice::Append)) {
        QTextStream fout(&file);
        QDateTime now = QDateTime::currentDateTime();
        fout << now.toString("MMM-dd-yyyy hh:mm:ss.zzz | ") << GenHeading() << "\n";
    } else {
        qDebug("bad write");
    }


    return 0;
}

QString GenHeading() {
    const QString possibleCharacters("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789");
    const int randomStringLength = 10;

    QString randomString;
    for(int i=0; i<randomStringLength; ++i)
    {
        int index = qrand() % possibleCharacters.length();
        QChar nextChar = possibleCharacters.at(index);
        randomString.append(nextChar);
    }

    return randomString;
}

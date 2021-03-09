
#ifndef QTOBJ_SC_H
#define QTOBJ_SC_H

#include <QObject>

class MyObj : public QObject {
    Q_OBJECT

public:
    MyObj(QObject* parent = 0);
    ~MyObj();

signals:
    void MySignal();

public slots:
    void MySlot();

};

#endif


#include "qtthread-c.h"

HelloThread::HelloThread() {
    this->wait_time = 1900 + (qrand() % 200);
}

void HelloThread::run() {
    void* thread_id = thread()->currentThreadId();
    qDebug() << "[" << thread_id << "] Hello from worker thread.";

    qDebug() << "[" << thread_id << "] Waiting for" << wait_time << "ms.";
    int64_t start = CurrentTimeMS();
    int64_t now = start;

    while (now - start < wait_time) {
        now = CurrentTimeMS();
    }

    qDebug() << "[" << thread_id << "] Done!";
}

#include "moc/qtthread-c-moc.cpp"

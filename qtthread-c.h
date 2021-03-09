
#ifndef WORKER_H
#define WORKER_H

#include <QDebug>
#include <QThread>

#include <cstdint>
#include <sys/time.h>

static inline int64_t CurrentTimeMS() {
    struct timeval tp;
    gettimeofday(&tp, NULL);
    return tp.tv_sec * 1000 + tp.tv_usec / 1000;
}

class HelloThread : public QThread {
    Q_OBJECT

public:
    HelloThread();

private:
    void run();
    int64_t wait_time;
    int64_t deviation;
};

#endif

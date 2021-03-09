
#include "qtthread-c.h"

#include <QtCore>

int main(int argc, char* argv[]) {
    printf("Starting qtthread.\n");

    qsrand(CurrentTimeMS());

    QCoreApplication app(argc, argv);

    int num_threads = 10;
    HelloThread* threads[num_threads];
    int threads_alive[num_threads];

    for (int i = 0; i < num_threads; ++i) {
        threads[i] = new HelloThread();
        threads[i]->start();
        threads_alive[i] = 1;
    }

    qDebug() << "[" << app.thread()->currentThreadId() << "] Hi from main.";

    int still_alive = num_threads;
    while (still_alive > 0) {
        still_alive = 0;

        for (int i = 0; i < num_threads; ++i)
        {
            if (threads_alive[i] == 1) {
                if (threads[i]->isFinished()) {
                    threads[i]->wait();
                    delete threads[i];
                    threads_alive[i] = false;
                    qDebug() << "[MAIN] Joined" << i;
                } else {
                    ++still_alive;
                }
            }
        }
    }

    printf("Exiting qtthread.\n");
    return 0;
}

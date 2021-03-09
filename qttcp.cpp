
#include <errno.h>
#include <stdio.h>
#include <stdint.h>
#include <sys/time.h>

#include <QtCore>
#include <QtNetwork>

int64_t CurrentTime();
int msleep(long msec);

int main(int argc, char* argv[]) {
    printf("Starting qttcp.\n");

    if (argc != 3) {
        printf("ERR. Incorrect argc.\n");
        return 1;
    }

    int port_rx = atoi(argv[1]);
    int port_tx = atoi(argv[2]);

    printf("rx=%d, tx=%d\n", port_rx, port_tx);

    QTcpSocket* sock = new QTcpSocket(NULL);

    sock->connectToHost(QHostAddress::LocalHost, port_tx);

    if (sock->waitForConnected(2000)) {
        printf("Connected!\n");

        QString data = QString("AAA\n");
        sock->write(data.toLocal8Bit());

        QByteArray buffer;
        int rx_len = sock->bytesAvailable();
        int64_t start = CurrentTime();
        int64_t timeout = 3000;

        // Wait until there is a pending datagram.
        while (rx_len == 0) {
            int64_t now = CurrentTime();

            if (now - start > timeout) { break; }

            msleep(100);

            rx_len = sock->bytesAvailable();
        }

        if (rx_len >= 1) {
            QHostAddress sender_addr;
            uint16_t sender_port;

            buffer = sock->readAll();

            QByteArray sender_addr_bytes = sender_addr.toString().toLocal8Bit();
            printf("Got data from %s:%d\n", sender_addr_bytes.data(), sender_port);
            printf(">   %s\n", buffer.data());

            data = QString("CCC\n");
            sock->write(data.toLocal8Bit());
        }
    } else {
        printf("Could not connect... (%s) \n", sock->errorString().toUtf8().data());

        sock->close();

        QTcpServer* serv = new QTcpServer(NULL);

        serv->listen(QHostAddress::Any, port_rx);

        if (serv->waitForNewConnection(10000)) {
            printf("Got connection.\n");

            QTcpSocket* newsock = serv->nextPendingConnection();

            QString data = QString("BBB\n");
            newsock->write(data.toLocal8Bit());

            QByteArray buffer;
            bool crl = newsock->canReadLine();
            int64_t start = CurrentTime();
            int64_t timeout = 3000;

            // Wait until there is a pending data.
            while (crl == false) {
                int64_t now = CurrentTime();

                if (now - start > timeout) { break; }

                msleep(100);

                crl = newsock->canReadLine();
            }

            if (crl == true) {
                QHostAddress sender_addr;
                uint16_t sender_port;

                buffer = newsock->readLine();

                QByteArray sender_addr_bytes = sender_addr.toString().toLocal8Bit();
                printf("Got data from %s:%d\n", sender_addr_bytes.data(), sender_port);
                printf(">   %s\n", buffer.data());

                data = QString("DDD\n");
                newsock->write(data.toLocal8Bit());
            } else {
                buffer = newsock->readLine();

                printf("%s\n", buffer.data());
            }

            newsock->close();
        } else {
            printf("No connection.\n");
        }
    }

    sock->close();
    delete sock;

    printf("Exiting qttcp.\n");
    
    return 0;
}

int64_t CurrentTime(){
    struct timeval tp;
    gettimeofday(&tp, NULL);
    return tp.tv_sec * 1000 + tp.tv_usec / 1000;
}

int msleep(long msec)
{
    struct timespec ts;
    int res;

    if (msec < 0)
    {
        errno = EINVAL;
        return -1;
    }

    ts.tv_sec = msec / 1000;
    ts.tv_nsec = (msec % 1000) * 1000000;

    do {
        res = nanosleep(&ts, &ts);
    } while (res && errno == EINTR);

    return res;
}

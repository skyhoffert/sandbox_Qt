
#include <errno.h>
#include <stdio.h>
#include <stdint.h>
#include <sys/time.h>

#include <QtCore>
#include <QtNetwork>

int64_t CurrentTime();
int msleep(long msec);

int main(int argc, char* argv[]) {
    printf("Starting qtudp.\n");

    int port_rx = atoi(argv[1]);
    int port_tx = atoi(argv[2]);

    printf("rx=%d, tx=%d\n", port_rx, port_tx);

    QUdpSocket* sock = new QUdpSocket(NULL);

    sock->bind(QHostAddress::LocalHost, port_rx);

    QString data = QString("Hello %1 from %2!").arg(QString::number(port_tx), QString::number(port_rx));
    sock->writeDatagram(data.toLocal8Bit(), QHostAddress::LocalHost, port_tx);

    QByteArray buffer;
    int rx_len = sock->pendingDatagramSize();
    int64_t start = CurrentTime();
    int64_t timeout = 10000; // 10 seconds

    // Wait until there is a pending datagram.
    while (rx_len == -1) {
        int64_t now = CurrentTime();

        if (now - start > timeout) { break; }

        msleep(100);

        rx_len = sock->pendingDatagramSize();
    }

    if (rx_len >= 0) {
        buffer.resize(rx_len);

        QHostAddress sender_addr;
        uint16_t sender_port;

        sock->readDatagram(buffer.data(), buffer.size(), &sender_addr, &sender_port);

        QByteArray sender_addr_bytes = sender_addr.toString().toLocal8Bit();
        printf("Got data from %s:%d\n", sender_addr_bytes.data(), sender_port);
        printf(">   %s\n", buffer.data());

        data = QString("Hi %1, I am %2!").arg(QString::number(port_tx), QString::number(port_rx));
        sock->writeDatagram(data.toLocal8Bit(), QHostAddress::LocalHost, port_tx);
    }

    delete sock;

    printf("Exiting qtudp.\n");
    
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

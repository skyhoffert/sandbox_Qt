
LDLIBS=-lpthread
QLIBS=-lQt5Core -lQt5Gui -lQt5Widgets -lQt5Network
INCLUDE := -Iinclude/ \
		-I/home/sky/Qt5.9.5/5.9.5/gcc_64/include \
		-I/home/sky/Qt5.9.5/5.9.5/gcc_64/include/QtWidgets \
		-I/home/sky/Qt5.9.5/5.9.5/gcc_64/include/QtCore \
		-I/home/sky/Qt5.9.5/5.9.5/gcc_64/include/QtGui \
		-I/home/sky/Qt5.9.5/5.9.5/gcc_64/include/QtNetwork
LINKS=-L/home/sky/Qt5.9.5/5.9.5/gcc_64/lib
CC=gcc
CX=g++
CXFLAGS=-fPIC -std=c++11
CCX=arm-linux-gnueabi-gcc
CXX=arm-linux-gnueabi-g++
QINCLUDE := -Iinclude/ \
		-I/usr/local/Qt-5.9.5/include/ \
		-I/usr/local/Qt-5.9.5/include/QtWidgets \
		-I/usr/local/Qt-5.9.5/include/QtCore \
		-I/usr/local/Qt-5.9.5/include/QtGui \
		-I/usr/local/Qt-5.9.5/include/QtNetwork
QLINKS=-L/usr/local/Qt-5.9.5/lib

all: hw hw-arm mhw mhw-arm \
	qthw qthw-arm qthw-simple qthw-simple-arm \
	qthw-file qthw-file-arm \
	qtudp qtudp-arm

clean:
	rm -f hw hw-arm mhw mhw-arm \
	qthw qthw-arm qthw-simple qthw-simple-arm \
	qthw-file qthw-file-arm \
	qtudp qtudp-arm

hw: hw.c
	$(CC) -o hw hw.c

hw-arm: hw.c
	$(CCX) -o hw-arm hw.c

mhw: mhw.c
	$(CC) -o mhw mhw.c $(LDLIBS)

mhw-arm: mhw.c
	$(CCX) -o mhw-arm mhw.c $(LDLIBS)

qthw: qthw.cpp
	$(CX) $(CXFLAGS) $(LINKS) $(INCLUDE) -o qthw qthw.cpp $(QLIBS)

qthw-arm: qthw.cpp
	$(CXX) $(CXFLAGS) $(QLINKS) $(QINCLUDE) -o qthw-arm qthw.cpp $(QLIBS)

qthw-simple: qthw-simple.cpp
	$(CX) $(CXFLAGS) $(LINKS) $(INCLUDE) -o qthw-simple qthw-simple.cpp $(QLIBS)

qthw-simple-arm: qthw-simple.cpp
	$(CXX) $(CXFLAGS) $(QLINKS) $(QINCLUDE) -o qthw-simple-arm qthw-simple.cpp $(QLIBS)

qthw-file: qthw-file.cpp
	$(CX) $(CXFLAGS) $(LINKS) $(INCLUDE) -o qthw-file qthw-file.cpp $(QLIBS)

qthw-file-arm: qthw-file.cpp
	$(CXX) $(CXFLAGS) $(QLINKS) $(QINCLUDE) -o qthw-file-arm qthw-file.cpp $(QLIBS)

qtudp: qtudp.cpp
	$(CX) $(CXFLAGS) $(LINKS) $(INCLUDE) -o qtudp qtudp.cpp $(QLIBS)

qtudp-arm: qtudp.cpp
	$(CXX) $(CXFLAGS) $(QLINKS) $(QINCLUDE) -o qtudp-arm qtudp.cpp $(QLIBS)

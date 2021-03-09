
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
MOC=/home/sky/Qt5.9.5/5.9.5/gcc_64/bin/moc

BINDIR=bin
MOCDIR=moc

all: hw hw-arm mhw mhw-arm \
	qthw qthw-arm qthw-simple qthw-simple-arm \
	qthw-file qthw-file-arm \
	qtudp qtudp-arm \
	qtobj qtobj-arm \
	qttcp \
	qtthread qtthread-arm

clean:
	rm -rf $(BINDIR)/*
	rm -rf $(MOCDIR)/*

hw: hw.c
	$(CC) -o $(BINDIR)/hw hw.c

hw-arm: hw.c
	$(CCX) -o $(BINDIR)/hw-arm hw.c

mhw: mhw.c
	$(CC) -o $(BINDIR)/mhw mhw.c $(LDLIBS)

mhw-arm: mhw.c
	$(CCX) -o $(BINDIR)/mhw-arm mhw.c $(LDLIBS)

qthw: qthw.cpp
	$(CX) $(CXFLAGS) $(LINKS) $(INCLUDE) -o $(BINDIR)/qthw qthw.cpp $(QLIBS)

qthw-arm: qthw.cpp
	$(CXX) $(CXFLAGS) $(QLINKS) $(QINCLUDE) -o $(BINDIR)/qthw-arm qthw.cpp $(QLIBS)

qthw-simple: qthw-simple.cpp
	$(CX) $(CXFLAGS) $(LINKS) $(INCLUDE) -o $(BINDIR)/qthw-simple qthw-simple.cpp $(QLIBS)

qthw-simple-arm: qthw-simple.cpp
	$(CXX) $(CXFLAGS) $(QLINKS) $(QINCLUDE) -o $(BINDIR)/qthw-simple-arm qthw-simple.cpp $(QLIBS)

qthw-file: qthw-file.cpp
	$(CX) $(CXFLAGS) $(LINKS) $(INCLUDE) -o $(BINDIR)/qthw-file qthw-file.cpp $(QLIBS)

qthw-file-arm: qthw-file.cpp
	$(CXX) $(CXFLAGS) $(QLINKS) $(QINCLUDE) -o $(BINDIR)/qthw-file-arm qthw-file.cpp $(QLIBS)

qtudp: qtudp.cpp
	$(CX) $(CXFLAGS) $(LINKS) $(INCLUDE) -o $(BINDIR)/qtudp qtudp.cpp $(QLIBS)

qtudp-arm: qtudp.cpp
	$(CXX) $(CXFLAGS) $(QLINKS) $(QINCLUDE) -o $(BINDIR)/qtudp-arm qtudp.cpp $(QLIBS)

qtobj-moc: qtobj-sc.h
	$(MOC) -o $(MOCDIR)/qtobj-sc-moc.cpp qtobj-sc.h

qtobj: qtobj-moc qtobj.cpp qtobj-sc.cpp qtobj-sc.h
	$(CX) $(CXFLAGS) $(LINKS) $(INCLUDE) -o $(BINDIR)/qtobj qtobj.cpp qtobj-sc.cpp $(QLIBS)

qtobj-arm: qtobj-moc qtobj.cpp qtobj-sc.cpp qtobj-sc.h
	$(CXX) $(CXFLAGS) $(QLINKS) $(QINCLUDE) -o $(BINDIR)/qtobj-arm qtobj.cpp qtobj-sc.cpp $(QLIBS)

qttcp: qttcp.cpp
	$(CX) $(CXFLAGS) $(LINKS) $(INCLUDE) -o $(BINDIR)/qttcp qttcp.cpp $(QLIBS)

qtthread-moc: qtthread-c.h
	$(MOC) -o $(MOCDIR)/qtthread-c-moc.cpp qtthread-c.h

qtthread: qtthread-moc qtthread.cpp qtthread-c.cpp qtthread-c.h
	$(CX) $(CXFLAGS) $(LINKS) $(INCLUDE) -o $(BINDIR)/qtthread qtthread.cpp qtthread-c.cpp $(QLIBS)

qtthread-arm: qtthread-moc qtthread.cpp qtthread-c.cpp qtthread-c.h
	$(CXX) $(CXFLAGS) $(QLINKS) $(QINCLUDE) -o $(BINDIR)/qtthread-arm qtthread.cpp qtthread-c.cpp $(QLIBS)

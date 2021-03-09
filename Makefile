
# QTPATH is the path to your highest Qt folder for Native compilation.
QTPATH=/home/sky/Qt5.9.5/5.9.5/gcc_64/

# QTPATHX is the path to your Qt folder for Cross compliation.
QTPATHX=/usr/local/Qt-5.9.5/

LDLIBS=-lpthread
QLIBS=-lQt5Core -lQt5Gui -lQt5Widgets -lQt5Network
CPPFLAGS=-fPIC -std=c++11

# Target shouldn't affect which MOC is used.
MOC=$(QTPATH)bin/moc

BINDIR=bin
MOCDIR=moc

CC=gcc
CPP=g++
QINCLUDE := -Iinclude/ \
		-I$(QTPATH)include \
		-I$(QTPATH)include/QtWidgets \
		-I$(QTPATH)include/QtCore \
		-I$(QTPATH)include/QtGui \
		-I$(QTPATH)include/QtNetwork
QLINKS=-L$(QTPATH)lib

CCX=arm-linux-gnueabi-gcc
CPPX=arm-linux-gnueabi-g++
QINCLUDEX := -Iinclude/ \
		-I$(QTPATHX)include/ \
		-I$(QTPATHX)include/QtWidgets \
		-I$(QTPATHX)include/QtCore \
		-I$(QTPATHX)include/QtGui \
		-I$(QTPATHX)include/QtNetwork
QLINKSX=-L$(QTPATHX)lib

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
	$(CPP) $(CPPFLAGS) $(QLINKS) $(QINCLUDE) -o $(BINDIR)/qthw qthw.cpp $(QLIBS)

qthw-arm: qthw.cpp
	$(CPPX) $(CPPFLAGS) $(QLINKSX) $(QINCLUDEX) -o $(BINDIR)/qthw-arm qthw.cpp $(QLIBS)

qthw-simple: qthw-simple.cpp
	$(CPP) $(CPPFLAGS) $(QLINKS) $(QINCLUDE) -o $(BINDIR)/qthw-simple qthw-simple.cpp $(QLIBS)

qthw-simple-arm: qthw-simple.cpp
	$(CPPX) $(CPPFLAGS) $(QLINKSX) $(QINCLUDEX) -o $(BINDIR)/qthw-simple-arm qthw-simple.cpp $(QLIBS)

qthw-file: qthw-file.cpp
	$(CPP) $(CPPFLAGS) $(QLINKS) $(QINCLUDE) -o $(BINDIR)/qthw-file qthw-file.cpp $(QLIBS)

qthw-file-arm: qthw-file.cpp
	$(CPPX) $(CPPFLAGS) $(QLINKSX) $(QINCLUDEX) -o $(BINDIR)/qthw-file-arm qthw-file.cpp $(QLIBS)

qtudp: qtudp.cpp
	$(CPP) $(CPPFLAGS) $(QLINKS) $(QINCLUDE) -o $(BINDIR)/qtudp qtudp.cpp $(QLIBS)

qtudp-arm: qtudp.cpp
	$(CPPX) $(CPPFLAGS) $(QLINKSX) $(QINCLUDEX) -o $(BINDIR)/qtudp-arm qtudp.cpp $(QLIBS)

qtobj-moc: qtobj-sc.h
	$(MOC) -o $(MOCDIR)/qtobj-sc-moc.cpp qtobj-sc.h

qtobj: qtobj-moc qtobj.cpp qtobj-sc.cpp qtobj-sc.h
	$(CPP) $(CPPFLAGS) $(QLINKS) $(QINCLUDE) -o $(BINDIR)/qtobj qtobj.cpp qtobj-sc.cpp $(QLIBS)

qtobj-arm: qtobj-moc qtobj.cpp qtobj-sc.cpp qtobj-sc.h
	$(CPPX) $(CPPFLAGS) $(QLINKSX) $(QINCLUDEX) -o $(BINDIR)/qtobj-arm qtobj.cpp qtobj-sc.cpp $(QLIBS)

qttcp: qttcp.cpp
	$(CPP) $(CPPFLAGS) $(QLINKS) $(QINCLUDE) -o $(BINDIR)/qttcp qttcp.cpp $(QLIBS)

qtthread-moc: qtthread-c.h
	$(MOC) -o $(MOCDIR)/qtthread-c-moc.cpp qtthread-c.h

qtthread: qtthread-moc qtthread.cpp qtthread-c.cpp qtthread-c.h
	$(CPP) $(CPPFLAGS) $(QLINKS) $(QINCLUDE) -o $(BINDIR)/qtthread qtthread.cpp qtthread-c.cpp $(QLIBS)

qtthread-arm: qtthread-moc qtthread.cpp qtthread-c.cpp qtthread-c.h
	$(CPPX) $(CPPFLAGS) $(QLINKSX) $(QINCLUDEX) -o $(BINDIR)/qtthread-arm qtthread.cpp qtthread-c.cpp $(QLIBS)

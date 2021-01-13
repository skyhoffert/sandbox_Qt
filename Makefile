
LDLIBS=-lpthread
QLIBS=-lQt5Core -lQt5Gui -lQt5Widgets
INCLUDE := -Iinclude/ \
		-I/home/pi/Downloads/qt-everywhere-opensource-src-5.9.5/qtbase/include \
		-I/home/pi/Downloads/qt-everywhere-opensource-src-5.9.5/qtbase/include/QtWidgets \
		-I/home/pi/Downloads/qt-everywhere-opensource-src-5.9.5/qtbase/include/QtCore \
		-I/home/pi/Downloads/qt-everywhere-opensource-src-5.9.5/qtbase/include/QtGui
LINKS=-L/home/pi/Downloads/qt-everywhere-opensource-src-5.9.5/qtbase/lib
CC=gcc
CXX=g++
CXXFLAGS=-fPIC

all: hw-arm mhw-arm qthw-arm

clean:
	rm -f hw-arm mhw-arm qthw-arm

hw-arm: hw.c
	$(CC) -o hw-arm hw.c

mhw-arm: mhw.c
	$(CC) -o mhw-arm mhw.c $(LDLIBS)

qthw-arm: qthw.cpp
	$(CXX) $(CXXFLAGS) $(LINKS) $(INCLUDE) -o qthw-arm qthw.cpp $(QLIBS)



LDLIBS=-lpthread
QLIBS=-lQt5Core -lQt5Gui -lQt5Widgets
INCLUDE := -Iinclude/ \
		-I/home/sky/Qt5.9.5/5.9.5/gcc_64/include \
		-I/home/sky/Qt5.9.5/5.9.5/gcc_64/include/QtWidgets \
		-I/home/sky/Qt5.9.5/5.9.5/gcc_64/include/QtCore \
		-I/home/sky/Qt5.9.5/5.9.5/gcc_64/include/QtGui
LINKS=-L/home/sky/Qt5.9.5/5.9.5/gcc_64/lib
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
	$(CXX) $(CXXFLAGS) $(LINKS) $(INCLUDE) -o qthw qthw.cpp $(QLIBS)


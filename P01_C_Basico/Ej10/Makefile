CC = gcc
CFLAGS = -Wall -Wextra -pedantic
TARGET = control

all: $(TARGET)

$(TARGET): control.o
	$(CC) $(CFLAGS) $^ -o $@

control.o: control.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm *.o $(TARGET)

.PHONY: all clean
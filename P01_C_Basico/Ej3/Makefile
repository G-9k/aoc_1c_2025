CC = gcc
CFLAGS = -Wall -Wextra -pedantic
TARGET = dataTypes

all: $(TARGET)

$(TARGET): dataTypes.o
	$(CC) $(CFLAGS) $^ -o $@

dataTypes.o: dataTypes.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm *.o $(TARGET)

.PHONY: all clean

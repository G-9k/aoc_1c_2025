CC = gcc
CFLAGS = -Wall -Wextra -pedantic
TARGET = scope

all: $(TARGET)

$(TARGET): scope.o
	$(CC) $(CFLAGS) $^ -o $@

scope.o: scope.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm *.o $(TARGET)

.PHONY: all clean
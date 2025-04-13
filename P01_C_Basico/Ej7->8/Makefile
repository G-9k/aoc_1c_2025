CC = gcc
CFLAGS = -Wall -Wextra -pedantic
TARGET = operators

all: $(TARGET)

$(TARGET): operators.o
	$(CC) $(CFLAGS) $^ -o $@

operators.o: operators.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm *.o $(TARGET)

.PHONY: all clean
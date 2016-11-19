# Makefile for building the firmware

# CPU configurations
MCU := atmega328p
F_CPU := 16000000UL

# how to hook up the arduino via USB.
# On Windows, try something like:
#  PORT := COM5
# On Linux, e.g. when connected to a Raspi, try:
#  PORT := /dev/ttyUSB0
PORT := /dev/ttyUSB0

NAME := pilight_usb_nano

OBJ := $(NAME).o
SRC := $(NAME).c
DST := $(NAME)
FIRMWARE := $(NAME).hex


build: $(FIRMWARE)


flash: $(FIRMWARE)
	avrdude -b 57600 -p $(MCU) -c arduino -P $(PORT) -U flash:w:$(FIRMWARE)


$(OBJ): $(SRC)
	avr-gcc -Os -Wall -DF_CPU=$(F_CPU) -mmcu=$(MCU) -c -o $(OBJ) $(SRC) -lm -I.

$(DST): $(OBJ)
	avr-gcc -mmcu=$(MCU) $(OBJ) -o $(DST)

$(FIRMWARE): $(NAME)
	avr-objcopy -O ihex -R .eeprom $(NAME) $(FIRMWARE)

clean:
	rm -f $(DST) $(OBJ) $(FIRMWARE)

.PHONY: clean flash


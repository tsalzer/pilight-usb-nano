# Makefile for building the firmware

MCU=atmega328p

NAME=pilight_usb_nano

all: $(NAME).hex


$(NAME).o: $(NAME).c
	avr-gcc -Os -Wall -DF_CPU=16000000UL -mmcu=$(MCU) -c -o $(NAME).o $(NAME).c -lm -I.

$(NAME): $(NAME).o
	avr-gcc -mmcu=$(MCU) $(NAME).o -o $(NAME)

$(NAME).hex: $(NAME)
	avr-objcopy -O ihex -R .eeprom $(NAME) $(NAME).hex


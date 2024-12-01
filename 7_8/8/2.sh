#!/bin/bash

# Проверка наличия двух аргументов
if [ $# -ne 2 ]; then
  echo "Использование: $0 <число1> <число2>"
  exit 1
fi

# Получение чисел из аргументов
num1=$1
num2=$2

# Сравнение чисел
if [ "$num1" -gt "$num2" ]; then
  echo "$num1 больше $num2"
elif [ "$num1" -lt "$num2" ]; then
  echo "$num1 меньше $num2"
else
  echo "$num1 равно $num2"
fi

#!/bin/bash

# Функция для сложения двух чисел
add() {
  local num1=$1
  local num2=$2
  local sum=$((num1 + num2))
  echo "Сумма: $sum"
}

# Вызов функции с двумя аргументами
read -p "Введите первое число: " a
read -p "Введите второе число: " b

add "$a" "$b"

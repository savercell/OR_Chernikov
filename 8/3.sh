#!/bin/bash

# Проверка наличия аргумента (длина пароля)
if [ $# -ne 1 ]; then
  echo "Использование: $0 <длина_пароля>"
  exit 1
fi

# Получение длины пароля
password_length=$1

# Генерация пароля
password=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c "$password_length")

# Вывод пароля
echo "Сгенерированный пароль: $password"

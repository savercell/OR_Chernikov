#!/bin/bash

# Проверка наличия аргумента
if [ -z "$1" ]; then
  echo "Ошибка: укажите имя файла."
  exit 1
fi

# Получение имени файла из аргумента
filename="$1"

# Проверка существования файла
if [ ! -f "$filename" ]; then
  echo "Ошибка: файл '$filename' не найден."
  exit 1
fi

# Подсчет количества строк в файле
line_count=$(wc -l < "$filename")

# Вывод результата
echo "Количество строк в файле '$filename': $line_count"

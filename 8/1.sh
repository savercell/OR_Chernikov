#!/bin/bash

# Проверка наличия аргументов
if [ $# -ne 2 ]; then
  echo "Использование: $0 <имя_файла> <слово>"
  exit 1
fi

# Получение аргументов
filename=$1
word=$2

# Проверка существования файла
if [ ! -f "$filename" ]; then
  echo "Ошибка: файл '$filename' не найден."
  exit 1
fi

# Подсчет количества вхождений слова
count=$(grep -o -w "$word" "$filename" | wc -l)

# Вывод результата
echo "Слово '$word' встречается в файле '$filename' $count раз(а)."

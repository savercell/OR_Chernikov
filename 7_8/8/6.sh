#!/bin/bash

# Запрос пути к файлу от пользователя
read -p "Введите путь к файлу для отслеживания: " filepath

# Проверка, существует ли файл
if [ ! -f "$filepath" ]; then
  echo "Ошибка: файл '$filepath' не найден."
  exit 1
fi

# Отслеживание изменений файла с использованием inotifywait
echo "Начало отслеживания изменений файла '$filepath'. Для выхода нажмите Ctrl+C."
inotifywait -m -e modify "$filepath" |
while read path action file; do
  echo "Файл '$file' был изменен в $path"
done

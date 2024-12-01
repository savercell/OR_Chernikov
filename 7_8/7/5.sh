#!/bin/bash

# Запрос пути к директории от пользователя
read -p "Введите путь к директории: " dirpath

# Проверка, существует ли директория
if [ ! -d "$dirpath" ]; then
  echo "Ошибка: директория не найдена."
  exit 1
fi

# Перебор всех файлов в директории
for file in "$dirpath"/*; do
  # Проверка, является ли объект файлом
  if [ -f "$file" ]; then
    # Извлечение имени файла и добавление префикса
    base_name=$(basename "$file")
    mv "$file" "$dirpath/backup_$base_name"
  fi
done

echo "Префиксы 'backup_' добавлены ко всем файлам в '$dirpath'."

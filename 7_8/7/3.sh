#!/bin/bash

# Запрос пути к директории от пользователя
read -p "Введите путь к директории для архивации: " dirpath

# Проверка, существует ли директория
if [ ! -d "$dirpath" ]; then
  echo "Ошибка: директория не найдена."
  exit 1
fi

# Получение текущей даты в формате ГГГГ-ММ-ДД
current_date=$(date +%Y-%m-%d)

# Формирование имени архива
archive_name="$(basename "$dirpath")_$current_date.tar.gz"

# Создание архива
tar -czf "$archive_name" "$dirpath"

# Вывод успешного сообщения
echo "Архив $archive_name успешно создан."

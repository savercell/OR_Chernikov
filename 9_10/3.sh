#!/bin/bash

# Запрос параметров подключения к удаленному серверу
read -p "Введите удаленный сервер (user@hostname): " remote_server
read -p "Введите путь к удаленной директории для архивирования: " remote_dir
read -p "Введите локальный путь для сохранения архива: " local_dir

# Проверка существования локальной директории
if [ ! -d "$local_dir" ]; then
  echo "Создание локальной директории '$local_dir'..."
  mkdir -p "$local_dir"
fi

# Имя архива с текущей датой
archive_name="backup_$(date +'%Y-%m-%d_%H-%M-%S').tar.gz"

echo "Архивирование удаленной директории..."

# Архивирование директории на удаленном сервере
ssh "$remote_server" "tar -czf /tmp/$archive_name -C $remote_dir ."

if [ $? -eq 0 ]; then
  echo "Архив успешно создан: /tmp/$archive_name"
else
  echo "Ошибка при создании архива на удаленном сервере."
  exit 1
fi

echo "Скачивание архива на локальный компьютер..."

# Скачивание архива на локальную машину
scp "$remote_server:/tmp/$archive_name" "$local_dir"

if [ $? -eq 0 ]; then
  echo "Архив успешно скачан в директорию '$local_dir'."
else
  echo "Ошибка при скачивании архива."
  exit 1
fi

echo "Разархивирование архива..."

# Разархивирование скачанного архива
tar -xzf "$local_dir/$archive_name" -C "$local_dir"

if [ $? -eq 0 ]; then
  echo "Архив успешно разархивирован в директорию '$local_dir'."
else
  echo "Ошибка при разархивировании архива."
  exit 1
fi

echo "Очистка временных файлов на удаленном сервере..."

# Удаление архива с удаленного сервера
ssh "$remote_server" "rm -f /tmp/$archive_name"

echo "Готово! Архивирование и скачивание завершены."

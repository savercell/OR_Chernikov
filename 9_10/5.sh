#!/bin/bash

# Запрос параметров подключения к удаленному серверу
read -p "Введите удаленный сервер (user@hostname): " remote_server
read -p "Введите локальный путь к директории для синхронизации: " local_dir
read -p "Введите удаленный путь к директории для синхронизации: " remote_dir
read -p "Введите адрес электронной почты для отчета: " email

# Проверка существования локальной директории
if [ ! -d "$local_dir" ]; then
  echo "Ошибка: локальная директория '$local_dir' не найдена."
  exit 1
fi

# Файл с шаблонами игнорирования
ignore_file="sync_exclude.txt"

# Создание файла с исключениями, если его нет
if [ ! -f "$ignore_file" ]; then
  echo "Создание файла исключений $ignore_file..."
  echo "*.log" > "$ignore_file"    # Исключение файлов логов
  echo "*.tmp" >> "$ignore_file"   # Исключение временных файлов
  echo "node_modules/" >> "$ignore_file" # Исключение директорий node_modules
fi

# Синхронизация данных с локального на удаленный сервер
echo "Синхронизация с локального на удаленный сервер..."
rsync -avz --delete --exclude-from="$ignore_file" "$local_dir/" "$remote_server:$remote_dir"

# Синхронизация данных с удаленного сервера на локальную машину
echo "Синхронизация с удаленного сервера на локальную машину..."
rsync -avz --delete --exclude-from="$ignore_file" "$remote_server:$remote_dir/" "$local_dir"

# Проверка успешности синхронизации
if [ $? -eq 0 ]; then
  echo "Синхронизация завершена успешно."
  sync_status="успешно"
else
  echo "Синхронизация завершилась с ошибками."
  sync_status="с ошибками"
fi

# Отправка отчета по электронной почте
echo "Синхронизация файлов между '$local_dir' и '$remote_dir' завершена $sync_status." | mail -s "Отчет о синхронизации" "$email"

echo "Отчет отправлен на $email."

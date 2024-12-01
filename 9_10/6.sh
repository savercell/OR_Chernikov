#!/bin/bash

# Переменные
servers_file="servers_list.txt"    # Файл со списком серверов
log_file="command_output.log"      # Лог-файл для сохранения вывода команд
timestamp=$(date +'%Y-%m-%d_%H-%M-%S')  # Метка времени для логов

# Проверка существования файла со списком серверов
if [ ! -f "$servers_file" ]; then
  echo "Ошибка: файл со списком серверов '$servers_file' не найден."
  exit 1
fi

# Запрос команды для выполнения на серверах
read -p "Введите команду для выполнения на серверах: " remote_command

# Очистка предыдущего лог-файла
echo "Логи команд от $timestamp" > "$log_file"

# Цикл по серверам из файла
while IFS= read -r server; do
  if [ -n "$server" ]; then
    echo "Подключение к серверу $server..."
    
    # Выполнение команды на сервере и сохранение вывода
    ssh "$server" "$remote_command" >> "$log_file" 2>&1
    
    if [ $? -eq 0 ]; then
      echo "Команда успешно выполнена на сервере $server." >> "$log_file"
    else
      echo "Ошибка при выполнении команды на сервере $server." >> "$log_file"
    fi
  fi
done < "$servers_file"

echo "Выполнение команды завершено. Результаты сохранены в $log_file."

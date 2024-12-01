#!/bin/bash

# Запрос адреса сервера от пользователя
read -p "Введите адрес сервера (например, google.com): " server

# Пинг сервера (1 пакет)
ping -c 1 "$server" &> /dev/null

# Проверка кода выхода команды ping
if [ $? -eq 0 ]; then
  echo "Сервер $server доступен."
else
  echo "Сервер $server не доступен."
fi

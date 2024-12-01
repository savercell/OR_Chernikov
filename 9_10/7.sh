#!/bin/bash

# Запрос параметров подключения к удаленному серверу
read -p "Введите удаленный сервер (user@hostname): " remote_server
read -p "Введите порог средней загрузки CPU (например, 2.0): " threshold
read -p "Введите имя процесса для завершения, если нагрузка превышена: " process_name

# Проверка средней загрузки процессора на удаленном сервере
load_average=$(ssh "$remote_server" "uptime | awk -F'[a-z]:' '{ print \$2 }' | awk '{ print \$1 }'")

if [ $? -ne 0 ]; then
  echo "Ошибка при подключении к удаленному серверу."
  exit 1
fi

echo "Средняя загрузка процессора на сервере $remote_server: $load_average"

# Сравнение с порогом
if (( $(echo "$load_average > $threshold" | bc -l) )); then
  echo "Загрузка превышает порог $threshold. Попытка завершить процессы '$process_name'..."

  # Завершение процессов на удаленном сервере
  ssh "$remote_server" "pkill -f $process_name"

  if [ $? -eq 0 ]; then
    echo "Процессы '$process_name' успешно завершены на сервере $remote_server."
  else
    echo "Ошибка при завершении процессов '$process_name'."
  fi
else
  echo "Загрузка процессора не превышает порог. Действия не требуются."
fi

echo "Мониторинг завершен."

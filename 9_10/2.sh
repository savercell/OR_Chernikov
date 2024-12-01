#!/bin/bash

# Запрос параметров для подключения по SSH
read -p "Введите удаленный сервер (user@hostname): " remote_server
read -p "Введите адрес электронной почты для уведомлений: " email

# Подключение к серверу и проверка обновлений, установка и перезагрузка при необходимости
ssh "$remote_server" << 'EOF'
echo "Проверка наличия обновлений на сервере..."

# Обновление пакетов
sudo apt update && sudo apt upgrade -y

# Проверка необходимости перезагрузки
if [ -f /var/run/reboot-required ]; then
  echo "Сервер требует перезагрузки."
  echo "Перезагрузка сервера..."
  sudo reboot
else
  echo "Перезагрузка не требуется."
fi
EOF

# Проверка кода выхода последней команды SSH для перезагрузки
if [ $? -eq 255 ]; then
  echo "Сервер был перезагружен. Отправка уведомления..."
  
  # Отправка уведомления по электронной почте
  echo "Сервер $remote_server был обновлен и перезагружен." | mail -s "Сервер обновлен и перезагружен" "$email"
else
  echo "Обновление выполнено, но перезагрузка не потребовалась."
fi

echo "Завершено."

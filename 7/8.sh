#!/bin/bash

# Устанавливаем пороговое значение для предупреждения
threshold=80

# Получаем процент использования диска для корневой файловой системы
disk_usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

# Проверка использования диска
if [ "$disk_usage" -ge "$threshold" ]; then
  echo "Предупреждение: использование диска составляет $disk_usage%!"
else
  echo "Использование диска в пределах нормы: $disk_usage%."
fi

#!/bin/bash

while true; do
  # Запрос команды от пользователя
  echo "Введите команду (например, 'Дата', 'Время', 'Выход'):"
  read user_input

  # Преобразование ввода в нижний регистр для упрощения обработки
  user_input=$(echo "$user_input" | tr '[:upper:]' '[:lower:]')

  # Выполнение соответствующего действия в зависимости от команды
  case "$user_input" in
    "дата")
      echo "Текущая дата: $(date +'%Y-%m-%d')"
      ;;
    "время")
      echo "Текущее время: $(date +'%H:%M:%S')"
      ;;
    "выход")
      echo "До свидания!"
      break
      ;;
    *)
      echo "Неизвестная команда. Пожалуйста, введите 'Дата', 'Время' или 'Выход'."
      ;;
  esac
done

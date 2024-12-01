#!/bin/bash

# Запрос пути к директории для резервного копирования
read -p "Введите путь к директории для резервного копирования: " source_dir

# Проверка существования директории
if [ ! -d "$source_dir" ]; then
  echo "Ошибка: директория '$source_dir' не найдена."
  exit 1
fi

# Запрос параметров для подключения по SSH
read -p "Введите удаленный сервер (user@hostname): " remote_server
read -p "Введите путь на удаленном сервере для сохранения архива: " remote_dir

# Создание архива с меткой даты
archive_name="backup_$(date +'%Y-%m-%d_%H-%M-%S').tar.gz"
tar -czf "$archive_name" -C "$source_dir" .

# Копирование архива на удаленный сервер
scp "$archive_name" "$remote_server":"$remote_dir"

if [ $? -eq 0 ]; then
  echo "Архив успешно скопирован на удаленный сервер."
else
  echo "Ошибка при копировании архива на удаленный сервер."
  exit 1
fi

# Удаление старых архивов на удаленном сервере (оставляем только 3 последних)
ssh "$remote_server" "cd $remote_dir && ls -t | grep 'backup_' | tail -n +4 | xargs -I {} rm -f {}"

# Удаление локального архива после успешной передачи
rm -f "$archive_name"

echo "Резервное копирование завершено."

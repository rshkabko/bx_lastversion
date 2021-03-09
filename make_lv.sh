#!/bin/bash

# Create .last_version.zip
# Author Shkabko R.
# Repo 

echo "Удаляем папку dist и старую сборку"
rm -r dist
rm -r .last_version.zip

echo "Копируем файлы"
rsync -av --progress ./ dist/ --exclude dist/ --exclude fx_bx_mc.sh --exclude .git/ --exclude .DS_Store

echo "Конвертируем файлы с utf-8 to windows-1251 $file"
find ./ -name "*.php" -o -name "*.html" -o -name "*.css" -o -name "*.js"  -type f |
while read file
do
  echo " $file"
  mv $file $file.icv
  iconv -f UTF-8 -t WINDOWS-1251 $file.icv > $file
  rm -f $file.icv
done

echo "Архивируем папку"
cd dist; zip -r ../.last_version.zip *

rm -r dist
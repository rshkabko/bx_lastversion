#!/bin/bash

# Create .last_version.zip
# Author Shkabko R.
# Repo

echo "Удаляем папку dist и старую сборку"
rm -r dist
rm -r .last_version.zip

echo "Копируем файлы"
mkdir dist
rsync -av --progress ./ dist/.last_version --exclude dist/ --exclude fx_bx_mc.sh --exclude .git/ --exclude .DS_Store --exclude make_lv.sh --exclude .idea --exclude .gitignore --exclude README.md

echo "Конвертируем файлы с utf-8 to windows-1251 $file"
cd dist
find ./.last_version/lang/ -name "*.php" -o -name "*.html" -o -name "*.css" -o -name "*.js"  -type f |
while read file
do
  echo " $file"
  mv $file $file.icv
  iconv -f UTF-8 -t WINDOWS-1251 $file.icv > $file
  rm -f $file.icv
done

echo "Архивируем папку"
zip -r ../.last_version.zip .last_version

cd ../; rm -r dist

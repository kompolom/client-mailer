#!/bin/bash

########################
# Defuaults            #
########################
PROJECTNAME=$1
BRANCH='master'
FORMAT='zip'

if [ -e $PROJECTNAME ];then
  echo "Не указано имя проекта"
  exit 2
fi



########################
# Yandex.Disk          #
########################

yadiskDir=$HOME/Yandex.Disk
yadiskProjectsDir=$yadiskDir/projects

#Установлен ли яндекс-диск
if [ -e yandex-disk ]; then
  echo "yandex-disk не установлен"
  exit 1
fi

echo "Каталог проектов: $yadiskProjectsDir"

function mkdir_if_not_exists(){
  dir=$1
  if ! [ -d $dir ]; then
    echo "Создаем каталог $dir"
    mkdir $dir
  fi
}

#Создает папку проектов, если ее еще нет
mkdir_if_not_exists $yadiskProjectsDir

#создаем папку проекта
TARGET_CATALOG=$yadiskProjectsDir/$PROJECTNAME
mkdir_if_not_exists $TARGET_CATALOG

#вытягиваем сборку из GIT
echo "Создаем срез ветки $BRANCH"

ARCHIVE_NAME=`git describe $BRANCH`
ARCHIVE_FILE=$PROJECTNAME-$ARCHIVE_NAME.$FORMAT

echo "Создаем $ARCHIVE_FILE..."
git archive $BRANCH --prefix="$PROJECTNAME/" --format=zip > $ARCHIVE_FILE

if ! [ -f $ARCHIVE_FILE ]; then
  echo "Не удалось создать архив"
  exit 3
fi

#Перемещаем файл в Яндекс-Диск
echo "Перемещаем архив в Яндекс-диск"
mv $ARCHIVE_FILE $TARGET_CATALOG 

#Получаем ссылку на архив
PUBLIC_LINK=`yandex-disk publish $TARGET_CATALOG/$ARCHIVE_FILE`
echo "Ссылка на скачивание: $PUBLIC_LINK"
exit 0


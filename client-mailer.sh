#!/bin/bash

########################
# Defuaults            #
########################
projectname=$1
branch='master'

if [ -e $projectname ];then
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
    if ! [ `mkdir $dir` ];then
      exit 1
    fi
  fi
}

#Создает папку проектов, если ее еще нет
mkdir_if_not_exists $yadiskProjectsDir

#создаем папку проекта
#mkdir_if_not_exists $yadiskProjectsDir/$projectname

#вытягиваем сборку из GIT
echo "Создаем срез ветки $branch"
echo `git describe $branch`
git archive $branch --prefix="$projectname/" --format=zip > `git describe $branch`.zip

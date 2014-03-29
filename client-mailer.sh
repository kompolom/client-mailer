#!/bin/bash

########################
# Yandex.Disk          #
########################
yadiskDir=$HOME/Yandex.Disk
yadiskProjectsDir=$yadiskDir/projects

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

#!/bin/bash

readonly SERVICE_NAME=0
readonly USER_NAME=1
readonly PASSWORD=2

echo "パスワードマネージャーへようこそ！"
while true
do
  echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
  read input
  if [ ${input} = "Add" ]; then
    echo -n "サービス名を入力してください："
    read service_name
    echo -n "ユーザー名を入力してください："
    read user_name
    echo -n "パスワードを入力してください："
    read password

    password_info="${service_name}:${user_name}:${password}"
    echo $password_info >> password_info.txt
    echo "パスワードの追加は成功しました。"
  elif [ ${input} = "Get" ]; then
    echo -n "サービス名を入力してください："
    read input
    result=$(grep  $input password_info.txt)
    if [ -n ${result} ] ; then
      results=(${result//:/ })
      echo "サービス名: ${results[SERVICE_NAME]}"
      echo "ユーザー名: ${results[USER_NAME]}"
      echo "パスワード: ${results[PASSWORD]}"
    else
      echo "ちゃんと入力せい"
    fi
  elif [ ${input} = "Exit" ]; then
    exit
  fi
done

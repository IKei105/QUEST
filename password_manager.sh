#!/bin/bash

readonly SERVICE_NAME=0
readonly USER_NAME=1
readonly PASSWORD=2

echo "パスワードマネージャーへようこそ！"
echo "鍵として登録したメールアドレスを入力してください。"
read mail_address
while true
do
  echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
  read input
  if [ "${input}" = "Add Password" ]; then
    echo -n "サービス名を入力してください："
    read service_name
    echo -n "ユーザー名を入力してください："
    read user_name
    echo -n "パスワードを入力してください："
    read password

    password_info="${service_name}:${user_name}:${password}"
    #ここでパスワード情報の複合化を行う、複合化したものをpassword_info.txtに格納する
    #ここは暗号化ファイルが存在した場合、複合を行う
    gpg -d password_info.txt.gpg > password_info.txt
    echo $password_info >> password_info.txt
    echo $password_info >> text.txt
    gpg -r $mail_address -e password_info.txt 
      if [ $? -eq 0 ]; then
	rm password_info.txt
      else
	echo "エラーが発生しました。終了します。"	
      fi
    echo ${encrypt_result}
    echo "パスワードの追加は成功しました。"
  elif [ "${input}" = "Get Password" ]; then
    echo -n "サービス名を入力してください："
    read input
    result=$(grep  $input password_info.txt)
    if [ -n "${result}" ] ; then
      results=(${result//:/ })
      echo "サービス名: ${results[SERVICE_NAME]}"
      echo "ユーザー名: ${results[USER_NAME]}"
      echo "パスワード: ${results[PASSWORD]}"
    else
      echo "そのサービスは登録されていません。"
    fi
  elif [ "${input}" = "Exit" ]; then
    echo -n "Thank you"
    printf '\033[31m%s\033[m\n' '!'
    exit
  else
    echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
  fi
done

#!/bin/sh
# name runjar.sh
# desc 程序jar包
# create by m-ning at 2017-04-22 13:26:18

author=man003@163.com
version=V1-20170422

############config##################
# 部署文件夹名 
dirName=ProtevioProcess

# jar包名 
jarName=PotevioProcess-0.0.1-SNAPSHOT.jar

# 延迟启动
# 之所以要延迟启动100s 是因为如果开机就启动java 会报连不上数据库的错误,所以先等100s再启动
delaySeconds=10
####################################


usage() {
 cat <<EOM
Usage: $SHELL_NAME parameters
  start     |start program
  stop      |stop program
  status    |show program status
EOM
}

###  ------------------------------- ###
###  Main script                     ###
###  ------------------------------- ###


# 脚本当前路径
SHELL_PATH=$(cd $(dirname "$0");pwd)
cd $SHELL_PATH/..

SHELL_NAME=`basename $0`

case "$1" in
  start)
        echo "wait for $delaySeconds s"
        sleep $delaySeconds
        echo "start ..."
        nohup java -jar lib/$jarName
        exit $?
        ;;
  stop)
        process=`ps -ef|grep $dirName|grep -v "grep"|awk '{print $2}'`
        if [ ! -z $process ]
        then
            echo kill $process
            kill -9 $process
        else
            echo program not running!!!
            exit 0
        fi
        exit $?
        ;;
  status)
        ps -ef |grep $dirName
        exit $?
        ;;
  *)
        usage
        exit 0
        ;; 
esac

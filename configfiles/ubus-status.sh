#!/bin/sh

while true
do
    nginx_status=$(/etc/init.d/dbus status | grep -o "running")
    datetime=$(date +"%Y-%m-%d %H:%M:%S")
    pid2=$(pgrep "ubusd" | head -n 1)

    if [ -n "$nginx_status" ]; then
        echo "$datetime / Ubus服务正在运行，一切正常。"
    elif [ -z "$pid2" ]; then
        echo "$datetime / Ubus服务异常，正在重启Ubus。"
        /sbin/ubusd &
        killall -9 rpcd
        /sbin/rpcd -s /var/run/ubus/ubus.sock -t 30 &
    else
        echo "$datetime / Ubus服务异常，正在重启Ubus。"
        killall -9 ubusd
        killall -9 rpcd
        /sbin/rpcd -s /var/run/ubus/ubus.sock -t 30 &
    fi
    sleep 60
done

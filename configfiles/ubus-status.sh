#!/bin/sh

while true
do
    dbus_status=$(/etc/init.d/dbus status | grep -o "running")
    datetime=$(date +"%Y-%m-%d %H:%M:%S")
    pidv=$(pgrep "ubusd" | head -n 1)

    if [ -n "$dbus_status" ]; then
        echo "$datetime / Ubus服务正在运行，一切正常。"
    elif [ -z "$pidv" ]; then
        echo "$datetime / Ubus服务异常，正在重启Ubus。"
        /sbin/ubusd &
        killall rpcd
        /sbin/rpcd -s /var/run/ubus/ubus.sock -t 30 &
    else
        echo "$datetime / Ubus服务异常，正在重启Ubus。"
        killall ubusd
        killall rpcd
        /sbin/rpcd -s /var/run/ubus/ubus.sock -t 30 &
    fi
    sleep 60
done

#!/bin/sh

while true
do
    dbus_status=$(/etc/init.d/dbus status)
    status_code=$(curl -o /dev/null -s -w "%{http_code}\n" http://127.0.0.1/cgi-bin/luci/ 2>/dev/null)
    page_content=$(curl -s http://127.0.0.1/cgi-bin/luci/ 2>/dev/null)
    datetime=$(date +"%Y-%m-%d %H:%M:%S")
    pidv=$(pgrep "ubusd" | head -n 1)
    pidv2=$(pgrep "rpcd" | head -n 1)

    if [ -z "$status_code" ]; then
        status_code="ERROR"
    fi

    if [ -z "$page_content" ]; then
        page_content="ERROR"
    fi

    if [ -z "$pidv" ]; then
        echo "$datetime / Ubus服务异常，正在重启Ubus。"
        /sbin/ubusd &
    elif [ -z "$pidv2" ]; then
        echo "$datetime / Ubus服务异常，正在重启Ubus。"
        /sbin/rpcd -s /var/run/ubus/ubus.sock -t 30 &
    elif ((echo "$page_content" | grep -q "dispatcher.lua:430" || echo "$page_content" | grep -q "dispatcher.lua:") && echo "$dbus_status" | grep -q "running") || ([[ "$status_code" == 500 || "$status_code" == 502 ]] && echo "$dbus_status" | grep -q "running"); then
        echo "$datetime / Ubus服务异常，正在重启Ubus。"
        killall rpcd
        /etc/init.d/rpcd restart
    elif echo "$dbus_status" | grep -q "running"; then
        echo "$datetime / Ubus服务正在运行，一切正常。"
    else
        echo "$datetime / Ubus服务异常，正在重启Ubus。"
        killall ubusd
        killall rpcd
        /sbin/rpcd -s /var/run/ubus/ubus.sock -t 30 &
    fi
    sleep 60
done

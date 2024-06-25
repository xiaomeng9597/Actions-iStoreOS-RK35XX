#!/bin/sh

check_ubus() {
    local pidcount=$(pgrep "ubusd" | wc -l)
    local pidcount2=$(pgrep "rpcd" | wc -l)

    if [ "$pidcount" -gt 1 ]; then
        killall ubusd
    fi

    if [ "$pidcount2" -gt 2 ] && [ "$pidcount" -eq 1 ]; then
        killall rpcd
    fi

    if [ "$(pgrep ubusd | wc -l)" -eq 0 ]; then
        sleep 1
        /sbin/ubusd &
    fi

    local datetime=$(date +"%Y-%m-%d %H:%M:%S")
    local dbus_status=$(/etc/init.d/dbus status 2>&1)
    local status_code=$(curl -o /dev/null -s -w "%{http_code}\n" http://127.0.0.1/cgi-bin/luci/ 2>/dev/null)
    if [ -z "$status_code" ]; then
        status_code="ERROR"
    fi

    if [ "$(pgrep rpcd | wc -l)" -eq 0 ] && [ "$(pgrep ubusd | wc -l)" -eq 1 ]; then
        echo "$datetime / Ubus服务异常，正在重启Ubus。"
        sleep 1
        /sbin/rpcd -s /var/run/ubus/ubus.sock -t 30 &
    elif [[ "$status_code" == 500 || "$status_code" == 502 ]] && echo "$dbus_status" | grep -q "running"; then
        echo "$datetime / Ubus服务异常，正在重启Ubus。"
        killall rpcd
        sleep 1
        /sbin/rpcd -s /var/run/ubus/ubus.sock -t 30 &
    elif echo "$dbus_status" | grep -q "running"; then
        echo "$datetime / Ubus服务正在运行，一切正常。"
    else
        echo "$datetime / Ubus服务异常，正在重启Ubus。"
        killall rpcd
        sleep 1
        /sbin/rpcd -s /var/run/ubus/ubus.sock -t 30 &
    fi
}

while true; do
check_ubus
    sleep 60
done

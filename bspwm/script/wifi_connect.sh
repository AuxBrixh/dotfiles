#!/bin/zsh

# Periksa status Wi-Fi (apakah Wi-Fi aktif atau mati)
wifi_status=$(nmcli radio wifi)

# Menampilkan status Wi-Fi
if [ "$wifi_status" = "enabled" ]; then
    wifi_icon="󰤾"  # Wi-Fi aktif
else
    wifi_icon="󰤿"  # Wi-Fi mati
fi

# Pilihan menu: toggle Wi-Fi atau pilih jaringan Wi-Fi
action=$(printf "Toggle Wi-Fi\nPilih Wi-Fi" | rofi -dmenu -p "Wi-Fi")

if [ "$action" = "Toggle Wi-Fi" ]; then
    # Toggle Wi-Fi (matikan jika aktif, nyalakan jika mati)
    if [ "$wifi_status" = "enabled" ]; then
        nmcli radio wifi off
        notify-send "Wi-Fi dimatikan"
    else
        nmcli radio wifi on
        notify-send "Wi-Fi dihidupkan"
    fi
elif [ "$action" = "Pilih Wi-Fi" ]; then
    # Daftar jaringan Wi-Fi yang tersedia
    wifi_list=$(nmcli -t -f SSID dev wifi | sort | rofi -dmenu -p "Pilih Wi-Fi:")

    # Jika pengguna memilih Wi-Fi
    if [ -n "$wifi_list" ]; then
        nmcli dev wifi connect "$wifi_list"
        notify-send "Terhubung ke Wi-Fi" "$wifi_list"
    else
        notify-send "Tidak ada Wi-Fi yang dipilih"
    fi
fi

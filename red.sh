#!/bin/bash

# Función para instalar programas necesarios
install_dependencies() {
    sudo apt-get update
    sudo apt-get install -y iproute2 iw wpa_supplicant rfkill
}

# Función para listar interfaces de red
list_interfaces() {
    ip link show
}

# Función para conectar a una red cableada de forma dinámica
connect_wired_dynamic() {
    interface="$1"
    sudo dhclient "$interface"
}

# Función para conectar a una red cableada de forma estática
connect_wired_static() {
    interface="$1"
    sudo ip addr add <tu_dirección_IP> dev "$interface"
    sudo ip link set "$interface" up
    sudo ip route add default via <tu_pasarela>
}

# Función para listar redes inalámbricas cercanas y su tipo de cifrado
list_wireless_networks() {
    iwlist scan | grep -E "ESSID|Encryption"
}

# Función para conectar a una red inalámbrica de forma dinámica o estática
connect_wireless() {
    interface="$1"
    ssid="$2"
    key="$3"  # Contraseña o clave WPA2

    sudo ip link set "$interface" up
    sudo iwconfig "$interface" essid "$ssid"

    if [ -n "$key" ]; then
        sudo iwconfig "$interface" key s:"$key"
    fi

    sudo dhclient "$interface"
}

# Función para conectar a una red inalámbrica que utilice WPS
connect_wireless_wps() {
    interface="$1"
    ssid="$2"

    sudo wpa_cli -i "$interface" wps_pbc "$ssid"
}

# Función para configurar conexiones permanentes
configure_permanent_connection() {
    interface="$1"
    sudo sh -c "echo 'auto $interface' >> /etc/network/interfaces"
    sudo sh -c "echo 'iface $interface inet dhcp' >> /etc/network/interfaces"
}

# Main
case "$1" in
    "install")
        install_dependencies
        ;;
    "list_interfaces")
        list_interfaces
        ;;
    "connect_wired_dynamic")
        connect_wired_dynamic "$2"
        ;;
    "connect_wired_static")
        connect_wired_static "$2"
        ;;
    "list_wireless_networks")
        list_wireless_networks
        ;;
    "connect_wireless")
        connect_wireless "$2" "$3" "$4"
        ;;
    "connect_wireless_wps")
        connect_wireless_wps "$2" "$3"
        ;;
    "configure_permanent_connection")
        configure_permanent_connection "$2"
        ;;
    *)
        echo "Uso: $0 {install|list_interfaces|connect_wired_dynamic|connect_wired_static|list_wireless_networks|connect_wireless|connect_wireless_wps|configure_permanent_connection}"
        exit 1
        ;;
esac

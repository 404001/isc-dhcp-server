#!/bin/bash

# Solicitar datos al usuario
read -p "Ingrese la interfaz de red (ej. enp0s8): " network_interface
read -p "Ingrese la IP del servidor (ej. 172.16.0.0/24): " server_ip
read -p "Ingrese la IP del gateway (ej. 172.16.0.1): " gateway_ip
read -p "Ingrese la primera IP del rango (ej. 172.16.0.10): " range_start
read -p "Ingrese la última IP del rango (ej. 172.16.0.100): " range_end

# Configurar red
echo "Configurando red..."
sudo bash -c "cat > /etc/netplan/50-cloud-init.yml" <<EOL
network:
   ethernets:
      $network_interface:
         addresses:
            - $server_ip
         gateway4: $gateway_ip
         nameservers:
            addresses:
               - 8.8.8.8
               - 8.8.4.4
         dhcp4: true
   version: 2
EOL

# Aplicar configuración de red
sudo netplan apply

# Instalar isc-dhcp-server
echo "Instalando isc-dhcp-server..."
sudo apt-get update
sudo apt-get install -y isc-dhcp-server

# Configurar servidor DHCP
echo "Configurando servidor DHCP..."
sudo bash -c "cat > /etc/dhcp/dhcpd.conf" <<EOL
subnet $server_ip netmask 255.255.255.0 {
    range $range_start $range_end;
    option routers $gateway_ip;
    option domain-name-servers 8.8.8.8, 8.8.4.4;
    option domain-name "example.com";
}
EOL

# Reiniciar servicio DHCP
sudo systemctl restart isc-dhcp-server
sudo systemctl enable isc-dhcp-server

# Cliente DHCP
read -p "¿Desea configurar el cliente DHCP en esta máquina? (s/n): " config_cliente

if [ "$config_cliente" = "s" ]; then
    sudo apt-get install -y isc-dhcp-client
    sudo dhclient -r
    sudo dhclient
    echo "Cliente DHCP configurado."
fi

echo "Proceso completado."

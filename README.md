> [!IMPORTANT]
> Las maquinas virtuales tienen que tener configurado la red como `adaptador puente`
>
> Y si tienes mas servidores dhcp, lo mejor es poner este en `red interna`
>
> En cada maquina al iniciarla es recomendable hacer un `sudo apt upgrade` antes de todo.

### Informacion de la red:
 - subnet `172.16.0.0` / `24`
 - range from `172.16.0.10` to `172.16.0.100`;
 - netmask `255.255.255.0`
 - dns-server from google.com `8.8.8.8`, alt `8.8.4.4`

## Configurar la red

Lo primero es entrar en:

```
sudo nano /etc/netplan/50-cloud-init.yml
```
y poner la siguien configuracion relacionada con nuestro server DHCP

```
network:
   ethernets:
      enp0s8:
         addresses:
            - 172.16.0.0/24
         gateway4: 172.16.0.1
         nameservers:
            addresses:
               - 8.8.8.8
               - 8.8.4.4
         dhcp4: true
   version: 2
```

Despues tendremos q entrar en `/etc/default/isc-dhcp-server` y poner el adaptador en ipv4, para aplicar cambios usa `netplan apply`

## Instalation

Lo primero es instalar `isc-dhcp-server` en una de las 2 maquinas, solo instalar el server!

```bash
sudo apt-get install isc-dhcp-server
```

### Configuracion

Lo siguiente es configurar el server dhcp, podemos editarlo mediante nano con el siguiente commando:

```bash
sudo nano /etc/dhcp/dhcpd.conf
```

Luego en la conf pondremos el siguiente texto:

```conf
subnet 172.16.0.0 netmask 255.255.255.0 {
    range 172.16.0.10 172.16.0.100;
    option routers 172.16.0.1;
    option domain-name-servers 8.8.8.8, 8.8.4.4;
    option domain-name "exmaple.com";
}
```

Para saber el rango de ips podemos poner en la terminal de `ipcalc 20.20.20.0/27` y te devuelve el numero de ips que caben dentro de la red.
A partir de aqui podemos asignar como queramos el rango, manteniendo el numero de ips correcto.

---

Una vez configurado presiona `ctrl+s` y seguido `ctrl+x` y enter si es necesario.

Despues de configurar el server lo reiniciamos, lo puedes hacer con el siguiente comando:

```bash
sudo systemctl restart isc-dhcp-server
```

y si quieres que se inicie con el pc:

```bash
sudo systemctl enable isc-dhcp-server
```


### Configuracion del cliente

Lo primero es descargar `isc-dhcp-client` con el siguiente comando:

```bash
sudo apt-get install isc-dhcp-client
```

Antes de ejecutar los siguientes comando ejecuta el comando `ip a` para ver la ip, guardatela para compararla despues.

Ahora que tenemos lo necesario, quitaremos nuestra ip actual con el siguiente comando:

```bash
sudo dhclient -r
```

y para asignar de nuevo una ip usaremos:

```bash
sudo dhclient
```

Ahora podemos comparar la ip del principio con la de ahora y veremos q la de ahora esta dentro del rango de la red.


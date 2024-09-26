> [!IMPORTANT]
> Las maquinas virtuales tienen que tener configurado la red como `adaptador puente`

### Informacion de la red:
 - netmask `20.20.20.0` / `27`
 - range from `192.168.1.10` to `192.168.1.15`;
 - subnet `192.168.1.0`
 - dns-server from google.com `8.8.8.8`, alt `8.8.4.4`

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
subnet 192.168.1.0 netmask 20.20.20.0 {
    range 192.168.1.10 192.168.1.15;
    option routers 192.168.1.1;
    option domain-name-servers 8.8.8.8, 8.8.4.4;
    option domain-name "exmaple.com";
}
```

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


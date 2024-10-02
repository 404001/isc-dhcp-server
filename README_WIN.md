
---

> **¡IMPORTANTE!**  
> Las máquinas virtuales deben tener configurada la red como `Adaptador Puente`.  
> Si tienes más servidores DHCP, lo mejor es poner este en `Red Interna`.  
> En cada máquina, al iniciarla, es recomendable ejecutar `Windows Update` antes de todo.

### Información de la red:
- Subred: `172.16.0.0` / `24`
- Rango de direcciones IP: `172.16.0.10` a `172.16.0.100`
- Máscara de subred: `255.255.255.0`
- Servidor DNS de Google: `8.8.8.8`, alternativo `8.8.4.4`

## Configurar la red

1. **Acceder a la configuración de red:**
   - Ve a `Panel de Control` > `Red e Internet` > `Centro de redes y recursos compartidos`.
   - Haz clic en `Cambiar configuración del adaptador`.
   - Haz clic derecho sobre el adaptador de red correspondiente y selecciona `Propiedades`.

2. **Configurar IPv4:**
   - Selecciona `Protocolo de Internet versión 4 (TCP/IPv4)` y haz clic en `Propiedades`.
   - Selecciona la opción `Usar la siguiente dirección IP` y configura de la siguiente manera:
     - Dirección IP: `172.16.0.10` (ajusta según sea necesario dentro del rango)
     - Máscara de subred: `255.255.255.0`
     - Puerta de enlace predeterminada: `172.16.0.1`
     - Servidores DNS: 
       - `8.8.8.8`
       - `8.8.4.4`

3. **Aplicar los cambios:**
   - Haz clic en `Aceptar` para guardar la configuración.

## Instalación del servidor DHCP

1. **Instalar el rol de DHCP:**
   - Abre el `Administrador del servidor`.
   - Selecciona `Agregar roles y características`.
   - Avanza hasta llegar a la sección `Roles del servidor`.
   - Marca la casilla de `Servidor DHCP` y sigue las instrucciones para completar la instalación.

2. **Configurar el servidor DHCP:**
   - Una vez instalado, ve al `Administrador de DHCP`.
   - Haz clic derecho en tu servidor DHCP y selecciona `Nueva ámbito`.
   - Configura el nuevo ámbito con la siguiente información:
     - Nombre del ámbito: `MiAmbito`
     - Rango de direcciones IP: `172.16.0.10` a `172.16.0.100`
     - Máscara de subred: `255.255.255.0`
     - Puerta de enlace: `172.16.0.1`
     - Servidores DNS: `8.8.8.8` y `8.8.4.4`

3. **Completar la configuración:**
   - Asegúrate de habilitar el ámbito después de crearlo.

## Configuración del cliente

1. **Configurar un cliente para obtener IP automáticamente:**
   - Ve a `Panel de Control` > `Red e Internet` > `Centro de redes y recursos compartidos`.
   - Haz clic en `Cambiar configuración del adaptador`.
   - Haz clic derecho sobre el adaptador de red correspondiente y selecciona `Propiedades`.
   - Selecciona `Protocolo de Internet versión 4 (TCP/IPv4)` y haz clic en `Propiedades`.
   - Selecciona `Obtener una dirección IP automáticamente` y `Obtener la dirección del servidor DNS automáticamente`.
   - Haz clic en `Aceptar` para guardar los cambios.

2. **Renovar la dirección IP:**
   - Abre `Símbolo del sistema` como administrador.
   - Ejecuta el siguiente comando para liberar la IP actual:
     ```bash
     ipconfig /release
     ```
   - Luego, ejecuta el siguiente comando para obtener una nueva IP:
     ```bash
     ipconfig /renew
     ```

3. **Verificar la IP obtenida:**
   - Para comprobar la dirección IP asignada, utiliza el siguiente comando:
     ```bash
     ipconfig
     ```
   - Asegúrate de que la nueva dirección IP esté dentro del rango configurado.

---

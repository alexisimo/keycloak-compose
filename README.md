# Despliegue de KeyCloak en Production usando docker compose
[Documentacion](https://www.keycloak.org/guides#getting-started)
## Prerequisitos
* Docker tiene que estar instalado en la máquina host
  * Siga las indicaciones del siguiente [link](https://docs.docker.com/engine/install/ubuntu/) para instalarlo correctamente
* Acceso para configurar los registros de un dominio u obtener uno temporal en https://www.duckdns.org/domains 

## Obtención de un certificado SSL Certificate usando Certbot:
Instale Certbot y obtenga el certificado SSL para su dominio. Asegúrese de que su máquina host es accesible desde el internet. 
```shell
  # Instale Certbot 
  sudo apt-get update
  sudo apt-get install certbot

  # Obtenga un certificado SSL para su dominio
  # sudo certbot certonly --standalone -d <Keycloak server domain> -m <your email> --agree-tos
  sudo certbot certonly --standalone -d site-domain.com -m test@gmail.com --agree-tos
```
## Clone este repositorio
```
git clone https://github.com/alexisimo/keycloak-compose.git
```

## Actualice las variables de entorno y directorio de certificados
Actualice las variables de entorno en el fichero [docker-compose.yaml](./docker-compose.yaml) Aunque en el fichero ya están definidas se recomienda cambiarlas, especialmente las que contienen información de credenciales por su seguridad.

Además en el fichero [nginx.conf](./nginx.conf) hace falta asegurarse de que en la configuración del servidor los parámetros correspondientes a los certificados apunten correctamente a donde se encuentran guardados dentro del host.

```
server_name site-domain.com;
ssl_certificate "/etc/letsencrypt/live/site-domain.com/fullchain.pem";
ssl_certificate_key "/etc/letsencrypt/live/site-domain.com/privkey.pem";
```

## Correr el servidor de Keycloak
```shell
  cd keycloak-compose
  docker compose up -d
```
#### Las credenciales establecidas por defecto son
```yaml
KEYCLOAK_ADMIN: admin
KEYCLOAK_ADMIN_PASSWORD: Password123
```

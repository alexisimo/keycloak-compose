# Despliegue de KeyCloak en Production usando docker compose
Este es un repositorio de referencia para desplegar en producción el gestor de identidad y acceso (IAM) Keycloak + Postgresql junto con el servidor web Nginx y Certbot usando Docker compose. La documentación en la que se ha basado este repositorio se encuentra en el siguiente [link](https://www.keycloak.org/guides#getting-started).
## Prerequisitos
* Docker y docker compose tienen que estar instalados en la máquina host
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

## Actualice las variables de entorno
El fichero [.env.example](./.env.example) se puede usar como un ejemplo de configuración de las variables de entorno. Haga una copia utilizando el nombre `.env` y actualice las variables de entorno acorde a su caso. Aunque en el fichero ya están definidas se recomienda cambiar las credenciales por seguridad.

Tanto el fichero [docker-compose.yaml](./docker-compose.yaml) como el [default.conf.template](./default.conf.template) hacen uso de las variables que se hayan declarado en el fichero `.env`.
Además en el fichero [default.conf.template](./default.conf.template) hace falta asegurarse de que en la configuración del servidor los parámetros correspondientes a los certificados apunten correctamente a donde se encuentran guardados dentro del host en el caso de haberlos generado en otra dirección. 

## Correr los servicios de Keycloak

```shell
  cd keycloak-compose
  docker compose up -d
```


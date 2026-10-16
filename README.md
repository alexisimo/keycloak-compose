# Despliegue de KeyCloak en Production con backup usando docker compose
Este es un repositorio de referencia para desplegar en producción el gestor de identidad y acceso (IAM) Keycloak + Postgresql junto con el servidor web Nginx, y backupper usando Docker compose. La documentación de Keycloak en la que se ha basado este repositorio se encuentra en el siguiente [link](https://www.keycloak.org/guides#getting-started). 

En la carpeta backupper se puede encontrar lo necesario para desplegar un contenedor que hace copias de seguridad periódicas de la base de datos y los datos de aplicación.

## Prerequisitos
* Docker y docker compose tienen que estar instalados en la máquina host
  * Siga las indicaciones del siguiente [link](https://docs.docker.com/engine/install/ubuntu/) para instalarlo correctamente
* Acceso para configurar los registros de un dominio  
* Terminación SSL en WAF para publicación en HTTP

## Clone este repositorio
```
git clone https://github.com/alexisimo/keycloak-compose.git
```

## Actualice las variables de entorno
El fichero [.env](./.env) se puede usar como un ejemplo de configuración de las variables de entorno. Actualice las variables de entorno acorde a su caso. Aunque en el fichero ya están definidas se recomienda cambiar las credenciales por seguridad. 

## Correr los servicios de Keycloak, Nginx y el backupper

```shell
  cd keycloak-compose
  docker compose up -d
```


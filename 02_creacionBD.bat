@echo off

echo.
echo 0) Bajando contenedores activos (incluyendo huerfanos)...
docker compose down -v --remove-orphans

echo.
echo 1) Forzando eliminacion de contenedores residuales...
docker rm -f mariadb_db data_loader >nul 2>&1

echo.
echo 2) Eliminando informacion de la carpeta data...
timeout /t 3 /nobreak >nul
rmdir /s /q data
mkdir data

echo.
echo 3) Levantando contenedores...
docker compose up -d

echo.
echo 4) Esperando a que el loader finalice la carga...
docker wait data_loader

echo.
echo 5) Logs del loader...
docker logs data_loader

echo.
echo 6) Entrando a la terminal de MariaDB...
docker exec -it mariadb_db mariadb -u root -proot123 entidadesTerritorialesColombia
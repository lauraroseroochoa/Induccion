@echo off
setlocal enabledelayedexpansion

echo.
echo 1) Esperando a que MariaDB inicie...

:waitMariaDB
docker exec mariadb_db mariadb -u root -proot123 -e "USE entidadesTerritorialesColombia; SHOW TABLES;" >nul 2>&1
if errorlevel 1 (
    timeout /t 5 /nobreak >nul
    goto waitMariaDB
)
echo MariaDB lista.

echo.
echo 2) Comprobando extension MySQL Client...
code --list-extensions | findstr /I "cweijan.vscode-mysql-client2" >nul 2>&1
if errorlevel 1 (
    echo Instalando extension...
    code --install-extension cweijan.vscode-mysql-client2 --force
) else (
    echo Extension ya instalada.
)

echo.
echo 3) Realizando la conexión con la herramienta de VSC...



echo.
echo Proceso finalizado.
endlocal
@echo off
setlocal enabledelayedexpansion

echo Comprobando Git, Docker y Visual Studio Code...

rem --- Comprobar Git ---
where git >nul 2>&1
if !errorlevel!==0 (
    for /f "tokens=*" %%i in ('git --version 2^>nul') do set GIT_VER=%%i
    echo Git instalado: !GIT_VER!
) else (
    echo Git no encontrado.
    echo Por favor instale Git desde https://git-scm.com/ y vuelva a ejecutar este script.
)

rem --- Comprobar Docker Desktop ---
where docker >nul 2>&1
if !errorlevel!==0 (
    for /f "tokens=*" %%i in ('docker --version 2^>nul') do set DOCKER_VER=%%i
    echo Docker instalado: !DOCKER_VER!
) else (
    echo Docker no encontrado.
    echo Por favor instale Docker Desktop desde https://www.docker.com/get-started y vuelva a ejecutar este script.
)

rem --- Comprobar Visual Studio Code ---
where code >nul 2>&1
if !errorlevel!==0 (
    for /f "tokens=*" %%i in ('code --version 2^>nul') do (
        set CODE_VER=%%i
        goto :vsc_done
    )
) else (
    echo Visual Studio Code no encontrado.
    echo Por favor instale Visual Studio Code desde https://code.visualstudio.com/ y vuelva a ejecutar este script.
    goto :clone
)

:vsc_done
echo Visual Studio Code instalado. Version: !CODE_VER!

rem --- Clonar repositorio si no existe ---
:clone
set REPO_URL=https://github.com/Jeferson-Arias/BDM_introduccion.git
set REPO_DIR=BDM_introduccion

if exist "%CD%\%REPO_DIR%" (
    echo El repositorio ya existe en %CD%\%REPO_DIR%. Se intentara actualizar.
    pushd "%REPO_DIR%"
    if exist .git (
        git pull || echo No se pudo actualizar el repositorio con git pull.
    ) else (
        echo La carpeta existe pero no parece ser un repositorio git.
    )
    popd
) else (
    echo Clonando %REPO_URL% en %CD%...
    git clone %REPO_URL%
    if !errorlevel! neq 0 (
        echo Error al clonar el repositorio. Asegurese de que Git esta instalado y tiene acceso a internet.
    )
)

rem --- Entrar al repositorio y ejecutar el proyecto ---
cd BDM_introduccion && 01_encadenador.bat

echo Proceso finalizado.
endlocal
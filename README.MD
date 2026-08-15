# Proyecto: Contenedor MariaDB + Automatización de Base de Datos

## 📌 Descripción General

Este proyecto tiene como finalidad desplegar un entorno de base de datos completamente automatizado utilizando **Docker** y **MariaDB** como Sistema Gestor de Base de Datos (SGBD).

Se implementa un flujo de ejecución controlado que permite inicializar, configurar y probar la base de datos de manera reproducible, asegurando consistencia en cada despliegue.

---

## Objetivos del Proyecto

El entorno automatizado permite:

- Crear la base de datos desde cero.
- Ejecutar scripts SQL iniciales (`schema`).
- Importar y distribuir información en sus respectivas tablas.
- Aplicar procesos de depuración y eliminación de datos redundantes.
- Garantizar una ejecución repetible y controlada del entorno.
- Reducir la intervención manual mediante orquestación por scripts.

Todo el proceso se encuentra automatizado mediante archivos `.bat`, diseñados para entornos Windows.

---

## Arquitectura de Ejecución

El flujo general del proyecto sigue la siguiente secuencia:

1. Inicialización del entorno Docker.
2. Construcción de la imagen del contenedor.
3. Levantamiento del contenedor MariaDB.
4. Ejecución automática del script `01_schema.sql`.
5. Procesamiento y normalización de datos.
6. Entorno listo para consultas y validaciones.

---

## Requisitos Previos

Antes de ejecutar el proyecto, asegúrese de contar con:

- Docker Desktop
- Git
- Visual Studio Code (opcional, recomendado)
- Sistema Operativo Windows

> ⚠️ Verifique que Docker se encuentre en ejecución antes de iniciar el proceso.
> El script principal puede intentar iniciarlo automáticamente, pero se recomienda validarlo manualmente.

---

##  Ejecución del Proyecto

La ejecución se realiza desde el archivo principal:

### `00_inicio.bat`

Desde la raíz del proyecto, abra una terminal (PowerShell o CMD) y ejecute:

```bash
.\00_inicio.bat# Induccion

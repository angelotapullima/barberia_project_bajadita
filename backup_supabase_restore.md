# 🗄️ Backup y Restauración de Base de Datos Supabase en Servidor PostgreSQL (Windows)

Este documento describe cómo **hacer un backup completo de Supabase** y **restaurarlo en un servidor PostgreSQL** desde **Windows**.

---

## 🧭 PASO 1: Crear Backup desde Supabase (Windows)

Ejecuta este comando en **PowerShell** o **CMD** en tu terminal local:

```bash
pg_dump --host=db.aavmxjmkiaevxyiyztsc.supabase.co --port=5432 --username=postgres --dbname=postgres --format=p --clean --if-exists --no-owner --no-privileges --verbose --file="supabase_backup_2025-10-22.sql"
```

### 🔹 Explicación

* `--format=p`: genera un archivo SQL plano (fácil de importar).
* `--clean`: elimina objetos antes de recrearlos.
* `--if-exists`: evita errores si no existen objetos.
* `--no-owner` / `--no-privileges`: evita conflictos de roles.
* `--verbose`: muestra el progreso.

📁 El archivo `supabase_backup.sql` se guardará en la carpeta actual de tu terminal.

---

## 🧭 PASO 2: Subir el Backup al Servidor

Una vez generado el archivo, cópialo al servidor usando `scp` (desde **PowerShell** o **Git Bash**):

```bash
scp supabase_backup_2025-10-22.sql root@46.62.209.234:/root/
```

### Ejemplo:

```bash
scp supabase_backup_2025-10-22.sql root@46.62.209.234:/root/
```

> **Nota para Windows:** Si no tienes `scp`, puedes usar:
> - **WinSCP** (interfaz gráfica)
> - **PowerShell con OpenSSH** (viene incluido en Windows 10/11)
> - **Git Bash** (si tienes Git instalado)

📁 El archivo quedará disponible en `/home/ubuntu/` dentro del servidor.

---

## 🧭 PASO 3: Restaurar el Backup en tu Servidor

Conéctate al servidor por SSH desde **PowerShell** o **Git Bash**:

```bash
ssh usuario@<IP_O_HOST_DEL_SERVIDOR>
```

Verifica que el archivo esté presente:

```bash
ls -lh supabase_backup.sql
```

### 🔹 Ver bases de datos existentes

```bash
psql -U postgres -l
```

Ejemplo de salida:

```
 Name    | Owner    | Encoding | Collate | Ctype | Access privileges
---------+----------+----------+---------+-------+-------------------
 dev     | postgres | UTF8     | en_US   | en_US | 
 prod    | postgres | UTF8     | en_US   | en_US | 
```

### Restauración en Contenedor Docker (si PostgreSQL está en Docker)

Si tu servidor PostgreSQL está corriendo dentro de un contenedor Docker, sigue estos pasos:

1.  **Verificar el contenedor de PostgreSQL:**
    Identifica el ID o nombre de tu contenedor PostgreSQL. Puedes verificarlo con `docker ps`.
    ```bash
    docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Names}}"
    ```
    Valida que el contenedor sea el correcto (ej. comparando con la URL de tu PostgreSQL en Coolify si aplica). Anota el `CONTAINER ID` o `NAMES`.

2.  **Detener el contenedor (opcional, pero recomendado):**
    Detener el contenedor puede prevenir problemas de concurrencia durante la restauración.
    ```bash
    docker stop <CONTAINER_ID_O_NOMBRE>
    ```
    Ejemplo: `docker stop edb8ddcd915d`

3.  **Renombrar el contenedor (opcional):**
    Si el nombre del contenedor es genérico, puedes renombrarlo para mayor claridad.
    ```bash
    docker rename <NOMBRE_ACTUAL_CONTENEDOR> postgresql-bajadita-prod
    ```
    Ejemplo: `docker rename wgcwg0048kgskkw8kog4goow postgresql-bajadita-prod`

4.  **Iniciar el contenedor (si lo detuviste):**
    ```bash
    docker start <NOMBRE_DEL_CONTENEDOR_RENOMBRADO_O_ID>
    ```
    Ejemplo: `docker start postgresql-bajadita-prod`

5.  **Verificar que el contenedor esté corriendo:**
    ```bash
    docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Names}}"
    ```

6.  **Ejecutar la restauración del backup dentro del contenedor:**
    Asegúrate de que el archivo `supabase_backup.sql` esté en una ruta accesible desde el contenedor (ej. `/root/` si lo subiste allí).
    ```bash
    docker exec -i <NOMBRE_DEL_CONTENEDOR> psql -U postgres < /root/supabase_backup.sql
    ```
    Ejemplo: `docker exec -i postgresql-bajadita-prod psql -U postgres < /root/supabase_backup.sql`

7.  **Verificar la instancia y los logs:**
    Para entrar a la instancia de PostgreSQL dentro del contenedor y verificar las tablas:
    ```bash
    docker exec -it <NOMBRE_DEL_CONTENEDOR> psql -U postgres
    ```
    Una vez dentro de `psql`, puedes usar `\dt` para listar tablas.

    Para ver los logs del contenedor:
    ```bash
    docker logs <NOMBRE_DEL_CONTENEDOR>
    ```

---

## 🧭 PASO 4: Restaurar en la base deseada

### Restaurar en `dev`

```bash
psql -U postgres -d dev -f supabase_backup.sql
```

### Restaurar en `prod`

```bash
psql -U postgres -d prod -f supabase_backup.sql
```

💡 Si usaste `--clean`, se eliminarán objetos antes de crearlos.
Si no deseas borrar nada existente, realiza el backup con `--data-only`.

---

## 🧭 PASO 5: Verificar la restauración

Entra a la base restaurada:

```bash
psql -U postgres -d dev
```

Listar tablas:

```sql
\dt
```

Verificar datos:

```sql
SELECT COUNT(*) FROM clientes;
```

---

## 🧱 RESUMEN RÁPIDO

| Etapa                | Comando (Windows)                                                                                                                                                         | Descripción      |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------- |
| 1️⃣ Backup Supabase  | `pg_dump --host=db.aavmxjmkiaevxyiyztsc.supabase.co --port=5432 --username=postgres --dbname=postgres --format=p --clean --if-exists --no-owner --no-privileges --verbose --file="supabase_backup.sql"` | Crea el backup   |
| 2️⃣ Subir a servidor | `scp supabase_backup.sql usuario@host:/home/usuario/`                                                                                                                     | Copia el archivo |
| 3️⃣ Restaurar        | `psql -U postgres -d dev -f supabase_backup.sql`                                                                                                                          | Restaura la BD   |
| 4️⃣ Verificar        | `psql -U postgres -d dev` y `\dt`                                                                                                                                         | Comprueba tablas |

---

## ⚙️ Tip adicional (solo datos)

Si solo deseas migrar datos (sin estructura), ejecuta en **una sola línea**:

```bash
pg_dump --host=db.aavmxjmkiaevxyiyztsc.supabase.co --port=5432 --username=postgres --dbname=postgres --data-only --no-owner --no-privileges --file="supabase_data.sql"
```

Y luego:

```bash
psql -U postgres -d dev -f supabase_data.sql
```

---

## 🧰 Opcional: Script automático para Windows

Puedes crear un archivo `restore_supabase.bat` para automatizarlo:

```batch
@echo off
set DB_TARGET=%1
if "%DB_TARGET%"=="" (
  echo Uso: restore_supabase.bat ^<nombre_bd^>
  exit /b 1
)

echo Restaurando backup en base: %DB_TARGET%...
psql -U postgres -d %DB_TARGET% -f supabase_backup.sql
echo ✅ Restauracion completada en %DB_TARGET%.
```

Luego ejecutas en **CMD** o **PowerShell**:

```bash
restore_supabase.bat dev
```

---

## 📝 Notas importantes para Windows

- Asegúrate de tener **PostgreSQL** instalado y `pg_dump`/`psql` en el PATH.
- Para verificar, ejecuta: `pg_dump --version`
- Si usas **PowerShell**, los comandos son los mismos que en Linux/Mac.
- Si no tienes `scp`, instala **OpenSSH Client** desde Windows Features o usa **WinSCP**.

---

✍️ **Autor:**  
Guía creada para restaurar backups de **Supabase** en entornos `dev` y `prod` desde **Windows**.

📅 Última actualización: Octubre 2025
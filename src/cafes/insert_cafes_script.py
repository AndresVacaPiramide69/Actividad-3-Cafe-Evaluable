import csv
import psycopg2
from psycopg2 import extras
import uuid
import re

# Configuración de la conexión a PostgreSQL
DB_PARAMS = {
    "dbname": "cafes-evaluable",
    "user": "postgres",
    "password": "postgres123",
    "host": "db-cafes.clu0u0o2607s.us-east-1.rds.amazonaws.com",
    "port": "5432"
}

def generate_tienda_email(tienda_nombre):
    """Genera un email único basado en el nombre de la tienda"""
    # Limpiar y normalizar el nombre
    email_local = tienda_nombre.strip().lower()
    email_local = re.sub(r'[^\w\s-]', '', email_local)  # Eliminar caracteres especiales
    email_local = re.sub(r'[\s_-]+', '_', email_local)  # Reemplazar espacios y guiones por _
    return f"{email_local}@example.com"

def insert_tienda_if_not_exists(cursor, tienda_nombre, tienda_email):
    """Inserta la tienda en la base de datos si no existe."""
    query = """
        INSERT INTO "tienda" (nombre, email, password, domicilio)
        VALUES (%s, %s, %s, %s)
        ON CONFLICT (nombre, email) DO NOTHING;
    """
    domicilio = f"Dirección desconocida para {tienda_nombre}"
    password = "passwordseguro123"
    cursor.execute(query, (tienda_nombre, tienda_email, password, domicilio))

def insert_cafes_bulk(cursor, cafes):
    """Inserta múltiples cafés en la base de datos en una sola consulta."""
    query = """
        INSERT INTO "cafe" (nombre, origen, tueste, tienda_nombre, tienda_email, precio, peso)
        VALUES %s
        ON CONFLICT DO NOTHING;
    """
    psycopg2.extras.execute_values(cursor, query, cafes)

def cargar_csv_a_db(csv_path):
    """Lee un archivo CSV y lo inserta en la base de datos en lotes grandes."""
    try:
        conn = psycopg2.connect(**DB_PARAMS)
        cursor = conn.cursor()
        
        cafes_batch = []
        batch_size = 1000  # Insertar en lotes de 1000 filas
        
        with open(csv_path, newline='', encoding='utf-8') as csvfile:
            reader = csv.reader(csvfile)
            for row in reader:
                if len(row) == 6:
                    nombre, tueste, precio, peso, origen, tienda = row
                    try:
                        # Convertir tipos numéricos
                        precio = float(precio)
                        peso = int(peso)
                        
                        # Generar email para la tienda
                        tienda_email = generate_tienda_email(tienda)
                        
                        # Insertar tienda si no existe
                        insert_tienda_if_not_exists(cursor, tienda, tienda_email)
                        
                        # Añadir café al lote
                        cafes_batch.append((
                            nombre,
                            origen,
                            tueste,
                            tienda,         # tienda_nombre
                            tienda_email,
                            precio,
                            peso
                        ))
                        
                        # Insertar si el lote alcanza el tamaño límite
                        if len(cafes_batch) >= batch_size:
                            insert_cafes_bulk(cursor, cafes_batch)
                            cafes_batch = []
                            
                    except ValueError as e:
                        print(f"Error en conversión de datos: {row} - {str(e)}")
        
        # Insertar cafés restantes
        if cafes_batch:
            insert_cafes_bulk(cursor, cafes_batch)
        
        # Confirmar cambios
        conn.commit()
        print("Datos insertados correctamente.")
        
        cursor.close()
        conn.close()
    
    except Exception as e:
        print(f"Error al conectar a la base de datos: {e}")
        if 'conn' in locals():
            conn.rollback()

if __name__ == "__main__":
    cargar_csv_a_db("/home/andres/Documentos/DWES/Actividad-3-Cafe-Evaluable/src/cafes/cafes.csv")  # Asegúrate de que el CSV tenga el formato correcto
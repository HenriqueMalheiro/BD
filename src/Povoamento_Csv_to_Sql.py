import os
import csv
import mysql.connector

# Configurações do banco de dados
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'Henriquenuno16',
    'database': 'Biblioteca_MariaJudite'
}

# Diretório dos arquivos CSV
csv_directory = os.getcwd()

# Conectar ao banco de dados
conn = mysql.connector.connect(**db_config)
cursor = conn.cursor()

# Função para inserir dados na tabela
def insert_data(table_name, data):
    placeholders = ', '.join(['%s'] * len(data[0]))
    columns = ', '.join(data[0].keys())
    query = f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders})"
    values = [tuple(row.values()) for row in data]
    cursor.executemany(query, values)
    conn.commit()

# Definir a ordem das tabelas (de pais para filhos)
table_order = ['Funcionário', 'Leitor', 'Nº_Telemóvel', 'Sala_de_Estudo', 'Livro', 'Reserva_Livro', 'ReservaLivro_Livro']

# Percorrer as tabelas na ordem especificada
for table_name in table_order:
    filename = table_name + '.csv'
    csv_path = os.path.join(csv_directory, filename)
    
    # Verificar se o arquivo CSV existe
    if not os.path.exists(csv_path):
        print(f"Arquivo CSV {filename} não encontrado.")
        continue
    
    # Ler dados do arquivo CSV
    with open(csv_path, 'r') as csv_file:
        csv_reader = csv.DictReader(csv_file)
        data = [row for row in csv_reader]
    
    # Inserir dados na tabela correspondente
    try:
        insert_data(table_name, data)
        print(f"Dados inseridos na tabela {table_name}.")
    except mysql.connector.Error as err:
        print(f"Erro ao inserir dados na tabela {table_name}: {err}")
    except Exception as e:
        print(f"Erro: {e}")

# Fechar a conexão com o banco de dados
cursor.close()
conn.close()

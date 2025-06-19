import os
import psycopg
from flask import Flask, render_template, request, redirect, url_for

DB_HOST = os.environ.get('DB_HOST', 'localhost')
DB_NAME = os.environ.get('DB_NAME', 'sistema_streaming') 
DB_USER = os.environ.get('DB_USER', 'postgres')
DB_PASSWORD = os.environ.get('DB_PASSWORD', '123456')

app = Flask(__name__)
app.secret_key = 'chave_aleatoria!@#'


def get_db_connection():
    conn = None
    try:
        conn = psycopg.connect(
            host=DB_HOST,
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD
        )
        return conn
    except psycopg.Error as e:
        print(f"DEBUG: Erro ao conectar ao banco de dados: {e}")
        return None

@app.route('/')
def index():
    """
    Rota principal: Lista todos os usuários.
    Operação: READ
    """
    conn = get_db_connection() 
    if conn is None: 
        print("DEBUG: Conexão com o banco falhou no Flask (get_db_connection retornou None)")
        return "Erro ao conectar ao banco de dados. Verifique suas credenciais.", 500

    cur = conn.cursor() 
    users = [] 
    try:
        sql_query = "SELECT id_usuario, nome, email, data_nascimento FROM public.usuarios ORDER BY id_usuario DESC;"
        print(f"DEBUG: Executando SQL: {sql_query}")
        cur.execute(sql_query)
        users = cur.fetchall() 
        print(f"DEBUG: Usuários encontrados por fetchall(): {users}") 
    except psycopg.Error as e:
        print(f"DEBUG: Erro ao buscar usuários no Flask: {e}")
    finally:
        cur.close() 
        conn.close() 
    
    return render_template('index.html', users=users)

if __name__ == '__main__':
    app.run(debug=True)
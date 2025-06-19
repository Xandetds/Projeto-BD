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
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None


@app.route('/')
def index():
    """
    Main route: Lists all users.
    Operation: READ
    """
    conn = get_db_connection()
    if conn is None:
        return "Erro ao conectar ao banco de dados. Verifique suas credenciais.", 500

    cur = conn.cursor()
    users = []
    try:
        cur.execute("SELECT id_usuario, nome, email, data_nascimento FROM public.usuarios ORDER BY id_usuario DESC;")
        users = cur.fetchall()
    except psycopg.Error as e:
        print(f"Erro ao buscar usuários: {e}")
    finally:
        cur.close()
        conn.close()
    
    return render_template('index.html', users=users)

@app.route('/add', methods=('GET', 'POST'))
def add_user():
    
    if request.method == 'POST':
        nome = request.form['nome']
        email = request.form['email']
        senha = request.form['senha']
        data_nascimento = request.form['data_nascimento']

        conn = get_db_connection()
        if conn is None:
            return "Erro ao conectar ao banco de dados.", 500

        cur = conn.cursor()
        try:
            cur.execute(
                "INSERT INTO public.usuarios (nome, email, senha, data_nascimento) VALUES (%s, %s, %s, %s);",
                (nome, email, senha, data_nascimento)
            )
            conn.commit()
            return redirect(url_for('index'))
        except psycopg.Error as e:
            conn.rollback()
            print(f"Erro ao adicionar usuário: {e}")
            return render_template('add_user.html', error="Erro ao adicionar usuário. Verifique os dados (e-mail já pode existir!).")
        finally:
            cur.close()
            conn.close()
    
    return render_template('add_user.html')

@app.route('/edit/<int:user_id>', methods=('GET', 'POST'))
def edit_user(user_id):
    conn = get_db_connection()
    if conn is None:
        return "Erro ao conectar ao banco de dados.", 500

    cur = conn.cursor()
    user = None

    try:
        cur.execute("SELECT id_usuario, nome, email, senha, data_nascimento FROM public.usuarios WHERE id_usuario = %s;", (user_id,))
        user = cur.fetchone()

        if user is None:
            return "Usuário não encontrado.", 404
    except psycopg.Error as e:
        print(f"Erro ao buscar usuário para edição: {e}")
        cur.close()
        conn.close()
        return "Erro interno.", 500

    if request.method == 'POST':
        nome = request.form['nome']
        email = request.form['email']
        senha = request.form['senha']
        data_nascimento = request.form['data_nascimento']

        try:
            cur.execute(
                "UPDATE public.usuarios SET nome = %s, email = %s, senha = %s, data_nascimento = %s WHERE id_usuario = %s;",
                (nome, email, senha, data_nascimento, user_id)
            )
            conn.commit()
            return redirect(url_for('index'))
        except psycopg.Error as e:
            conn.rollback()
            print(f"Erro ao atualizar usuário: {e}")
            return render_template('edit_user.html', user=user, error="Erro ao atualizar usuário. Verifique os dados.")
        finally:
            cur.close()
            conn.close()
    else:
        cur.close()
        conn.close()
        return render_template('edit_user.html', user=user)

@app.route('/delete/<int:user_id>', methods=('POST',))
def delete_user(user_id):
    conn = get_db_connection()
    if conn is None:
        return "Erro ao conectar ao banco de dados.", 500

    cur = conn.cursor()
    try:
        cur.execute("DELETE FROM public.usuarios WHERE id_usuario = %s;", (user_id,))
        conn.commit()
        return redirect(url_for('index'))
    except psycopg.Error as e:
        conn.rollback()
        print(f"Erro ao deletar usuário: {e}")
        return redirect(url_for('index', error="Erro ao deletar usuário."))
    finally:
        cur.close()
        conn.close()

if __name__ == '__main__':
    app.run(debug=True)
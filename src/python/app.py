import os 
import psycopg2 
from flask import Flask, render_template, request, redirect, url_for 


DB_HOST = os.environ.get('DB_HOST', 'localhost') 
DB_NAME = os.environ.get('DB_NAME', 'sistema_streaming') 
DB_USER = os.environ.get('DB_USER', 'postgres') 
DB_PASSWORD = os.environ.get('DB_PASSWORD', '123456') 

# --- Configuração do Aplicativo Flask ---
app = Flask(__name__) 

app.secret_key = '\\xc0\\x8c\\x16\\x9a\\x11\\x8d\\xf3\\x01\\xf1\\xd8\\x87\\x07\\x97\\x8b\\x0f\\x0a\\x0d\\xf9\\xc2\\x0b\\x93\\xeb' 

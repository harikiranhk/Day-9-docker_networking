from flask import Flask, jsonify
import os
import psycopg2

app = Flask(__name__)

@app.route('/')
def hello():
    return jsonify({"message": "Hello from Flask!"})

@app.route('/db-test')
def db_test():
    conn = psycopg2.connect(
        host=os.environ.get('DB_HOST'),
        database=os.environ.get('DB_NAME'),
        user=os.environ.get('DB_USER'),
        password=os.environ.get('DB_PASSWORD')
    )
    cur = conn.cursor()
    cur.execute('SELECT 1')
    result = cur.fetchone()[0]
    cur.close()
    conn.close()
    return jsonify({"db_connection": "successful", "result": result})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
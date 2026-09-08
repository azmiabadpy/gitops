
from flask import Flask, jsonify
import os
import mysql.connector

app = Flask(__name__)


def get_db_connection():
    return mysql.connector.connect(
        host=os.environ["MYSQL_HOST"],
        user=os.environ["MYSQL_USER"],
        password=os.environ["MYSQL_PASSWORD"],
        database=os.environ["MYSQL_DATABASE"],
        port=int(os.environ.get("MYSQL_PORT", 3306))
    )


@app.route("/")
def home():
    return jsonify({
        "message": "Backend is running",
        "status": "success"
    })


@app.route("/api/data")
def get_data():

    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    cursor.execute("SELECT * FROM users")

    data = cursor.fetchall()

    cursor.close()
    connection.close()

    return jsonify(data)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)


import os

from flask import Flask, jsonify
import mysql.connector
from mysql.connector import Error


app = Flask(__name__)


def get_db_connection():
    """
    Database credentials are provided at runtime
    through Kubernetes environment variables.
    """

    required_variables = [
        "DB_HOST",
        "DB_NAME",
        "DB_USER",
        "DB_PASSWORD"
    ]

    missing_variables = [
        variable
        for variable in required_variables
        if not os.getenv(variable)
    ]

    if missing_variables:
        raise RuntimeError(
            f"Missing database environment variables: "
            f"{', '.join(missing_variables)}"
        )

    return mysql.connector.connect(
        host=os.getenv("DB_HOST"),
        port=int(os.getenv("DB_PORT", "3306")),
        database=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        connection_timeout=10
    )


@app.route("/")
def home():
    return jsonify({
        "message": "GitOps backend is running successfully"
    })


@app.route("/health")
def health():
    return jsonify({
        "status": "healthy"
    }), 200


@app.route("/api/data")
def get_data():
    connection = None
    cursor = None

    try:
        connection = get_db_connection()

        cursor = connection.cursor(dictionary=True)

        # Does not require us to create a table beforehand.
        cursor.execute("""
            SELECT
                DATABASE() AS database_name,
                NOW() AS database_time
        """)

        result = cursor.fetchone()

        return jsonify({
            "success": True,
            "message": "Backend successfully connected to RDS MySQL",
            "data": result
        }), 200

    except RuntimeError as error:
        return jsonify({
            "success": False,
            "message": str(error)
        }), 503

    except Error as error:
        print(f"Database error: {error}")

        return jsonify({
            "success": False,
            "message": "Unable to connect to database"
        }), 503

    finally:
        if cursor:
            cursor.close()

        if connection and connection.is_connected():
            connection.close()


if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=5000,
        debug=False
    )
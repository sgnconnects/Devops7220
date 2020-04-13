from flask import Flask, jsonify
import pymongo
from uuid import UUID

# Flask app configuration
app = Flask(__name__)

# MongoDB Configuration
client = pymongo.MongoClient("mongodb+srv://root:Onepiece181195@cyril-spa-zudqm.mongodb.net/Devops7220?retryWrites=true&w=majority", 27017)
db = client.Devops7220
collection = db.crypto_currencies

@app.route('/coins')
def coins():
    try:
        result = list(collection.find())
        return jsonify(result), 200
    except Exception as e:
        result = {"error": e}
        return jsonify(result), 400


@app.route('/coin/<coin_id>')
def get_coin(coin_id):
    try:
        result = collection.find_one({"_id": UUID(coin_id)})
        return jsonify(result), 200
    except Exception as e:
        result = {"error": e}
        return jsonify(result), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
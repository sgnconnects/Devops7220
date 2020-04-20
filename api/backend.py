from flask import Flask, jsonify, request, Response, url_for, redirect
import pymongo
from uuid import UUID
import os
import time
import prometheus_client
from prometheus_client import Counter, Histogram

# Prometheus Client Configuration
graphs = {}
graphs['c'] = Counter('request_counter_total', "HTTP Requests", ['method', 'endpoint'])
graphs['h'] = Histogram('request_histogram_total', 'HTTP Requests', ['method', 'endpoint'])


# Flask app configuration
app = Flask(__name__)

# MongoDB Configuration
mongodb_url = "mongodb+srv://"+os.environ['MONGODB_USR']+":"+os.environ['MONGODB_PWD']+"@cyril-spa-zudqm.mongodb.net/Devops7220?retryWrites=true&w=majority"
print(mongodb_url)
client = pymongo.MongoClient(mongodb_url, 27017)
db = client.Devops7220
collection = db.crypto_currencies


# API
@app.route('/')
def root():
    return redirect(url_for('coins'))

@app.route('/health')
def health():
    return jsonify(None), 200

@app.route('/coins')
def coins():
    start = time.time()
    graphs['c'].labels(method='get', endpoint='/coins').inc()
    status_code = None

    try:
        result = list(collection.find())
        status_code = 200
    except Exception as e:
        result = {"error": e}
        status_code = 400

    end = time.time()
    graphs['h'].labels(method='get', endpoint='/coins').observe(end - start)
    return jsonify(result), status_code


@app.route('/coins/<coin_id>')
def get_coin(coin_id):
    start = time.time()
    graphs['c'].labels(method='get', endpoint='/coins/'+coin_id).inc()
    status_code = None

    try:
        result = collection.find_one({"_id": UUID(coin_id)})
        status_code = 200
    except Exception as e:
        result = {"error": str(e)}
        status_code = 400

    end = time.time()
    graphs['h'].labels(method='get', endpoint='/coins/'+coin_id).observe(end - start)
    return jsonify(result), status_code

@app.route("/metrics")
def requests_count():
    res = []
    for v in graphs.items():
        res.append(prometheus_client.generate_latest(v))

    return Response(res, mimetype="text/plain")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
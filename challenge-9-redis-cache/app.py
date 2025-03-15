from flask import Flask, jsonify
import redis
import time
import os

app = Flask(__name__)
cache = redis.Redis(host='redis', port=6379)

def get_hit_count():
    retries = 5
    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as e:
            if retries == 0:
                raise e
            retries -= 1
            time.sleep(0.5)

@app.route('/')
def hello():
    count = get_hit_count()
    return jsonify({
        'message': 'Hello from Flask!',
        'cache_hits': count,
        'cache_status': 'connected'
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
from flask import Flask, jsonify
import time

app = Flask(__name__)

@app.route('/')
def get_epoch_time():
    epoch_time = int(time.time())
    return jsonify({"The current epoch time": epoch_time})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')

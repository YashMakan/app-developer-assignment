from blueprints.auth import blueprint as auth_blueprint
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'login mock api!'

app.register_blueprint(auth_blueprint)
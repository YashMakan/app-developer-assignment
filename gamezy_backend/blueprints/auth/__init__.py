from flask import Blueprint, request
from models.response import Response
from models.users import users

blueprint = Blueprint('auth_blueprint', __name__, url_prefix='/auth')

@blueprint.route('/login', methods=["POST"])
def login():
  username = request.form.get('username')
  password = request.form.get('password')
  if [username, password] in users:
    return Response(200, 0, 'Logged in successfully').get_response()
  else:
    return Response(404, 1, 'Invalid username or password').get_response()
  
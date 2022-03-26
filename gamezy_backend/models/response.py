class Response:
  
  def __init__(self, status, code, message):
    self.status = status
    self.code = code
    self.message = message

  def get_response(self):
    return {
      'status': self.status,
      'code': self.code,
      'message': self.message
    }
    
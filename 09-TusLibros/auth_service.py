
class AuthService:

    'initialize'

    def __init__(self):
        self.users = { 'juan' : '1234', 'mariana' : '5678'}

    'authentication'

    def authenticate(self, user_id, password):
        return user_id in self.users and self.users[user_id] == password

import uuid
from auth_service import AuthService
from cart import Cart

class EntryPoint:

    'initialize'

    def __init__(self, a_catalogue):
        self._auth_service = AuthService()
        self._catalogue = a_catalogue
        self._carts = {}

    'adding'

    def createCart(self, user_id, password):
        if not self._auth_service.authenticate(user_id, password):
            raise Exception('Invalid credentials')

        cart = Cart.accepting_items_of(self._catalogue)
        cart_id = uuid.uuid4().hex
        self._carts[cart_id] = cart
        return cart_id
    
    def addToCart(self, cart_id, book_isbn, book_quantity):
        self._assert_cart_id_is_valid(cart_id)
        self._carts[cart_id].add_with_quantity(book_isbn, book_quantity)

    'accessing'
    
    def listCart(self, cart_id):
        self._assert_cart_id_is_valid(cart_id)
        cart = self._carts[cart_id]
        content = {}
        for book in self._catalogue:
            if cart.includes(book):
                content[book] = cart.quantity_of(book)
        return content

    'private - assertions'

    def _assert_cart_id_is_valid(self, a_cart_id):
        if a_cart_id not in self._carts:
            raise Exception('Invalid cart ID')

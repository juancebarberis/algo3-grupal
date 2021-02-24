import uuid
from cart import Cart
from cashier import Cashier


class EntryPoint:

    'initialize'

    def __init__(self, a_catalogue, merchant_processor, auth_service, datetime_object):
        self._auth_service = auth_service
        self._catalogue = a_catalogue
        self._merchant_processor = merchant_processor
        self._datetime_object = datetime_object
        self._carts = {}
        self._users_carts = {}
        self._sales = {}
        self._carts_last_update_time = {}

    'adding'

    def createCart(self, user_id, password):
        self._assert_user_and_password_are_valid(user_id, password)

        cart = Cart.accepting_items_of(self._catalogue)
        cart_id = uuid.uuid4().hex
        self._carts[cart_id] = cart
        self._carts_last_update_time[cart_id] = self._datetime_object.now()

        if user_id in self._users_carts:
            self._users_carts[user_id].append(cart_id)
        else:
            self._users_carts[user_id] = [cart_id] 

        return cart_id

    def addToCart(self, cart_id, book_isbn, book_quantity):
        self._assert_cart_id_is_valid(cart_id)
        self._assert_cart_is_valid(cart_id)
        self._update_last_time(cart_id)
        self._carts[cart_id].add_with_quantity(book_isbn, book_quantity)

    'accessing'

    def listCart(self, cart_id):
        self._assert_cart_id_is_valid(cart_id)
        self._assert_cart_is_valid(cart_id)
        self._update_last_time(cart_id)

        cart = self._carts[cart_id]
        content = {}
        for book in self._catalogue:
            if cart.includes(book):
                content[book] = cart.quantity_of(book)
        return content

    def listPurchases(self, user_id, password):
        self._assert_user_and_password_are_valid(user_id, password)

        user_carts_ids = self._users_carts[user_id] if user_id in self._users_carts else []
        total_amount = 0
        purchases = {}
        
        for cart_id in user_carts_ids:
            if cart_id in self._sales:
                sales_book = self._sales[cart_id]
                total_amount += sales_book
                purchases = self._merge_purchases_dictionary(self.listCart(cart_id), purchases) 

        return {"total_amount": total_amount, "purchases": purchases}

    'checkout'

    def checkOutCart(self, cart_id, credit_card):
        self._assert_cart_id_is_valid(cart_id)
        self._assert_cart_is_valid(cart_id)
        self._update_last_time(cart_id)

        cashier = Cashier.registering_sales_on([])
        total_amount = cashier.checkout(self._carts[cart_id], credit_card, self._merchant_processor, self._datetime_object.now())
        transaction_id = uuid.uuid4().hex

        self._sales[cart_id] = total_amount

        return transaction_id
        
    'private'

    def _merge_purchases_dictionary(self, to_merge_purchases_dictionary, base_purchases):
        for book_id in to_merge_purchases_dictionary:
            if book_id in base_purchases:
                base_purchases[book_id] += to_merge_purchases_dictionary[book_id] 
            else:
                base_purchases[book_id] = to_merge_purchases_dictionary[book_id]
        return base_purchases

    def _update_last_time(self, cart_id):
        self._carts_last_update_time[cart_id] = self._datetime_object.now() 

    'private - assertions'

    def _assert_cart_id_is_valid(self, a_cart_id):
        if a_cart_id not in self._carts:
            raise Exception('Invalid cart ID')

    def _assert_user_and_password_are_valid(self, user_id, password):
        if not self._auth_service.authenticate(user_id, password):
            raise Exception('Invalid credentials')
    
    def _assert_cart_is_valid(self, cart_id):
        thirty_minutes_in_second = 1800
        if (self._datetime_object.now() - self._carts_last_update_time[cart_id]).seconds >= thirty_minutes_in_second:
            raise Exception('Cart is no longer valid')

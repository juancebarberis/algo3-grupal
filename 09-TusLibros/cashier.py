class Cashier:
    'instance creation'

    @classmethod
    def registering_sales_on(cls, sales_book):
        return cls(sales_book)

    'error messages'

    @classmethod
    def cannot_checkout_an_empty_cart_error_message(cls):
        return "Cannot checkout an empty cart"

    @classmethod
    def cannot_checkout_using_an_expired_card_error_message(cls):
        return "Cannot checkout using an expired card"

    @classmethod
    def could_not_process_payment_error_message(cls):
        return "Cannot checkout using an expired card"

    'initialization'

    def __init__(self, sales_book):
        self._sales_book = sales_book

    'checkout'

    def checkout(self, cart, credit_card, merchant_processor, checkout_datetime):
        self.assert_can_checkout(cart, credit_card, checkout_datetime)

        ticket = cart.total()

        self.debit_credit_card(ticket, credit_card, merchant_processor)

        self.register_sale(ticket)

        return ticket

    'assertions'

    def assert_can_checkout(self, cart, credit_card, checkout_datetime):
        self.assert_contains_books(cart)
        self.assert_is_not_expired(credit_card, checkout_datetime)

    def assert_contains_books(self, cart):
        if cart.is_empty():
            raise RuntimeError(self.__class__.cannot_checkout_an_empty_cart_error_message())

    def assert_is_not_expired(self, credit_card, a_datetime):
        if credit_card.is_expired_on(a_datetime):
            raise RuntimeError(self.__class__.cannot_checkout_using_an_expired_card_error_message())

    'private'

    def debit_credit_card(self, an_amount_to_debit, credit_card, merchant_processor):
        try:
            return merchant_processor.debit_credit_card(an_amount_to_debit, credit_card)
        except RuntimeError:
            raise RuntimeError(self.__class__.could_not_process_payment_error_message())

    def register_sale(self, ticket):
        self._sales_book.append(ticket)

from datetime import datetime

from cart import Cart
from cashier import Cashier
from credit_card import CreditCard
from month_of_year import MonthOfYear


class PublisherTestObjectsFactory:
    def a_cashier(self):
        sales_book = []
        return Cashier.registering_sales_on(sales_book)

    def a_valid_credit_card(self):
        june_next_year = MonthOfYear(6, self.now().year + 1)
        return CreditCard.new_with('Juan Perez', 11111111, june_next_year)

    def an_empty_cart(self):
        a_catalog = {self.book_from_the_editorial(): self.book_from_the_editorial_price()}
        return Cart.accepting_items_of(a_catalog)

    def an_empty_sales_book(self):
        return []

    def an_expired_credit_card(self):
        june_last_year = MonthOfYear(6, self.now().year - 1)
        return CreditCard.new_with('Juan Perez', 11111111, june_last_year)

    def book_from_the_editorial(self):
        return 'ABC123'

    def book_from_the_editorial_price(self):
        return 1000

    def cart_with_a_book(self):
        cart = self.an_empty_cart()
        cart.add(self.book_from_the_editorial())
        return cart

    def now(self):
        return datetime.now()

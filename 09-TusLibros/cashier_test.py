from unittest import TestCase

from cashier import Cashier
from publisher_test_objects_factory import PublisherTestObjectsFactory


class CashierTest(TestCase):

    def setUp(self):
        self._objects_factory = PublisherTestObjectsFactory()
        self._merchant_processor_behaviour = lambda an_amount_to_debit, a_credit_card: None

    'tests'

    def test01_cannot_checkout_an_empty_carty(self):
        cart = self._objects_factory.an_empty_cart()
        sales_book = self._objects_factory.an_empty_sales_book()
        cashier = Cashier.registering_sales_on(sales_book)

        try:
            self.checkout(cart, cashier)
            self.fail()
        except Exception as expected_exception:
            self.assertEqual(str(expected_exception), Cashier.cannot_checkout_an_empty_cart_error_message())
            self.assertTrue(len(sales_book) == 0)

    def test02_total_is_calculated_correctly_after_checkout(self):
        cart = self._objects_factory.cart_with_a_book()
        cashier = self._objects_factory.a_cashier()

        ticket = self.checkout(cart, cashier)

        self.assertEqual(self._objects_factory.book_from_the_editorial_price(), ticket)

    def test03_cannot_checkout_if_card_is_expired(self):
        cart = self._objects_factory.cart_with_a_book()
        sales_book = self._objects_factory.an_empty_sales_book()
        cashier = Cashier.registering_sales_on(sales_book)

        merchant_processor_was_contacted = False

        def new_mp_behaviour(_an_amount_to_debit, _a_credit_card):
            nonlocal merchant_processor_was_contacted
            merchant_processor_was_contacted = True

        self.set_merchant_process_behaviour(new_mp_behaviour)

        try:
            self.checkout_with_card(cart, cashier, self._objects_factory.an_expired_credit_card())
            self.fail()
        except Exception as expected_exception:
            self.assertEqual(str(expected_exception), Cashier.cannot_checkout_using_an_expired_card_error_message())
            self.assertFalse(merchant_processor_was_contacted)
            self.assertTrue(len(sales_book) == 0)

    def test04_checkout_debits_credit_card_using_merchant_processor(self):
        cart = self._objects_factory.cart_with_a_book()
        cashier = self._objects_factory.a_cashier()
        credit_card = self._objects_factory.a_valid_credit_card()
        debited_amount_from_credit_card = None
        debited_credit_card = None

        def new_mp_behaviour(an_amount_to_debit, a_credit_card):
            nonlocal debited_amount_from_credit_card, debited_credit_card
            debited_amount_from_credit_card = an_amount_to_debit
            debited_credit_card = a_credit_card

        self.set_merchant_process_behaviour(new_mp_behaviour)

        ticket = self.checkout_with_card(cart, cashier, credit_card)

        self.assertEqual(debited_amount_from_credit_card, ticket)
        self.assertEqual(debited_credit_card, credit_card)

    def test05_checkout_fails_if_merchant_processor_cant_process_payment(self):
        cart = self._objects_factory.cart_with_a_book()
        sales_book = self._objects_factory.an_empty_sales_book()
        cashier = Cashier.registering_sales_on(sales_book)

        def new_mp_behaviour(_an_amount_to_debit, _credit_card):
            raise RuntimeError()

        self.set_merchant_process_behaviour(new_mp_behaviour)

        try:
            self.checkout(cart, cashier)
            self.fail()
        except Exception as expected_exception:
            self.assertEqual(str(expected_exception), Cashier.could_not_process_payment_error_message())
            self.assertTrue(len(sales_book) == 0)

    def test06_checkout_registers_a_sale(self):
        cart = self._objects_factory.cart_with_a_book()
        sales_book = self._objects_factory.an_empty_sales_book()
        cashier = Cashier.registering_sales_on(sales_book)

        ticket = self.checkout(cart, cashier)

        self.assertEqual(len(sales_book), 1)
        self.assertEqual(sales_book[0], ticket)

    'merchant procesot protocol'

    def debit_credit_card(self, amount_to_debit, credit_card):
        return self._merchant_processor_behaviour(amount_to_debit, credit_card)

    'change mp behaviour'

    def set_merchant_process_behaviour(self, new_behaviour):
        self._merchant_processor_behaviour = new_behaviour

    'private'

    def checkout(self, cart, cashier):
        return self.checkout_with_card(cart, cashier, self._objects_factory.a_valid_credit_card())

    def checkout_with_card(self, cart, cashier, credit_card):
        return cashier.checkout(cart, credit_card, self.merchant_processor_for_test(), self._objects_factory.now())

    def merchant_processor_for_test(self):
        return self

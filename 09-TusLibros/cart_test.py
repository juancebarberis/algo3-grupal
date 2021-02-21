from unittest import TestCase

from cart import Cart

from publisher_test_objects_factory import PublisherTestObjectsFactory


class CartTest(TestCase):
    def setUp(self):
        self._objects_factory = PublisherTestObjectsFactory()

    'tests'

    def test01_new_cart_is_empty(self):
        cart = self.create_cart()

        self.assertTrue(cart.is_empty())

    def test02_adding_a_book_cart_is_not_empty_anymore(self):
        cart = self.create_cart()

        cart.add(self._objects_factory.book_from_the_editorial())

        self.assertFalse(cart.is_empty())

    def test03_cannot_add_a_book_not_in_catalog(self):
        cart = self.create_cart()

        a_book_not_from_the_editorial = 'DEF456'

        self.assert_raises_error_and_cart_remains_empty(
            lambda: cart.add(a_book_not_from_the_editorial),
            Cart.cannot_add_book_not_in_catalog_error_message(),
            cart)

    def test04_can_add_two_copies_of_the_same_book(self):
        cart = self.create_cart()

        cart.add_with_quantity(self._objects_factory.book_from_the_editorial(), 2)

        self.assertEqual(2, cart.quantity_of(self._objects_factory.book_from_the_editorial()))

    def test05_cannot_add_a_non_positive_number_of_copies(self):
        cart = self.create_cart()

        self.assert_raises_error_and_cart_remains_empty(
            lambda: cart.add_with_quantity(self._objects_factory.book_from_the_editorial(), -1),
            Cart.cannot_add_a_non_positive_number_of_copies_error_message(),
            cart)

    def test06_cart_remembers_added_books(self):
        cart = self.create_cart()
        cart.add_with_quantity(self._objects_factory.book_from_the_editorial(), 2)
        cart.add_with_quantity(self._objects_factory.book_from_the_editorial(), 1)

        self.assertTrue(cart.includes(self._objects_factory.book_from_the_editorial()))
        self.assertEquals(3, cart.quantity_of(self._objects_factory.book_from_the_editorial()))

    def test07_cannot_add_a_two_copies_of_a_book_not_in_catalog(self):
        cart = self.create_cart()

        a_book_not_from_the_editorial = 'DEF456'

        self.assert_raises_error_and_cart_remains_empty(
            lambda: cart.add_with_quantity(a_book_not_from_the_editorial, 2),
            Cart.cannot_add_book_not_in_catalog_error_message(),
            cart)

    'private'

    def assert_raises_error_and_cart_remains_empty(self, a_block_expected_to_fail, expected_error_message, cart):
        try:
            a_block_expected_to_fail()
            self.fail()
        except Exception as expected_exception:
            self.assertEqual(str(expected_exception), expected_error_message)
            self.assertTrue(cart.is_empty())

    def create_cart(self):
        return self._objects_factory.an_empty_cart()

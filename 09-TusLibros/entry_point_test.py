import unittest
from entry_point import EntryPoint
from publisher_test_objects_factory import PublisherTestObjectsFactory

class EntryPointTest(unittest.TestCase):

    def setUp(self):
        self._objects_factory = PublisherTestObjectsFactory()
        self.entry_point = EntryPoint({self._objects_factory.book_from_the_editorial(): self._objects_factory.book_from_the_editorial_price()})
        self.cart_id_length = 32

    'tests'

    def test01_a_cart_cannot_be_created_with_invalid_credentials(self):
        try:
            self.entry_point.createCart('pepe', '9999')
        except Exception as expected_exception:
            self.assertEqual(str(expected_exception), 'Invalid credentials')
    
    def test02_a_cart_is_created_with_valid_credentails(self):
        self.assertEqual(len(self.entry_point.createCart('juan', '1234')), self.cart_id_length)

    def test03_a_book_can_be_added_to_a_cart(self):
        cart_id = self.entry_point.createCart('mariana', '5678')
        self.assertIsNone(self.entry_point.addToCart(cart_id, self._objects_factory.book_from_the_editorial(), 1))
    
    def test04_a_book_cannot_be_added_to_an_invalid_cart_id(self):
        try:
            self.entry_point.addToCart('xkajgñlkagjimbi246875', self._objects_factory.book_from_the_editorial(), 1)
        except Exception as expected_exception:
            self.assertEqual(str(expected_exception), 'Invalid cart ID')

    def test05_a_cart_can_list_its_content(self):
        cart_id = self.entry_point.createCart('mariana', '5678')
        self.entry_point.addToCart(cart_id, self._objects_factory.book_from_the_editorial(), 1)
        self.assertEqual(self.entry_point.listCart(cart_id), {self._objects_factory.book_from_the_editorial() : 1})
    
    def test06_a_cart_cannot_be_listed_with_an_invalid_id(self):
        try:
            self.entry_point.listCart('xkajgñlkagjimbi246875')
        except Exception as expected_exception:
            self.assertEqual(str(expected_exception), 'Invalid cart ID')
    
if __name__ == '__main__':
    unittest.main()

import unittest
from auth_service import AuthService
from entry_point import EntryPoint
from publisher_test_objects_factory import PublisherTestObjectsFactory

'Merchant Processor mock' 
class MerchantProcessor:
    def debit_credit_card(self, an_amount_to_debit, credit_card):
        return None

class EntryPointTest(unittest.TestCase):

    def setUp(self):
        self._objects_factory = PublisherTestObjectsFactory()
        self.entry_point = EntryPoint(
            {self._objects_factory.book_from_the_editorial(): self._objects_factory.book_from_the_editorial_price()},
            MerchantProcessor(),
            AuthService()
        )
        self.cart_id_length = 32
        self.transaction_id_length = 32
        self.invalid_cart_id = "ABCD12345678"
    
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
            self.entry_point.addToCart(self.invalid_cart_id, self._objects_factory.book_from_the_editorial(), 1)
        except Exception as expected_exception:
            self.assertEqual(str(expected_exception), 'Invalid cart ID')

    def test05_a_cart_can_list_its_content(self):
        cart_id = self.entry_point.createCart('mariana', '5678')
        self.entry_point.addToCart(cart_id, self._objects_factory.book_from_the_editorial(), 1)
        self.assertEqual(self.entry_point.listCart(cart_id), {self._objects_factory.book_from_the_editorial() : 1})
    
    def test06_a_cart_with_invalid_id_cannot_be_listed(self):
        try:
            self.entry_point.listCart(self.invalid_cart_id)
        except Exception as expected_exception:
            self.assertEqual(str(expected_exception), 'Invalid cart ID')

    def test07_a_cart_with_invalid_id_cannot_be_checked_out(self):
        try:
            credit_card = self._objects_factory.a_valid_credit_card()
            self.entry_point.checkOutCart(self.invalid_cart_id, credit_card)
        except Exception as expected_exception:
            self.assertEqual(str(expected_exception), 'Invalid cart ID')

    def test08_a_valid_cart_can_be_checked_out(self):
        cart_id = self.entry_point.createCart('juan', '1234')
        self.entry_point.addToCart(cart_id, self._objects_factory.book_from_the_editorial(), 1)
        transaction_id = self.entry_point.checkOutCart(cart_id, self._objects_factory.a_valid_credit_card())
        self.assertEqual(len(transaction_id), self.transaction_id_length)
        
    def test09_purchases_cannot_be_listed_with_invalid_credentials(self):
        try:
            self.entry_point.listPurchases('pepe', '9999')
        except Exception as expected_exception:
            self.assertEqual(str(expected_exception), 'Invalid credentials')

    def test10_a_valid_client_with_no_purchases_retrieves_empty_purchases_and_amount_zero(self):
        self.entry_point.listPurchases('mariana', '5678')
        self.assertEqual(self.entry_point.listPurchases('mariana', '5678'), {
            "total_amount": 0,
            "purchases": {}
            })

    def test10_purchases_can_be_listed_with_valid_credential(self):
        cart_id = self.entry_point.createCart('mariana', '5678')
        self.entry_point.addToCart(cart_id, self._objects_factory.book_from_the_editorial(), 1)
        self.entry_point.checkOutCart(cart_id, self._objects_factory.a_valid_credit_card())
      
        self.assertEqual(self.entry_point.listPurchases('mariana', '5678'), {
            "total_amount": self._objects_factory.book_from_the_editorial_price(),
            "purchases": {self._objects_factory.book_from_the_editorial(): 1}
            })

    def test11_a_valid_client_with_multiple_checked_out_carts_can_list_purchases(self):
        cart1_id = self.entry_point.createCart('mariana', '5678')
        cart2_id = self.entry_point.createCart('mariana', '5678')
        self.entry_point.addToCart(cart1_id, self._objects_factory.book_from_the_editorial(), 1)
        self.entry_point.addToCart(cart2_id, self._objects_factory.book_from_the_editorial(), 1)
        self.entry_point.checkOutCart(cart1_id, self._objects_factory.a_valid_credit_card())
        self.entry_point.checkOutCart(cart2_id, self._objects_factory.a_valid_credit_card())
      
        self.assertEqual(self.entry_point.listPurchases('mariana', '5678'), {
            "total_amount": self._objects_factory.book_from_the_editorial_price() * 2,
            "purchases": {self._objects_factory.book_from_the_editorial(): 2}
            })

if __name__ == '__main__':
    unittest.main()

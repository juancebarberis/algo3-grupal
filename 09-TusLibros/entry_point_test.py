import unittest
import datetime
from auth_service import AuthService
from entry_point import EntryPoint
from publisher_test_objects_factory import PublisherTestObjectsFactory

'Merchant Processor mock' 
class MerchantProcessor:
    def debit_credit_card(self, an_amount_to_debit, credit_card):
        return None

'Datetime mock' 
class DatetimeMock:
    def __init__(self, datetime_module, minutes_to_add = 0):
        self._minutes_to_add = minutes_to_add
        self._datetime_module = datetime_module

    def now(self):
        return self._datetime_module.now() + datetime.timedelta(minutes = self._minutes_to_add)

    def change_minutes_to_add(self, new_minutes_to_add):
        self._minutes_to_add += new_minutes_to_add

class EntryPointTest(unittest.TestCase):

    def setUp(self):
        self._objects_factory = PublisherTestObjectsFactory()
        self.entry_point = EntryPoint(
            {self._objects_factory.book_from_the_editorial(): self._objects_factory.book_from_the_editorial_price()},
            MerchantProcessor(),
            AuthService(),
            datetime.datetime
        )
        self.invalid_cart_id = "ABCD12345678"
    
    'tests'

    def test01_a_cart_cannot_be_created_with_invalid_credentials(self):
        try:
            self.entry_point.createCart('pepe', '9999')
        except Exception as expected_exception:
            self.assertEqual(str(expected_exception), 'Invalid credentials')
    
    def test02_a_cart_is_created_and_can_be_listed(self):
        cart_id = self.entry_point.createCart('juan', '1234')
        self.assertEqual(self.entry_point.listCart(cart_id), {})

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
        
    def test08_purchases_cannot_be_listed_with_invalid_credentials(self):
        try:
            self.entry_point.listPurchases('pepe', '9999')
        except Exception as expected_exception:
            self.assertEqual(str(expected_exception), 'Invalid credentials')

    def test09_a_valid_client_with_no_purchases_retrieves_empty_purchases_and_amount_zero(self):
        self.entry_point.listPurchases('mariana', '5678')
        self.assertEqual(self.entry_point.listPurchases('mariana', '5678'), {
            "total_amount": 0,
            "purchases": {}
            })

    def test10_a_user_with_valid_credentials_can_checkout_and_list_a_cart(self):
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
    
    def test12_a_book_cannot_be_added_to_a_cart_after_30_minutes_of_no_action(self):
        clock, entry_point_with_datetime_mock = self._create_entry_point_with_clock_mock()
        try:
            'Cart creation'
            cart_id = entry_point_with_datetime_mock.createCart('mariana', '5678')

            'Fast the clock by 30 minutes'
            clock.change_minutes_to_add(30)

            entry_point_with_datetime_mock.addToCart(cart_id, self._objects_factory.book_from_the_editorial(), 1)
            self.fail()
        except Exception as expected_exception:
            self.assertEqual(str(expected_exception), 'Cart is no longer valid')

    def test13_a_cart_cannot_be_checked_out_after_30_minutes_of_no_action(self):
        clock, entry_point_with_datetime_mock = self._create_entry_point_with_clock_mock()
        try:
            'Cart creation and book add to cart'
            cart_id = entry_point_with_datetime_mock.createCart('juan', '1234')
            entry_point_with_datetime_mock.addToCart(cart_id, self._objects_factory.book_from_the_editorial(), 1)

            'Fast the clock by 30 minutes'
            clock.change_minutes_to_add(30)

            entry_point_with_datetime_mock.checkOutCart(cart_id, self._objects_factory.a_valid_credit_card())
            self.fail()
        except Exception as expected_exception:
            self.assertEqual(str(expected_exception), 'Cart is no longer valid')

    def test14_a_cart_cannot_be_listed_after_30_minutes_of_no_action(self):
        clock, entry_point_with_datetime_mock = self._create_entry_point_with_clock_mock()
        try:
            'Cart creation and book add to cart'
            cart_id = entry_point_with_datetime_mock.createCart('mariana', '5678')
            entry_point_with_datetime_mock.addToCart(cart_id, self._objects_factory.book_from_the_editorial(), 1)

            'Fast the clock by 30 minutes'
            clock.change_minutes_to_add(30)

            entry_point_with_datetime_mock.listCart(cart_id)
            self.fail()
        except Exception as expected_exception:
            self.assertEqual(str(expected_exception), 'Cart is no longer valid')

    def test15_multiple_actions_in_20_minutes_intervals_are_allowed(self):
        clock, entry_point_with_datetime_mock = self._create_entry_point_with_clock_mock()

        'Cart creation'
        cart_id = entry_point_with_datetime_mock.createCart('mariana', '5678')

        'Fast the clock by 20 minutes'
        clock.change_minutes_to_add(20)

        'Add book'
        entry_point_with_datetime_mock.addToCart(cart_id, self._objects_factory.book_from_the_editorial(), 1)

        'Fast the clock by 20 minutes again and add another book'
        clock.change_minutes_to_add(20)

        entry_point_with_datetime_mock.addToCart(cart_id, self._objects_factory.book_from_the_editorial(), 1)

        'Fast the clock by 20 minutes again and list cart.'
        clock.change_minutes_to_add(20)

        cartList = entry_point_with_datetime_mock.listCart(cart_id)
        
        ' Assert if the listCart works.'
        self.assertIn(self._objects_factory.book_from_the_editorial(), cartList)

        'Fast the clock by 20 minutes again and checkout'
        clock.change_minutes_to_add(20)

        entry_point_with_datetime_mock.checkOutCart(cart_id, self._objects_factory.a_valid_credit_card())
        'Assert if the checkout works.'
        self.assertEqual(entry_point_with_datetime_mock.listPurchases('mariana', '5678'), {
            "total_amount": self._objects_factory.book_from_the_editorial_price() * 2,
            "purchases": {self._objects_factory.book_from_the_editorial(): 2}
            })

    'private'

    def _create_entry_point_with_clock_mock(self):
        clock = DatetimeMock(datetime.datetime)
        entry_point_with_datetime_mock = EntryPoint(
            {self._objects_factory.book_from_the_editorial(): self._objects_factory.book_from_the_editorial_price()},
            MerchantProcessor(),
            AuthService(),
            clock
        )
        return clock, entry_point_with_datetime_mock

if __name__ == '__main__':
    unittest.main()

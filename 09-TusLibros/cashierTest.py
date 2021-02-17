import unittest
from cart import Cart
from sales import Sales
from cashier import Cashier
from merchantProcessor import MerchantProcessor
from errors import CartCannotBeEmpty, MerchantProcessorError, CheckOutPaymentError

class CashierTests(unittest.TestCase):

  def setUp(self):
    self.item_id_1 = "123"
    self.item_id_2 = "456"
    catalogue = {self.item_id_1 : 100.50, self.item_id_2 : 120.30}
    self.cart = Cart(catalogue)
    self.sales = Sales()
    self.merchantProcessor = MerchantProcessor(errorExpected = False)
    self.merchantProcessor2 = MerchantProcessor(errorExpected = True)
    self.cashier = Cashier(self.cart, self.merchantProcessor, "1111111111111111", "062023", "John Smith", self.sales)
    self.cashierWithErrorOnMerchantProcessor = Cashier(self.cart, self.merchantProcessor2, "1111111111111111", "062023", "John Smith", self.sales)
    
  def testAnEmptyCartCannotBeCheckedOut(self):
    self.assertRaises(CartCannotBeEmpty, lambda: self.cashier.checkOut())

  def testCashierChecksCreditCardIsValid(self):
    self.cart.addItem(self.item_id_1, 1)
    self.assertIsNone(self.cashier.creditCardIsValid())

  def testACashierCanKnowTheTransactionAmount(self):
    self.cart.addItem(self.item_id_1, 1)
    self.cart.addItem(self.item_id_2, 2)
    self.assertTrue(self.cashier.obtainTransactionAmount() == 341.10)

  def testACartWithOneItemCanBeCheckedOutWithoutMerchantProcessorError(self):
    self.cart.addItem(self.item_id_1, 1)
    self.assertIsNone(self.cashier.checkOut())

  def testACartWithOneItemCannotBeCheckedOutDueToMerchantProcessorError(self):
    self.cart.addItem(self.item_id_1, 1)
    self.assertRaises(CheckOutPaymentError, lambda: self.cashierWithErrorOnMerchantProcessor.checkOut())
  
  def testACartWithoutErrorInCheckOutRegisterASale(self):
    self.cart.addItem(self.item_id_1, 1)
    self.cashier.checkOut()
    self.assertTrue(self.sales.getSales() == {self.cart.getId(): [
      {"itemId": self.item_id_1, "quantity": 1, "price": 100.50},
      ]})

  def testACartWithErrorInCheckOutDoesNotRegisterASale(self):
    self.cart.addItem(self.item_id_1, 1)
    try:
      self.cashierWithErrorOnMerchantProcessor.checkOut()
    except CheckOutPaymentError:
      self.assertTrue(self.sales.getSales() == {})

if __name__ == '__main__':
    unittest.main()
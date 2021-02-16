import unittest
from cart import Cart
from sales import Sales
#from creditCard import CreditCard
from cashier import Cashier
from errors import CartCannotBeEmpty

class CashierTests(unittest.TestCase):

  def setUp(self):
    self.item_id_1 = "123"
    self.item_id_2 = "456"
    catalogue = {self.item_id_1 : 100.50, self.item_id_2 : 120.30}
    self.cart = Cart(catalogue)
    self.sales = Sales()
    self.cashier = Cashier(self.cart, "1111111111111111", "062023", "Jochn Smith", self.sales)
    
  def testAnEmptyCartCannotBeCheckedOut(self):
    self.assertRaises(CartCannotBeEmpty, lambda: self.cashier.checkOut())
  
  def testACartWithOneItemCanBeCheckedOut(self):
    self.cart.addItem(self.item_id_1, 1)
    self.assertIsNone(self.cashier.checkOut())

  def testACartWithManyItemsCanBeCheckedOut(self):
    self.cart.addItem(self.item_id_1, 2)
    self.cart.addItem(self.item_id_2, 1)
    self.assertIsNone(self.cashier.checkOut())

  def testCashierChecksCreditCardIsValid(self):
    self.cart.addItem(self.item_id_1, 1)
    self.assertIsNone(self.cashier.checkOut())
  
  def testACashierCanKnowTheTransactionAmount(self):
    self.cart.addItem(self.item_id_1, 1)
    self.cart.addItem(self.item_id_2, 2)
    self.assertTrue(self.cashier.obtainTransactionAmount() == 341.10)

  #def testTransactionIsSentToMerchantProcessor(self):
    #self.cart.addItem(self.item_id_1, 1)

if __name__ == '__main__':
    unittest.main()
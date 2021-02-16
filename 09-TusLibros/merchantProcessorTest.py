import unittest
from merchantProcessor import MerchantProcessor
from creditCardValidation import CreditCardValidation

class CashierTests(unittest.TestCase):

  def setUp(self):
    self.merchantProcessor = MerchantProcessor("1111111111111111", "062021", "John Smith", 1045.93)

  def testATransactionCanBePosted(self):
      self.assertRaises(CartCannotBeEmpty, lambda: self.cashier.checkOut())

  def testATransactionCanBePosted(self):
      self.assertRaises(CartCannotBeEmpty, lambda: self.cashier.checkOut())

  def testATransactionCanBePosted(self):
    self.assertRaises(CartCannotBeEmpty, lambda: self.cashier.checkOut())


if __name__ == '__main__':
    unittest.main()
import unittest
from creditCardValidation import CreditCardValidation
from errors import NonValidCreditCardNumber, NonValidCreditCardExpirationDate, NonValidCreditCardAmount, NonValidCreditCardOwner

class CreditCardValidationTest(unittest.TestCase):

  def setUp(self):
    self.creditCardValidation = CreditCardValidation()
    self.validCreditCard = {
      "number": "5400000000000001",
      "expiration": "072021",
      "owner": "PEPE SANCHEZ",
      "amount": "123.50",
    }
    self.nonValidCreditCard = {
      "number": "54000000001",
      "expiration": "072011",
      "owner": "PEDRO MARIA LUCIA NOMBRES LARGOS SI LOS HAY",
      "amount": "100000000000051421321.11122",
    }

  '''
  Checking for valid results
  '''

  def testCreditCardNumberIsValid(self):
    self.assertIsNone(self.creditCardValidation.checkCreditCardNumber(self.validCreditCard["number"]))

  def testCreditCardExpirationDateIsValid(self):
    self.assertIsNone(self.creditCardValidation.checkCreditCardExpirationDate(self.validCreditCard["expiration"]))

  def testCreditCardOwnerIsValid(self):
    self.assertIsNone(self.creditCardValidation.checkCreditCardOwner(self.validCreditCard["owner"]))

  def testCreditCardAmountIsValid(self):
    self.assertIsNone(self.creditCardValidation.checkCreditCardAmount(self.validCreditCard["amount"]))

  '''
  Checking for non valid results
  '''

  def testCreditCardNumberIsNotValid(self):
    self.assertRaises(NonValidCreditCardNumber, lambda: self.creditCardValidation.checkCreditCardNumber(self.nonValidCreditCard["number"]))

  def testCreditCardExpirationIsNotValid(self):
    self.assertRaises(NonValidCreditCardExpirationDate, lambda: self.creditCardValidation.checkCreditCardExpirationDate(self.nonValidCreditCard["expiration"]))

  def testCreditCardOwnerIsNotValid(self):
    self.assertRaises(NonValidCreditCardOwner, lambda: self.creditCardValidation.checkCreditCardOwner(self.nonValidCreditCard["owner"]))

  def testCreditCardAmountIsNotValid(self):
    self.assertRaises(NonValidCreditCardAmount, lambda: self.creditCardValidation.checkCreditCardAmount(self.nonValidCreditCard["amount"]))

if __name__ == '__main__':
    unittest.main()
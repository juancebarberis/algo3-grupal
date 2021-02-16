from errors import CartCannotBeEmpty
from creditCardValidation import CreditCardValidation
from merchantProcessor import MerchantProcessor

class Cashier:

  def __init__(self, cart, creditCardNumber, creditCardExpiration, creditCardOwner, sales):
    self.__cart = cart
    self.__creditCardNumber = creditCardNumber
    self.__creditCardExpiration = creditCardExpiration
    self.__creditCardOwner = creditCardOwner
    self.__creditCardValidation = CreditCardValidation()
    self.__sales = sales

  def obtainTransactionAmount(self):
    return self.__cart.totalAmount()

  def creditCardIsValid(self):
    self.__creditCardValidation.checkCreditCardNumber(self.__creditCardNumber)
    self.__creditCardValidation.checkCreditCardExpirationDate(self.__creditCardExpiration)
    self.__creditCardValidation.checkCreditCardOwner(self.__creditCardOwner)
    self.__creditCardValidation.checkCreditCardAmount(self.obtainTransactionAmount())

  def processTransaction(self):
    merchantProcessor = MerchantProcessor(self.__creditCardNumber, self.__creditCardExpiration, self.__creditCardOwner, self.obtainTransactionAmount())
    merchantProcessor.process()

  def checkOut(self):
    if self.__cart.isEmpty():
      raise CartCannotBeEmpty
    
    self.creditCardIsValid()
    
    self.processTransaction()


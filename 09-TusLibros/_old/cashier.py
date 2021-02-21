from errors import CartCannotBeEmpty, MerchantProcessorError, CheckOutPaymentError
from creditCardValidation import CreditCardValidation
from merchantProcessor import MerchantProcessor

class Cashier:

  def __init__(self, cart, merchantProcessor, creditCardNumber, creditCardExpiration, creditCardOwner, sales):
    self.__cart = cart
    self.__creditCardNumber = creditCardNumber
    self.__creditCardExpiration = creditCardExpiration
    self.__creditCardOwner = creditCardOwner
    self.__creditCardValidation = CreditCardValidation()
    self.__sales = sales
    self.__merchantProcessor = merchantProcessor

  def obtainTransactionAmount(self):
    return self.__cart.totalAmount()

  def creditCardIsValid(self):
    self.__creditCardValidation.checkCreditCardNumber(self.__creditCardNumber)
    self.__creditCardValidation.checkCreditCardExpirationDate(self.__creditCardExpiration)
    self.__creditCardValidation.checkCreditCardOwner(self.__creditCardOwner)
    self.__creditCardValidation.checkCreditCardAmount(self.obtainTransactionAmount())

  def processTransaction(self):
    self.__merchantProcessor.processTransaction(
      creditCardNumber = self.__creditCardNumber, 
      creditCardExpiration = self.__creditCardExpiration, 
      creditCardOwner = self.__creditCardOwner, 
      transactionAmount = self.obtainTransactionAmount()
      )

  def checkOut(self):
    if self.__cart.isEmpty():
      raise CartCannotBeEmpty
    
    self.creditCardIsValid()
    
    try:
      self.processTransaction()
    except MerchantProcessorError:
      raise CheckOutPaymentError

    self.__sales.registerSale(self.__cart)
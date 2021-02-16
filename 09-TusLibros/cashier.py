from errors import CartCannotBeEmpty
from creditCardValidation import CreditCardValidation

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

  def __creditCardIsValid(self):
    self.__creditCardValidation.checkCreditCardNumber(self.__creditCardNumber)
    self.__creditCardValidation.checkCreditCardExpirationDate(self.__creditCardExpiration)
    self.__creditCardValidation.checkCreditCardOwner(self.__creditCardOwner)
    self.__creditCardValidation.checkCreditCardAmount(self.obtainTransactionAmount())

  def checkOut(self):
    if self.__cart.isEmpty():
      raise CartCannotBeEmpty
    self.__creditCardIsValid()
    transactionAmount = self.obtainTransactionAmount()
    merchantProcessor(self.__creditCard.__creditCardNumber, self.__creditCard.__creditCardExpiration, self.__creditCard.__creditCardOwner, transactionAmount)

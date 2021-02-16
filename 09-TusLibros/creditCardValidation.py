from errors import NonValidCreditCardNumber, NonValidCreditCardExpirationDate, NonValidCreditCardOwner, NonValidCreditCardAmount
import datetime

class CreditCardValidation:

  def __init__(self):
    pass

  def checkCreditCardNumber(self, number):
    if not number.isnumeric() or len(number) != 16:
      raise NonValidCreditCardNumber

  def checkCreditCardExpirationDate(self, expiration):
    if not expiration.isnumeric() or len(expiration) != 6 or self.__invalidDate(expiration):
      raise NonValidCreditCardExpirationDate

  def __invalidDate(self, expiration): 
    month = int(expiration[0:2])
    year = int(expiration[2:])
    expirationDateTime = datetime.datetime(year, month, 1)
    currentDateTime = datetime.datetime.now()

    return currentDateTime > expirationDateTime

  def checkCreditCardOwner(self, owner):
    if len(owner) == 0 or len(owner) > 30:
      raise NonValidCreditCardOwner

  def checkCreditCardAmount(self, amount):
    amount = str(amount)
    splitedAmount = amount.split(".")
    
    if(len(splitedAmount) != 2):
      raise NonValidCreditCardAmount

    integerPart, decimalPart = splitedAmount

    if not integerPart.isnumeric() or not decimalPart.isnumeric() or len(integerPart) > 15 or len(decimalPart) > 2:
      raise NonValidCreditCardAmount
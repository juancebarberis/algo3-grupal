
class CartCannotBeEmpty(Exception):
  pass

class NonValidCreditCardNumber(Exception):
  pass

class NonValidCreditCardExpirationDate(Exception):
  pass

class NonValidCreditCardOwner(Exception):
  pass

class NonValidCreditCardAmount(Exception):
  pass

class ItemNotInCatalogue(Exception):
  pass

class ItemQuantityCannotBeLessThanOne(Exception):
  pass

class MerchantProcessorError(Exception):
  pass

class CheckOutPaymentError(Exception):
  pass
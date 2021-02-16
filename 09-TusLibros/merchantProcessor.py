
class MerchantProcessor:

  def __init__(self, creditCardNumber, creditCardExpiration, creditCardOwner, transactionAmount):
    self.__creditCardNumber = creditCardNumber
    self.__creditCardExpiration = creditCardExpiration
    self.__creditCardOwner = creditCardOwner
    self.__transactionAmount = transactionAmount
  
  def merchantProcessorSuccessResponse(self):
    return {"code": 200, "description": ""}

  def merchantProcessorSuccessWithErrorResponse(self):
    return {"code": 200, "description": ""}

  def merchantProcessorErrorResponse(self):
    return {"code": 400, "description": ""}
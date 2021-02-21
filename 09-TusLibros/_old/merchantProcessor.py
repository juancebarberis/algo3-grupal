from errors import MerchantProcessorError


class MerchantProcessor:

    def __init__(self, errorExpected):
        self.__errorExpected = errorExpected

    def merchantProcessorSuccessResponse(self):
        return None

    def merchantProcessorErrorResponse(self):
        raise MerchantProcessorError

    def processTransaction(self, creditCardNumber, creditCardExpiration, creditCardOwner, transactionAmount):
        if not self.__errorExpected:
          return self.merchantProcessorSuccessResponse()
        elif self.__errorExpected:
          return self.merchantProcessorErrorResponse()

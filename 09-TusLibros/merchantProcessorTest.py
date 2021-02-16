import unittest
from merchantProcessor import MerchantProcessor

class MerchantProcessorTest(unittest.TestCase):

  def setUp(self):
    self.merchantProcessor = MerchantProcessor("1111111111111111", "062021", "John Smith", 1045.93)

  def testMerchantProcessorHttpSuccessResponse(self):
      self.assertTrue(self.merchantProcessor.merchantProcessorSuccessResponse() == {"code": 200, "description": ""})

  def testMerchantProcessorHttpSuccessResponseWithError(self):
      self.assertTrue(self.merchantProcessor.merchantProcessorSuccessWithErrorResponse() == {"code": 200, "description": ""})

  def testMerchantProcessorHttpErrorResponse(self):
    self.assertTrue(self.merchantProcessor.merchantProcessorErrorResponse() == {"code": 400, "description": ""})


if __name__ == '__main__':
    unittest.main()
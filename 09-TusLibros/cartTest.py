import unittest
from cart import Cart

ITEM_ID_1 = "123"
ITEM_ID_2 = "456"

class CarritoTests(unittest.TestCase):

  def setUp(self):
    self.cart = Cart()
  
  def testANewCartIsEmpty(self):
    self.assertTrue(self.cart.isEmpty())

  def testAnItemCanBeAdded(self):
    self.assertTrue(self.cart.addItem(ITEM_ID_1, 1))

  def testCartQuantityIsCorrect(self):
    self.cart.addItem(ITEM_ID_1, 1)
    self.assertTrue(self.cart.quantity() == 1)

  def testAnItemCanNotBeAddedWithQuantityLessThanOne(self):
    self.assertFalse(self.cart.addItem(ITEM_ID_1, 0))

  def testAnItemCanNotBeAddedWithEmptyItemId(self):
    self.assertFalse(self.cart.addItem("", 1))
  
  def testAnItemCanBeAddedTwiceAndTheQuantityIsCorrect(self):
    self.cart.addItem(ITEM_ID_1, 1)
    self.cart.addItem(ITEM_ID_1, 1)
    self.assertTrue(self.cart.quantity() == 2)
    self.assertTrue(self.cart.quantityOfAnItem(ITEM_ID_1) == 2)

  def testItemsOfACartCanBeListed(self):
    self.cart.addItem(ITEM_ID_1, 2)
    self.cart.addItem(ITEM_ID_2, 3)
    self.assertTrue(self.cart.listOfItems() == {ITEM_ID_1: 2, ITEM_ID_2: 3})

  def testACartCanBeCheckedOut(self):
    self.cart.addItem(ITEM_ID_1, 1)
    self.cart.checkOut()
    self.assertTrue(self.cart.isCheckedOut())

  def testAnEmptyCartCanNotBeCheckedOut(self):
    self.cart.checkOut()
    self.assertFalse(self.cart.isCheckedOut())

  def testACheckedOutCartCanNotAddNewItems(self):
    self.cart.addItem(ITEM_ID_1, 1)
    self.cart.checkOut()
    self.assertFalse(self.cart.addItem(ITEM_ID_2, 1))

if __name__ == '__main__':
    unittest.main()
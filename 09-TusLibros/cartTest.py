import unittest
from cart import Cart

class CarritoTests(unittest.TestCase):

  def setUp(self):
    self.item_id_1 = "123"
    self.item_id_2 = "456"
    self.item_id_3 = "789"
    catalogue = {self.item_id_1 : 100.50, self.item_id_2 : 120.30}
    self.cart = Cart(catalogue)
  
  def testANewCartIsEmpty(self):
    self.assertTrue(self.cart.isEmpty())

  def testAnItemInCatalogueCanBeAdded(self):
    self.assertTrue(self.cart.addItem(self.item_id_1, 1))

  def testAnItemNotInCatalogueCanNotBeAdded(self):
    self.assertFalse(self.cart.addItem(self.item_id_3, 1))

  def testCartQuantityIsCorrect(self):
    self.cart.addItem(self.item_id_1, 1)
    self.assertTrue(self.cart.quantity() == 1)

  def testAnItemCanNotBeAddedWithQuantityLessThanOne(self):
    self.assertFalse(self.cart.addItem(self.item_id_1, 0))

  def testAnItemCanNotBeAddedWithEmptyItemId(self):
    self.assertFalse(self.cart.addItem("", 1))
  
  def testAnItemCanBeAddedTwiceAndTheQuantityIsCorrect(self):
    self.cart.addItem(self.item_id_1, 1)
    self.cart.addItem(self.item_id_1, 1)
    self.assertTrue(self.cart.quantity() == 2)
    self.assertTrue(self.cart.quantityOfAnItem(self.item_id_1) == 2)

  def testItemsOfACartCanBeListed(self):
    self.cart.addItem(self.item_id_1, 2)
    self.cart.addItem(self.item_id_2, 3)
    self.assertTrue(self.cart.listOfItems() == {self.item_id_1: 2, self.item_id_2: 3})

  def testACashierKnowsTheTotalAmountOfTheCart(self):
    self.cart.addItem(self.item_id_1, 1)
    self.cart.addItem(self.item_id_2, 2)
    self.assertTrue(self.cart.totalAmount() == 341.10)

if __name__ == '__main__':
    unittest.main()
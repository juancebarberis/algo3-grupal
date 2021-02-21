import unittest
from sales import Sales
from cart import Cart
from errors import CartCannotBeEmpty

class SalesTests(unittest.TestCase):

  def setUp(self):
    self.sales = Sales()
    self.item_id_1 = "123"
    self.item_id_2 = "456"
    catalogue = {self.item_id_1 : 100.50, self.item_id_2 : 120.30}
    self.cart = Cart(catalogue)

  def testAnEmptyCartCannotBeRegistered(self):
    self.assertRaises(CartCannotBeEmpty, lambda: self.sales.registerSale(self.cart))

  def testACartWithOneItemCanBeRegistered(self):
    self.cart.addItem(self.item_id_1, 1)
    self.sales.registerSale(self.cart)
    self.assertTrue(self.sales.getSales() == {self.cart.getId(): [{"itemId": self.item_id_1, "quantity": 1, "price": 100.50}]})

  def testACartWithManyItemCanBeRegistered(self):
    self.cart.addItem(self.item_id_1, 1)
    self.cart.addItem(self.item_id_2, 2)
    self.sales.registerSale(self.cart)
    self.assertTrue(self.sales.getSales() == {self.cart.getId(): [
      {"itemId": self.item_id_1, "quantity": 1, "price": 100.50},
      {"itemId": self.item_id_2, "quantity": 2, "price": 120.30},
      ]})

if __name__ == '__main__':
    unittest.main()
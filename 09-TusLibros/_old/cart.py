import uuid
from errors import ItemNotInCatalogue, ItemQuantityCannotBeLessThanOne

class Cart:

  def __init__(self, catalogue):
    self.__id = uuid.uuid4().hex
    self.__quantity = 0
    self.__items = {}
    self.__catalogue = catalogue

  def getId(self):
    return self.__id

  def isEmpty(self):
    return self.__quantity == 0

  def quantity(self):
    return self.__quantity

  def addItem(self, itemId, quantity = 1):
    if itemId not in self.__catalogue: 
      raise ItemNotInCatalogue

    if quantity < 1:
      raise ItemQuantityCannotBeLessThanOne

    self.__items[itemId] = self.__items.get(itemId, 0) + quantity
    self.__quantity += quantity
    
  def quantityOfAnItem(self, itemId):
    return self.__items[itemId] if itemId in self.__items else 0

  def listOfItems(self):
    return self.__items

  def totalAmount(self):
    totalAmount = 0
    items = self.listOfItems()
    for item in items:
      totalAmount += (items[item] * self.getPrice(item))
    return totalAmount

  def getPrice(self, itemId):
    return self.__catalogue[itemId]

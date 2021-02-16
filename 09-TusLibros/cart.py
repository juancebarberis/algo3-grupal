
class Cart:

  def __init__(self, catalogue):
    self.__quantity = 0
    self.__items = {}
    self.__catalogue = catalogue

  def isEmpty(self):
    return self.__quantity == 0

  def quantity(self):
    return self.__quantity

  def addItem(self, itemId, quantity = 1):
    if quantity < 1 or itemId == "" or itemId not in self.__catalogue: 
      return False

    self.__items[itemId] = self.__items.get(itemId, 0) + quantity
    self.__quantity += quantity
    
    return True

  def quantityOfAnItem(self, itemId):
    return self.__items[itemId] if itemId in self.__items else 0

  def listOfItems(self):
    return self.__items

  def totalAmount(self):
    totalAmount = 0
    items = self.listOfItems()
    for item in items:
      totalAmount += (items[item] * self.__catalogue.get(item))
    return totalAmount

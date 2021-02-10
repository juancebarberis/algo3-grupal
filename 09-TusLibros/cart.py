
class Cart:

  def __init__(self):
    self.__quantity = 0
    self.__items = {}
    self.__checkout = False

  def isEmpty(self):
    return self.__quantity == 0

  def quantity(self):
    return self.__quantity

  def addItem(self, itemId, quantity = 1):
    if quantity < 1 or itemId == "" or self.__checkout: 
      return False

    self.__items[itemId] = self.__items.get(itemId, 0) + quantity
    self.__quantity += quantity
    
    return True

  def quantityOfAnItem(self, itemId):
    return self.__items[itemId] if itemId in self.__items else 0

  def listOfItems(self):
    return self.__items

  def checkOut(self):
    self.__checkout = self.__quantity > 0

  def isCheckedOut(self):
    return self.__checkout
from errors import CartCannotBeEmpty

class Sales:

  def __init__(self):
    self.__sales = {}

  def registerSale(self, cart):
    if(cart.isEmpty()):
      raise CartCannotBeEmpty

    self.__sales[cart.getId()] = []
    items = cart.listOfItems()
    
    for item in items:
      self.__sales[cart.getId()].append({
        "itemId": item,
        "quantity": items[item],
        "price": cart.getPrice(item)
      })

  def getSales(self):
    return self.__sales
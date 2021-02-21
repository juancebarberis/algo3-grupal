class Cart:
    'initialize'

    def __init__(self, a_catalog):
        self._books = []
        self._catalog = a_catalog

    'adding'

    def add(self, a_book):
        self.add_with_quantity(a_book, 1)

    def add_with_quantity(self, a_book, a_number_of_copies):
        self._assert_is_in_catalog(a_book)
        self._assert_valid_number_of_copies(a_number_of_copies)
        for _ in range(a_number_of_copies):
            self._books.append(a_book)

    'accessing'

    def quantity_of(self, a_book):
        return self._books.count(a_book)

    def total(self):
        return sum([self._catalog[book] for book in self._books])

    'testing'

    def includes(self, a_book):
        return a_book in self._books

    def is_empty(self):
        return len(self._books) == 0

    'private - assertions'

    def _assert_is_in_catalog(self, a_book):
        if a_book not in self._catalog:
            raise Exception(self.__class__.cannot_add_book_not_in_catalog_error_message())

    def _assert_valid_number_of_copies(self, a_number_of_copies):
        if a_number_of_copies <= 0:
            raise Exception(self.__class__.cannot_add_a_non_positive_number_of_copies_error_message())

    'instance creation'

    @classmethod
    def accepting_items_of(cls, a_catalog):
        return cls(a_catalog)

    'error messages'

    @classmethod
    def cannot_add_book_not_in_catalog_error_message(cls):
        return 'Cannot add a book not from the editorial'

    @classmethod
    def cannot_add_a_non_positive_number_of_copies_error_message(cls):
        return 'Cannot add non positive number of copies to the cart'

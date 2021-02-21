class CreditCard:
    @classmethod
    def new_with(cls, name_of_the_owner, credit_card_number, an_expiration_month_of_year):
        if name_of_the_owner == '':
            raise RuntimeError(cls.name_cannot_be_blank_error_message())
        return cls(name_of_the_owner, credit_card_number, an_expiration_month_of_year)

    def __init__(self, name_of_the_owner, credit_card_number, an_expiration_month_of_year):
        self._name_of_the_owner = name_of_the_owner
        self._credit_card_number = credit_card_number
        self._an_expiration_month_of_year = an_expiration_month_of_year

    @classmethod
    def name_cannot_be_blank_error_message(cls):
        return "Name cannot be blank"

    def is_expired_on(self, a_datetime):
        return a_datetime.date() > self._an_expiration_month_of_year.last_date()

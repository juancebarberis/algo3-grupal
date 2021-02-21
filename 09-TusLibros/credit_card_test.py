from unittest import TestCase

from credit_card import CreditCard
from month_of_year import MonthOfYear


class CreditCardTest(TestCase):
    def test01_credit_card_owner_name_cannot_be_blank(self):
        try:
            CreditCard.new_with('', 11111111, MonthOfYear(6, 2023))
            self.fail()
        except Exception as expected_exception:
            self.assertEqual(str(expected_exception), CreditCard.name_cannot_be_blank_error_message())

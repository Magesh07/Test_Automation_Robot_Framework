import logging
from datetime import date


class OppenheimerAPIWrapper:

    # twoDecimalPointRounding = java.text.DecimalFormat("0.00")
    # AC2: nat_id field must be masked from the 5th character onwards with dollar sign ‘$’
    @staticmethod
    def check_mask(value):
        size = len(value)
        result = False
        i = 5
        while i < size:
            result = value[i] == '$'
            i += 1
        return result

    # AC5:
    @staticmethod
    def get_final_tax_relief_amt(tax_relief):
        tax_relief_value = 0.00
        if 0 <= round(float(tax_relief)) <= 50.00:
            tax_relief_value = 50.00
            print("Tax relief amount is round-off to 50.00::", tax_relief_value)
        else:
            tax_relief_value = round(float(tax_relief))
            print("Tax relief amount is ", tax_relief_value)
        return tax_relief_value

    # AC6:
    @staticmethod
    def verify_tax_relief_amt_two_decimal_point(tax_relief):
        print(tax_relief)
        result = False
        splitter = str(tax_relief).split(".")
        decimal_length = len(splitter[1])
        if decimal_length == 2:
            result = True
        return result

    # AC3
    # Method to return the age
    @staticmethod
    def get_user_age(age):
        date_formatting = age
        print(date_formatting.split("/"))
        value = date_formatting.split("/")
        day_value = int(value[0])
        month_value = int(value[1])
        year_value = int(value[2])
        birthdate = date(year_value, month_value, day_value)
        days_in_year = 365.2425
        age = int((date.today() - birthdate).days / days_in_year)
        return float(age)

    # Method to calculate Tax Relief using given formula
    @staticmethod
    def verify_calculated_tax_relief(salary, tax_paid, dob, gender, actual_tax_relief):
        result = False
        tax_relief_cal = OppenheimerAPIWrapper.get_calculated_tax_relief_value(salary, tax_paid, dob, gender)
        print("Tax Relief Cal", tax_relief_cal)
        final_tax_relief_amt = OppenheimerAPIWrapper.get_final_tax_relief_amt(tax_relief_cal)
        if float(actual_tax_relief) == float(final_tax_relief_amt):
            result = True
            print("Calculated tax relief value matched", "actual relief amount:", actual_tax_relief,
                  "expected relied amount:", final_tax_relief_amt)
        else:
            result = False
            print("Calculated tax relief value not matched", "actual relief amount:", actual_tax_relief,
                  "expected relied amount:", final_tax_relief_amt)
        # if float(actual_tax_relief) == float(tax_relief_cal):
        #     result = True
        return result

    # AC4
    @staticmethod
    def verify_tax_relief_round_off(actual_tax_relief, calculated_tax_relief):
        result = False
        print(actual_tax_relief)
        print(calculated_tax_relief)
        if round(float(actual_tax_relief)) == round(float(calculated_tax_relief)):
            result = True
        return result

    # Method to calculate Tax Relief using given formula
    @staticmethod
    def get_calculated_tax_relief_value(salary, tax_paid, dob, gender):
        gender_bonus = 0
        variable = 0
        user_age = 0
        if dob != "":
            user_age = OppenheimerAPIWrapper.get_user_age(dob)
        if gender == "F":
            gender_bonus = 500
        if user_age <= 18:
            variable = 1
        elif user_age <= 35:
            variable = 0.8
        elif user_age <= 50:
            variable = 0.5
        elif user_age <= 50:
            variable = 0.89
        elif user_age >= 80:
            variable = 0.9
        salary_float = float(salary)
        tax_paid_float = float(tax_paid)
        tax_relief_cal = 0.00
        tax_relief_cal = ((salary_float - tax_paid_float) * variable + gender_bonus)
        print(tax_relief_cal)
        return tax_relief_cal

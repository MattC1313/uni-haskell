-- Do not alter the following line
module Assignment1 (char_to_int, repeat_char, decode, int_to_char, length_char, drop_char, encode, complex_encode, complex_decode) where


-- Part A

char_to_int :: Char -> Integer
char_to_int character
    | (character == '1') = 1
    | (character == '2') = 2
    | (character == '3') = 3
    | (character == '4') = 4
    | (character == '5') = 5
    | (character == '6') = 6
    | (character == '7') = 7
    | (character == '8') = 8
    | (character == '9') = 9
    

repeat_char :: Char -> Integer -> String
repeat_char character number
    | (number == 0) = []
    | otherwise = character : repeat_char character (number - 1)

decode :: String -> String
decode [] = []
decode (x:y:xs) =  repeat_char x (char_to_int y) ++ decode xs




-- Part B

int_to_char :: Integer -> Char
int_to_char integer
    | (integer == 1) = '1'
    | (integer == 2) = '2'
    | (integer == 3) = '3'
    | (integer == 4) = '4'
    | (integer == 5) = '5'
    | (integer == 6) = '6'
    | (integer == 7) = '7'
    | (integer == 8) = '8'
    | (integer == 9) = '9'


length_char :: Char -> String -> Integer
length_char c [] = 0
length_char c string
    | (head string == c) = 1 + length_char c (tail string)
    | otherwise = 0

drop_char :: Char -> String -> String
drop_char c [] = []
drop_char c string
    | (head string == c) = drop_char c (tail string)
    | otherwise = string


encode :: String -> String
encode [] = []
encode string = head string : int_to_char (length_char (head string) string) : encode (drop_char (head string) string)


-- Part C


-- Since I couldn't use the drop function I remade it as my own user-defined function
drop' n [] = []
drop' 0 string = string
drop' n string = drop' (n - 1) (tail string)


-- This string is only called once and I used it to get around a very specific error in the complex_encode function (line 118)
char_to_string c = [c]


-- This function will output a number in the integer data type as a number in the char data type.
-- The main differences between the earlier implementation from Part A is that this one can take 0 
-- as a value and can also tell if the value fed in is not a number
complex_int_to_char :: Integer -> Char
complex_int_to_char integer
    | (integer == 0) = '0'
    | (integer == 1) = '1'
    | (integer == 2) = '2'
    | (integer == 3) = '3'
    | (integer == 4) = '4'
    | (integer == 5) = '5'
    | (integer == 6) = '6'
    | (integer == 7) = '7'
    | (integer == 8) = '8'
    | (integer == 9) = '9'
    | otherwise = '*'


-- Here I use partial application to call the subtract_powers_of_ten function
highest_power = subtract_powers_of_ten 0


-- When partially applied with n as 0, this function will return the number rounded to the next largest power of 10;
-- this is needed so that I can turn each digit of the integer into a string value
subtract_powers_of_ten n integer
    | ((integer - (mod integer (10^n))) == 0) = n 
    | otherwise = subtract_powers_of_ten (n + 1) (integer - (mod integer (10^n)))


-- This function turns integers with 1 or more digits into a string
-- Note: this function only works if n = (the highest power of 10) - 1
build_string n integer
    | (n == -1) = []
    | otherwise = complex_int_to_char (div integer (10 ^ n)) : build_string (n - 1) (mod integer (10 ^ n))


complex_encode :: String -> String
complex_encode [] = []
complex_encode string
    | length string == 1 = char_to_string (head string)   -- If the string ended with a non-repeated ditit then an error would occur due to type errors with the ++ operator so I made a function that would turn the head from a char into a string
    | (head string /= head (tail string)) = head string : complex_encode (tail string)
    | otherwise = (head string) : build_string (highest_power (length_char (head string) string)- 1) (length_char (head string) string) ++ complex_encode (drop' (length_char (head string) string) string)


-- This function will output a number in the char data type as a number in the integer data type.
-- The main differences between the earlier implementation from Part A is that this one can take 0 
-- as a value and can also tell if the value fed in is not a number
complex_char_to_int character
    | (character == '0') = 0
    | (character == '1') = 1
    | (character == '2') = 2
    | (character == '3') = 3
    | (character == '4') = 4
    | (character == '5') = 5
    | (character == '6') = 6
    | (character == '7') = 7
    | (character == '8') = 8
    | (character == '9') = 9
    | otherwise = -1


-- This function counts the amount of consecutive numbers at the start of the string.
count_numbers :: String -> Integer
count_numbers [] = 0
count_numbers string
    | (complex_char_to_int (head string) == -1) = 0             -- If the character is not a number then the recursion should stop. This is a second base case
    | otherwise = 1 + count_numbers (tail string)


-- This function will output the number by working out the sum of values that each digit represents. For example, "123" would be turned into (100 + 20 + 3 = 123)
-- Note: this function only workis if numbers = the number of digits - 1
build_number numbers [] = 0
build_number (-1) string = 0
build_number numbers string = ((complex_char_to_int (head string)) * (10 ^ numbers)) + build_number (numbers - 1) (tail string)




-- Apologies for all of the brackets
complex_decode :: String -> String
complex_decode [] = []
complex_decode string = let 
                            amount_of_numbers = count_numbers (tail string) -- this let statement equates to how many characters after the first one in the string represent numbers
                            
                        in 
                            if
                                amount_of_numbers == 0          -- This condition checks if there are no numbers following the first letter, meaning that the letter is only used once
                            then
                                head string : complex_decode (drop' amount_of_numbers (tail string)) 
                            else 
                                repeat_char (head string) (build_number (amount_of_numbers - 1) (tail string)) ++ complex_decode (drop' amount_of_numbers (tail string))

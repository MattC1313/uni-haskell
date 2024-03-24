-- Homework for week 2

-- Lecture 4: The 'if' and 'let' statements

-- Part 1: if
-- 1. Implement a function gt_100 with one argument x, which returns 1 if x > 100, and 0 otherwise.
gt_100 x = if (x > 100) then 1 else 0
-- 2. Implement a function switch with three arguments x, y, and c. If c is equal to 1 then the function should return x, otherwise it should return y.
switch x y c = if (c == 1) then x else y
-- 3. Implement a function fizzbuzz that takes one argument x and returns “Fizzbuzz!” if x modulo 3 is 0 and x modulo 5 is 0. Otherwise it should
--    return “Nope”.
fizzbuzz x = if (mod x 3 == 0 && mod x 5 == 0) then "Fizzbuzz" else "Nope"

-- Part 2: let
-- 1. Write a function question1 x that sets a = x * x and returns 2 * a.
question1 x = let a = x * x in 2 * a
-- 2. Write a function question2 x that sets a = x + 1, b = a ∗ a, and c = 2b, and then returns a + b − c.
question2 x = let a = x + 1; b = a * a; c = 2 ^ b in a + b - c
-- 3. Write a function bounded square x that returns x * x if x * x is less than 100, and 100 otherwise. You should use a let and an if.
bounded_square x = let 
                        a = x * x 
                   in 
                        if a < 100 then a else 100


-- Lecture 5: Tuples and lists
-- For the sake of saving time, I have made my own lists that I will use when debugging. The lists are as follows:
a = ["h", "e", "l", "l", "o"]
b = "hello there"
c = ["hello", "there", "general", "kenobi"]
d = [1, 2, 3, 4, 5] 

-- Part 1: Tuples
-- 1. 1. Write a function square_and_cube x that returns a two-element tuple, where the first element is x*x, and the second is x*x*x
square_and_cube x = (x^2, x^3)
-- 2. Write a function add_tuple (a, b) that takes a tuple with two elements called a and b, and returns a + b.
add_tuple (a, b) = a + b
-- 3. Write a function swap that takes a two-element tuple, and swaps the order of the elements of that tuple.
swap (x, y) = (y, x)

-- Part 2: Lists
-- 1. Use the head function to write a function head_squared list that takes a list as an argument, and returns the square of the head of that list.
head_squared x = (head x) ^ 2
-- 2. Use the !! operator, write a function third list that returns the third element of the input list.
third (x:xs) = head(drop 2 (x:xs))
-- 3. Using the head and tail library functions, write a function third_head list that returns the third element of the input list.
third_head (x:xs) = head (tail (xs))
-- 4. Using the : operator, write a function prepend_two list a b that takes a list and two other arguments, and returns a new list with 
--    a and b added to the front.
prepend_two list a b = a : b : list

-- Part 3: List functions
-- 1. Use the length function to write a function two_lengths list1 list2 that takes two lists, and returns the sum of their lengths.
two_lengths list1 list2 = length list1 + length list2
-- 2. Use the reverse function and the ++ operator to write a function make_palindrome list that returns the list followed by the reverse of the list.
make_palindrome list = list ++ reverse list
-- 3. Use the sum and product functions to write a function sum_and_product list that returns a tuple where the first element is the sum of the list,
-- and the second element is the product of the list.
sum_and_product list = (sum list, product list)
-- 4. Use the take and drop functions to write a function four_through_six list that returns a list containing elements four, five, and six of the 
-- input list.
four_through_six list = take 3 (drop 3 list)
-- 5. Use the elem function to write a function both_in list x y that returns True if both x and y are in list.
both_in list x y = if (elem x list == True && elem y list == True) then True else False
-- Note to self: when giving a string value in lieu of a list (e.g having "Hello" as the list), you must have the characters in inverted commas to 
-- avoid an error message

-- lecture 6 : List ranges and comprehension
-- Part 1: List ranges
-- In GHCI, use a list range to write a query that outputs:
-- 1. The list of all numbers between 101 and 200.
-- 2. The list of all even numbers between 1000 and 1050.
-- 3. The list of all numbers between 20 and 1 counting backwards.
-- 4. An infinite list of all numbers divisible by 3 starting from 999. Press control+c to stop the print out.

-- 6.1 = [101..200]
-- 6.2 = [1000, 1002..1050]
-- 6.3 = [20, 19..1]
-- 6.4 = [999, 1002..]

-- Part 2: List comprehension
-- 1. In GHCI, use the ^ operator to write a list comprehension that outputs the first ten powers of two.
-- [2^x | x <- [1..10]]
-- 2. Write a function only_odds list that returns only the odd elements of the input list.
only_odds list = [x | x <- list, mod x 2 /= 0]
-- 3. Write a function between a b list that takes two numbers a < b, and returns the elements of list that are (strictly) between a and b.
between a b list = [x | x <- list, x > a, x < b]
-- 4. (*) Write a function number_of_es string that returns the number of times that ’e’ occurs in the input string.
number_of_es string = length [x | x <- string, elem x "e"]
-- 5. (**) Write a function proper_fizzbuzz that returns an infinite list with the following properties. In position i of the list,
-- • if i is divisible by 3 then the list should contain "fizz"
-- • if i is divisible by 5 then the list should contain "buzz"
-- • if i is divisible by both 3 and 5 then the list should contain "fizzbuzz"
-- • if i is not divisible by 3 or 5 then the list should contain the number i (the show function from Prelude will turn an integer into a string.)

proper_fizzbuzz = [if (mod x 3 == 0 && mod x 5 == 0) then "fizzbuzz" else if (mod x 3 == 0) then "fizz" else if (mod x 5 == 0) then "buzz" else show x | x <- [1..]]

-- I kept my failed code so that I can look back and learn from my mistakes
-- proper_fizzbuzz = [x | x <- [1..], if (mod x 3 == 0 && mod x 5 == 0) then x == "fizzbuzz" else if (mod x 3 == 0) then x == "fizz" else if (mod x 5 == 0) then x == "buzz" else x == show x]
-- x == "fizzbuzz" is not allowed as there are no variables and there is no assignment
-- proper_fizzbuzz = [x | x <- [1..], if (mod x 3 == 0 && mod x 5 == 0) then "fizzbuzz" else if (mod x 3 == 0) then "fizz" else if (mod x 5 == 0) then "buzz" else show x]
-- the part to the left of x <- [1..] is not a predicate and thus belongs on the other side of the |

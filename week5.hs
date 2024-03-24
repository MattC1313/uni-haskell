-- Lecture 12: Partial application
-- 1. Use partial application with the + function to write a function plus_ten that returns its input plus 10.
plus_10 = (+10)
-- 2. Use partial application with the == function to write a function is_twenty that returns True if its input is 20, and False otherwise.
is_20 = (==20)
-- 3. Use partial application with the ** function to write a function three_power that takes one argument n and returns 3^n.
three_power = (3**)
-- 4. Use partial application with the ** function to write a function power_three that takes one argument n and returns n^3.
power_three = (**3)

xisy x y = x ++ " is " ++ y
-- Partially apply xisy to write a function cakeis that takes one argument x and returns "cake is " ++ x
cakeis = xisy "cake"

-- Lecture 13: Polymorphic types
-- In a comment in your file, write down the most general type annotations for each of the following functions. Remember that if you get stuck, you can use 
-- the :type command to ask ghci what it thinks the type should be. You can also use this to check your answers. Make sure that you understand why ghci has 
-- assigned that type to the function.

-- 1. func1 a b = a + b + 2
-- func1 :: Num a => a -> a -> Int

-- 2. func2 a b = (a ‘div‘ 2, b / 2)
-- func2 :: Fractional a => a -> a -> [a, a]

-- 3. func3 (x:y:xs) = x == y
-- func3 :: Eq a => (a) -> Bool

-- 4. func4 [] = []
-- func4 (x:xs)
--  | x > 0 = x : func4 xs
--  | otherwise = func4 xs
-- func4 :: (Num a, Eq a) => [a] -> [a]


-- Lecture 14 Part 1: Anonymous functions
-- Write your anonymous functions in a comment in your file.

-- 1. Write an anonymous function that takes a number x and returns x-1.
-- (\x -> x - 1)
-- 2. Write an anonymous function that takes two arguments x and y and returns show x ++ show y.
-- (\ x y -> show x + show y)
-- 3. Write an anonymous function that takes a two-element tuple (x, y) and returns (y, x).
-- (\ (x, y) -> (y, x))
-- 4. Write an anonymous function that takes a list, and returns the second element of the list.
-- (\ (x:y:xs) -> y)

-- Lecture 14 Part 2: Function composition
-- Use the . and $ operators to re-write the following ghci queries. Put your modified queries in a comment in your file.

-- 1. head (head [[1]])
-- head . head $ [1]

-- 2. (+1) ((*2) 4)
-- (+1) . (*2) $ 4

-- 3. sum (tail (tail [1,2,3,4]))
-- sum . tail . tail $ [1, 2, 3, 4]

-- 4. filter (>10) (map (*2) [1..10])
-- (>10) . map (*2) $ [1..10]


-- Lecture 15 Part 1: Map
-- 1. Use map to write a function triple list that takes a list of numbers, and returns a list where each number is multiplied by three.
triple :: Num a => [a] -> [a]
triple list = map (*3) list
-- OR triple = map (*3)

-- 2. Use map to write a function list_to_str that takes a list of numbers, and returns a list where each number has been converted to a string.
list_to_str list = map show list

-- 3. Use map to write a function second_char that takes a list of strings, and returns a list containing the second character of each of the input strings.
second_char :: [[char]] -> [char]
second_char list = map (head . tail) list

-- 4. Use map to write a function add_pairs that takes a list of pairs of numbers, and returns a list that contains the sum of each pair.
add_pairs :: Num a => [(a, a)] -> [a]
add_pairs list = map (\ (x, y) -> x + y) list


-- Lecture 15 Part 2: Filter
-- 1. Use filter to write a function only_odds that takes a list of numbers, and returns a list containing only the odd numbers in the list.
only_odd list = filter odd list

-- 2. Use filter to write a function between a b list that takes two numbers a < b and a list of numbers, and returns only the numbers that 
--    are strictly between a and b.
between a b list = filter (\ x -> (x >= a) && (x <= b)) list

-- 3. Use filter to write a function ordered that takes a list of pairs, and returns only the pairs (a, b) for which a > b.
ordered list = filter (\ (a, b) -> a > b) list

-- 4. Use filter to write a function singletons that takes a list of lists, and returns only the lists that have exactly one element.
singletons list = filter (\ x -> length x == 1) list
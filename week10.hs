-- Lecture 26 Part 1: Lazy evaluation Consider the following function.
f b x y z = if b then div x y else z
-- Which of the following inputs would return an error? You can check using ghci whether you are correct. Write your answer down in your file in a comment, and give 
-- a short justification for your answer.
-- 1. f True 1 0 3
-- This will return an error because the program will try divide by zero after taking the "then" branch (since b == True)

-- 2. f True 1 2 (error "error")
-- This will not return an error because the program will integer divide 1 by 2 after taking the "then" branch (since b == True). 
-- The error is not an issue as it is never used

-- 3. f False 1 0 3
-- This will not return an error because the program will output 3 after taking the "else" branch (since b == False). 
-- The dividing by 0 is not an issue as that branch is not taken

-- 4. f False 1 0 (error "error")
-- This will return an error because the program will output the error from the argument after taking the "else" branch (since b == False).

-- 5. f True 1 2 (f False 1 2 (error "error"))
-- This will not return an error because the program will integer divide 1 by 2 after taking the "then" branch (since b == True). 
-- The dividing by 0 is not an issue as that branch is not taken


-- Lecture 26 Part 2: Lazy evaluation on lists Which of the following queries terminates? You can check your answers by typing the queries into ghci (remember
-- that control + c will terminate an infinite computation). Give a short justification for your answer.
-- 1. take 4 [1..]
-- This will terminate as it will take the first 4 elements of the list

-- 2. drop 4 [1..]
-- This will not terminate as the first 4 elements are dropped but there are an infinite number of leftover elements which will then be output

-- 3. map (*2) [1..]
-- This will not terminate as the map function will recursively double every element but the list is infinite so it won't terminate

-- 4. (zipWith (+) [1,3..] [2,4..]) !! 1000
-- This will terminate as the list is infinite but the !! function will only take the 1000th element


-- Lecture 27 Part 1: Tail recursion For each of the following questions, write an efficient function that uses tail recursion.
-- 1. Write a tail recursive function product’ :: [Int] -> Int that takes a list of numbers and multiplies all of the numbers together.
product'' [] acc = acc
product'' (x:xs) acc = product'' (xs) (x * acc)

product' :: [Int] -> Int
product' list = product'' list 1

-- 2. Write a tail recursive implementation of sum_up_to :: Int -> Int that takes a number n, and adds up all of the numbers between 0 and n inclusive.
sum_up_to' 0 acc = acc
sum_up_to' x acc = sum_up_to' (x - 1) (x + acc)

sum_up_to :: Int -> Int
sum_up_to n = sum_up_to' n 0

-- 3. (*) Write a tail recursive implementation of even_sum :: Int -> Int that takes a number n, and adds up all of the even numbers less than or equal to n.
even_sum' 0 acc = acc
even_sum' x acc = if even x then even_sum' (x - 1) (x + acc) else even_sum' (x - 1) (acc)

even_sum :: Int -> Int
even_sum n = even_sum' n 0

-- Lecture 27 Part 2: Folds 
-- For each of the following, select which of foldr, foldl, foldl’ would be the best choice to implement the function in Haskell.
-- Write your answer in your file, and give a short justification for your choice. (There is no need to code the function yourself).
-- There are two points to bear in mind here. Firstly, will the function consume every element of the list? If so, strict evaluation should be preferred.
-- Secondly, could the function possibly be called on an infinite list and still produce an answer? If so, preserving laziness should be preferred.
-- 1. A function even_product :: [Int] -> Int that takes a list of integers and multiplies all of the even elements of that list together.
-- foldl should never be used, and using foldr won't help as the list must be fully folded either way. Therefore, foldl' is the best choice

-- 2. A function sum_fsts :: [(Int, String)] -> Int that takes a list of pairs, and returns the sum of the first elements of the pairs.
-- foldl should never be used, and using foldr won't help as the list must be fully folded either way. Therefore, foldl' is the best choice

-- 3. A function even_elements :: [Int] -> [Int] that takes a list of integers and returns a list containing all of the integers that are even
-- (filter might be a better choice, but you could do this with a fold).
-- foldl should never be used, however, in this case, laziness should be preserved so the best choice would be foldr.
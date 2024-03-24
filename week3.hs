-- Week 3 homework
-- Lecture 7: Recursion
-- 1. Write a recursive function mult13 n that computes 13 * n by adding 13 to itself n times.
mult13 0 = 0
mult13 x = 13 + mult13 (x-1)
-- 2. Write a recursive function pow3 n that computes 3^n by multiplying 3 by itself n times.
pow3 0 = 1
pow3 n = 3 * pow3 (n-1)
-- 3. Write a recursive function odd_sum n that computes the sum of all odd numbers less than or equal to n. 
-- Hint: modify the even sum function from Lecture 7 if you are stuck.
odd_sum (-1) = 0
odd_sum n = if (even n == True) then odd_sum (n - 1) else n + odd_sum (n-2)
-- 4. The Lucas numbers (denoted by Li) are defined so that L0 = 2, L1 = 1, and Ln = Ln−1 + Ln−2 for all n > 1. Write a simple recursive function 
-- lucas n that computes the nth Lucas number. Your solution does not have to be computationally efficient. (Hint: try modifying the Fibonacci 
-- function that we saw in the lecture).
lucas 0 = 2
lucas 1 = 1
lucas n = lucas (n-1) + lucas (n-2)

-- Lecture 8: List recursion
-- 1. Write a recursive function half_sum list that computes the sum of all elements in the list divided by 2.
half_sum [] = 0
half_sum (x:xs) = ((x^2)/2) + half_sum (xs)
-- 2. Write a recursive function mult2 list that multiplies all elements of the input list by 2.
mult2 [] = []
mult2 (x:xs) = (2*x) : mult2 (xs)
-- 3. Write a recursive function drop_evens list that returns a new list with only the odd elements from the input list.
drop_evens [] = []
drop_evens (x:xs)
    | even x == True = drop_evens (xs)
    | otherwise = x : drop_evens (xs)
-- 4. Write a recursive function mult adjacent list that takes a list with an even number of elements, and returns a new list where adjacent pairs have 
-- been multiplied together. So, mult adjacent [1,2,3,4] should return [2, 12]. (Hint: try modifying the add adjacent function from the lecture).

mult_adjacent [] = []
mult_adjacent [x] = error "Odd number of elements"
mult_adjacent (x:y:xs) = x*y : mult_adjacent xs

-- 5. Write a recursive function get_ele i list that returns the element at position i in list. Your function should return an error if the list does not 
-- contain i elements.
get_ele i (x:xs)
    | i > length (x:xs) = error "there are not enough elements in the list"
    | otherwise = if i == 0
                  then x 
                  else get_ele (i-1) (xs)
-- 6. Write a recursive function drop_ele i list that returns a copy of the input list with the element at position i removed. Your function should 
-- return an error if the list does not contain i elements.

drop_ele i [] = []
drop_ele i (x:xs)
    | (i == 0) = drop_ele (i-1) (xs)
    | otherwise = x : drop_ele (i - 1) (xs)

-- Lecture 9: More complex recursion on lists.
-- 1. Write a recursive function div list list1 list2 that takes two lists of the same length, and divides each element in list1 by the corresponding
-- element in list2. So the function returns a list where the element in position i in the output is (list1 !! i) / (list2 !! i).
div_list [] _ = []
div_list _ [] = []
div_list (x:xs) (y:ys) = x/y : div_list xs ys
-- 2. Write a recursive recursive function longer list1 list2 that returns True if list1 is longer than list2, and False otherwise.
longer [] _ = False
longer _ [] = True
longer (x:xs) (y:ys) = longer xs ys
-- 3. Write a recursive function vowels_and_consonants string that takes a string of characters and returns a pair of strings: the first string in the
-- pair should contain all vowels in the string (which are the letters "aeiou"), and the second string in the pair should contain all letters that are not
-- vowels. You should use the elem library function in the solution for this question.

-- I could not fully answer this question. I was able to make a function that recursively outputs all of the vowels but I could not get it to output
-- two seperate lists
vowels_and_consonants [] = []
vowels_and_consonants (x:xs)
    | elem x vowels == True = x : vowels_and_consonants (xs)
    | otherwise = vowels_and_consonants (xs)
    where vowels = "aeiou"
    
-- I did not attempt the challenge question
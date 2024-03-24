-- Lecture 16: Fold
-- 1. Use foldr and the * operator to write a function list_product that multiplies all elements of a list together.
list_product list = foldr (*) 1 list

-- 2. Use foldr and the || operator (or) to write a function list_any that takes a list of Bools, and returns True if any of the list elements are True.
list_any list = foldr (||) False list

-- 3. Use foldr to write a function product_of_evens that takes a list of numbers, and multiplies all the even elements together.
product_of_evens list = foldr (\ x acc -> if even x == True then acc * x else acc) 1 list

-- 4. Use foldr to write a function lt10 that takes a list of numbers and returns the number of elements that are strictly less than 10.
lt10 list = foldr (\ x acc -> if x < 10 then acc + 1 else acc) 0 list


-- Lecture 17 Part 1: Scan
-- For each of the functions in “Lecture 16: Fold”, write a new version of the function that replaces foldr with scanr. 
-- Check that you understand the output of the new function.
scan_list_product list = scanr (*) 1 list
scan_list_any list = scanr (||) False list
scan_product_of_evens list = scanr (\ x acc -> if even x == True then acc * x else acc) 1 list
scan_lt10 list = scanr (\ x acc -> if x < 10 then acc + 1 else acc) 0 list


-- Lecture 17 Part 2: takeWhile and dropWhile
-- 1. Use takeWhile to write a function leading_caps that takes a string, and returns the elements before the first small letter of the string.
leading_caps string = takeWhile (`elem` ['A'..'Z']) string

-- 2. Use dropWhile to write a function drop_caps that takes a string, and returns all of the elements after (and including) the first small letter of the string.
drop_caps string = dropWhile (`elem` ['A'..'Z']) string

-- 3. (*) Use takeWhile and dropWhile to write a function split_on c string that takes a character c and a string, and returns a pair (before, after),
-- where before contains everything before the first instance of c, and after contains everything after the first instance of c. 
-- The first instance of c in the string should be dropped if it exists.
split_on c string = 
                    let
                        before = takeWhile (/= c) string
                        after = drop ((length before) + 1) string
                    in
                        (before, after)


-- Lecture 17 Part 3: zipWith.
-- 1. Use zipWith to write a function mul_lists that multiplies two lists together.
mul_lists list1 list2 = zipWith (*) list1 list2

-- 2. Use zipWith to write a function and_lists that takes two lists of Bools, and applies && to each pair of boolean values.
and_lists list1 list2 = zipWith (&&) list1 list2

-- 3. (*) Use reverse, zipWith, and and (returns True if a list of Bools only contains True) to write a function is_palindrome 
-- that returns true if a string is a palindrome.
is_palindrome string = and (zipWith (==) string (reverse string))
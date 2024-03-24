--Lecture 2: Pure functions

-- Q1)  A program takes two integers, it adds them together, and then squares
-- the result and returns that number. Can this be implemented as a pure
-- function? Justify your answer.
-- A1) This is a pure function as it only uses the data given in the argument 
-- and does not affect the rest of the program other than through it's return value. 
-- Furthermore, the function is deterministic - it will always produce the same result

-- Q2) A program takes the URL of a website, and then outputs the HTML
-- source code of the front page of that website. Can this be implemented
-- as a pure function? Justify your answer
-- A2) This is not a pure function as the function a has to interact with things other 
-- than its arguments in order to request the HTML source code of the website. 
-- Furthermore this is not deterministic as the output will change if the website gets edited.

-- Q3) A program takes a list of 52 cards. It then shuffles those cards and returns
-- them in a random order. Can this be implemented as a pure function?
-- Justify your answer.
-- A3) This is not deterministic. In order to truly shuffle the cards must be outputted in a 
-- random order. If this program was run twice with the same input it would produce different 
-- results and thus is not pure.

--Lecture 3: Using GHCi
--Note: I did do the queries from parts 1 and 2 of the lecture on the GHCi but they of course didn't save
-- 1) 1+1
--	  Output: 2
--    7*191
--    Output: 
--	  True || False
--	  True
--	  1 > 0
--    Output: True
--    (7*11*13) < (17*59)
--    Output: True
-- 2) max 10 11
--    Output: 11
--	  max 10 (1 + 10)
--    Output: 11
--	  max 10 1 + 10
--    Output: 20
--	  max 10 1 + max 1 2
--	  12
--	  max (5*199) (3*331)
--    Output: 995
-- 3)
plus_one x = x + 1
--	 :l "C:\\Users\\mattc\\Documents\\Uni stuff\\COMP105\\week1.hs"
--   I then chnaged the filepath to:
--   :l "C:\\Users\\mattc\\Documents\\Uni stuff\\COMP105\\Test file.hs"
--   Success: When changing the filepath to another .hs file and attempted to call the function an error message appeared:
--   <interactive>:15:1: error:
--    Variable not in scope: plus_one :: Integer -> t
-- 4) [Done]
-- 5) 
five_sum x y = (x + y) * 5
--   Success: The output is 20. It didn't work at first because I forgot to save the notepad++ file
-- 6)
--   Success, broken x = x + 1 + "Hi" produced an error when loaded
-- 7) [Done]
-- 8) 
minus_one x = x - 1
quad_power x = x ^ 4
mod_three x = mod x 3
add_three x y z = x + y + z
min_max a b c d = (min a b) + (max c d)
-- Lecture 19 Part 1: Custom types
-- Initial type definition:
-- data Direction = North | East | South | West deriving (Show)

-- 1. Modify the type definition so that the type also derives Eq. After reloading, test that your new definition works by running North == North and North /= South.
-- data Direction = North | East | South | West deriving (Show, Eq)

-- 2. Modify the type definition so that the type also derives Read. Test that your new definition works by running read "North" :: Direction
-- data Direction = North | East | South | West deriving (Show, Eq, Read)

-- 3. Modify the type definition so that the type also derives Ord. test that your new definition works by running North < East and max South West. 
--    Do you understand why these queries return the results that they do?
data Direction = North | East | South | West deriving (Show, Eq, Read, Ord)

-- 4. Write a function is_north :: Direction -> Bool that returns True if the argument is North and False otherwise.
is_North :: Direction -> Bool
is_North direction
    | direction == North = True
    | otherwise          = False

-- 5. Write a function dir_to_int :: Direction -> Int that returns 1 if the argument is North, 2 if the argument is East, 3 if the argument is South, 
--    and 4 if the argument is West
dir_to_int :: Direction -> Int
dir_to_int direction
    | direction == North = 1
    | direction == East  = 2
    | direction == South = 3
    | direction == West  = 4




-- Lecture 19 Part 2: Types with data
data Point = Point Int Int deriving (Show)

-- 1. Write a function same :: Int -> Point that takes an integer x and returns Point x x.
same :: Int -> Point
same x = Point x x

-- 2. Write a function is_zero :: Point -> Bool that returns True if the input is Point 0 0 and False otherwise. When you call your function, 
--    make sure that you use brackets around the argument, like so: is_zero (Point 0 0).
is_zero :: Point -> Bool
is_zero (Point x y) = if (x, y) == (0, 0) then True else False

-- 3. Write a function mult_point :: Point -> Int that takes Point x y and returns x * y.
mult_point :: Point -> Int
mult_point (Point x y) = x * y

-- 4. Write a function up_two :: Point -> Point that takes Point x y and returns Point x (y + 2).
up_two :: Point -> Point
up_two (Point x y) = Point x (y + 2)

-- 5. Write a function add_points :: Point -> Point -> Point that adds two points together, so if the inputs are Point a b and Point c d then 
--    the output should be Point (a+c) (b+d).
add_points :: Point -> Point -> Point
add_points (Point a b) (Point c d) = Point (a + c) (b + d)




-- Lecture 21 Part 1: Maybe
-- 1. Recall the Maybe a type from the lectures. Try it out by typing the following into ghci:
-- ghci> Just "hello"
-- ghci> Just False
-- ghci> Just 3
-- ghci> Nothing
-- Use the :t command to inspect the types of each of these values.

-- 2. Write a function not_nothing :: Eq a => Maybe a -> Bool that returns False if the input Nothing and True otherwise. Note that the Eq a constraint 
--    is necessary if you intend to do something like input == Nothing, because Maybe a is only in Eq if a is also in Eq. Equality tests can be avoided 
--    by using pattern matching.
-- not_nothing :: (eq a) => Maybe a -> Bool
not_nothing x = case x of Nothing -> False
                          _ -> True

-- 3. Write a function mult_maybe :: Maybe Int -> Maybe Int -> Maybe Int that returns Just (x*y) if the inputs are Just x and Just y, and returns Nothing 
--    if one or more of the inputs is Nothing.
mult_maybe :: Maybe Int -> Maybe Int -> Maybe Int
mult_maybe x y = case (x, y) of (x, Nothing) -> Nothing
                                (Nothing, y) -> Nothing
                                (Just x, Just y) -> Just (x * y)




-- Lecture 21 Part 2: Either
-- 1. Recall the Either a b type from the lectures. Try it out by typing the following into ghci.
-- ghci> Left ’a’
-- ghci> Left False
-- ghci> Right "hello"
-- Again, you can use the :t command to inspect the types of each of these values.

-- 2. Write a function return_two :: Int -> Either Bool Char that takes one argument n and returns Left True if n == 1 and returns Right ’a’ otherwise.
return_two n = case n of 1 -> Left True
                         _ -> Right 'a'

-- 3. Write a function show_right :: Either String Int -> String that returns x if the input is Left x and show y if the input is Right y.
show_right :: Either String Int -> String
show_right value = case value of (Left value)  -> value
                                 (Right value) -> show value
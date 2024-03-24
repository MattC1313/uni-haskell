module Main (get_maze, print_maze, is_wall, place_player, move, can_move, game_loop, get_path, main) where 

import System.Environment

maze_path = "overwrite this with your own path!"

-- Useful code from Lecture 25
-- You may use this freely in your solutions

get :: [String] -> Int -> Int -> Char
get maze x y = (maze !! y) !! x 

modify_list :: [a] -> Int -> a -> [a]
modify_list list pos new =
    let
        before = take  pos    list
        after  = drop (pos+1) list
    in
        before ++ [new] ++ after

set :: [String] -> Int -> Int -> Char -> [String]
set maze x y char = 
    let
        line = maze !! y
        new_line = modify_list line x char
        new_maze = modify_list maze y new_line
    in
        new_maze

---- Part A

-- Question 1

-- Test with: get_maze "maze2.txt"
get_maze :: String -> IO [String]
get_maze text = do
    string <- readFile text
    let maze = lines string
    return maze

-- Question 2

-- Test with: x <- get_maze "maze2.txt"
--            print_maze x
print_maze :: [String] -> IO ()
print_maze maze = putStrLn . unlines $ maze

-- Question 3

-- Test with: is_wall x (0, 0)
--            is_wall x (3, 3)
is_wall :: [String] -> (Int, Int) -> Bool
is_wall maze (x, y) = if (get maze x y) == '#' then True else False

-- Question 4

-- Test with: print_maze (place_player x (1, 1))
place_player :: [String] -> (Int, Int) -> [String]
place_player maze (x, y) = if is_wall maze (x, y) == False
                           then set maze x y '@'
                           else ["You can't go here, there's a wall!."]


---- Part B

-- Question 5

-- Test with: move (1, 1) 'w'
--            move (1, 1) 's'
--            move (1, 1) 'a'
--            move (1, 1) 'd'
--            move (1, 1) 'q'
move :: (Int, Int) -> Char -> (Int, Int)
move (x, y) char = case char of 'w' -> (x, y - 1)
                                'a' -> (x - 1, y)
                                's' -> (x, y + 1)
                                'd' -> (x + 1, y)
                                _   -> (x, y)

-- Question 6

-- Test with: can_move x (1, 1) 'a'
--            can_move x (1, 1) 's'
can_move :: [String] -> (Int, Int) -> Char -> Bool
can_move maze (x, y) char = let
                                new_pos = move (x, y) char
                                valid = not (is_wall maze new_pos)
                            in
                                valid

-- Question 7

game_loop :: [String] -> (Int, Int) -> IO ()
game_loop maze (x, y) = do
    print_maze (place_player maze (x, y))
    
    line <- getLine
    let char = head line
    
    if can_move maze (x, y) char == False
        then game_loop maze (x, y)
        else game_loop maze (move (x, y) char)



---- Part C

unlist :: [a] -> a
unlist [list] = list

beside :: (Int, Int) -> (Int, Int) -> Bool
beside (a, b) (x, y)
    | ((a == x) && (b == (y+1))) = True
    | ((a == x) && (b == (y-1))) = True
    | ((a == (x+1)) && (b == y)) = True
    | ((a == (x-1)) && (b == y)) = True
    | otherwise = False

-- a = (map (map (\ x -> if x == '#' then '7' else x)) x)
is_unchecked_corridor :: [String] -> (Int, Int) -> Bool
is_unchecked_corridor maze (x, y) = let
                                        char = get maze x y
                                        wall = get maze 0 0
                                    in
                                        if (char /= wall && char /= '.')
                                        then True 
                                        else False


check_corridors :: [String] -> (Int, Int) -> Int -> [((Int, Int), Int)]
check_corridors maze (x, y) n = let
                                    left  = (x-1, y)
                                    right = (x+1, y)
                                    up    = (x, y+1)
                                    down  = (x, y-1)
                                in
                                    foldr (\ x acc -> if (is_unchecked_corridor maze x == True) then (x, n) : acc else acc) [] [left, right, up, down]


bfs maze ((a, b), c) (y, z) queue visited n
    | ((a, b) == (y, z)) = discern_route new_visited (a, b) c [(y, z)]
    | (queue == []) = [(\ ((x, y), z) -> (x, y)) (head visited)]
    | otherwise = bfs marked_maze (head new_queue) (y, z) (tail new_queue) new_visited (n+1)--folded_queue
    where marked_maze = set maze a b '.'
          new_queue = queue ++ check_corridors marked_maze (a, b) n
          new_visited = visited ++ [((a, b), c)]
          --folded_queue = foldr (\ x acc -> if (elem x acc == False) then x : acc else acc) [] new_queue


discern_route :: [((Int, Int), Int)] -> (Int, Int) -> Int -> [(Int, Int)] -> [(Int, Int)]
discern_route [] _ _ route = route
discern_route _ _ (-1) route = route
discern_route path current_point level route = let
                                                    filtered = filter (\ (_, c) -> c == (level - 1)) path
                                                    mapped = map (\ ((a, b), c) -> (a, b)) filtered
                                                    new_path = take ((length path) - (length filtered)) path
                                                    options = filter (\ (a, b) -> beside current_point (a, b)) mapped
                                               in
                                                    if options == []
                                                    then discern_route new_path current_point (level-1) route
                                                    else discern_route new_path (head options) (level-1) ((head options) : route)

-- This function was only used to test that the function from question 8 worked
plot_maze maze [] = print_maze maze
plot_maze maze ((x, y):z) = let
                                marked_maze = set maze x y '.'
                             in
                                plot_maze marked_maze z

-- Question 8

-- Test with: x <- get_maze "maze-big-1.txt"
--            y <- get_maze "maze-big-2.txt"
--            z <- get_maze "maze-big-3.txt"
--            print_maze x
--            plot_maze x (get_path x (1, 1) (59, 19))
--            plot_maze x (get_path x (1, 1) (1, 19))
--            plot_maze x (get_path x (1, 1) (47, 19))
get_path :: [String] -> (Int, Int) -> (Int, Int) -> [(Int, Int)]
get_path maze start end = bfs maze (start, 0) end [(start, 0)] [] 0

-- Question 9

main :: IO ()
main = do
    args <- getArgs
    maze <- get_maze (head args)
    let start = (1, 1)
        end = ((length (last maze)) - 2, (length maze) - 2)
    plot_maze maze (get_path maze start end)

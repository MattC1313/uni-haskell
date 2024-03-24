-- Do not alter the following line
module Assignment2 (transaction_to_string, trade_report_list, stock_test, get_trades, trade_report, update_money, profit, profit_report, complex_profit_report) where


type Transaction = (Char, Int, Int, String, Int) 

test_log :: [Transaction]
test_log = [('B', 100, 1104,  "VTI",  1),
            ('B', 200,   36, "ONEQ",  3),
            ('B',  50, 1223,  "VTI",  5),
            ('S', 150, 1240,  "VTI",  9),
            ('B', 100,  229, "IWRD", 10),
            ('S', 200,   32, "ONEQ", 11), 
            ('S', 100,  210, "IWRD", 12)
            ]


-- Part A
a = ('B', 150 :: Int, 1004 :: Int, "VTI", 1 :: Int) :: Transaction

transaction_to_string :: Transaction -> String
transaction_to_string (a, b, c, d, e) = let
                                            action = if a == 'B' then "Bought " else "Sold "
                                            units  = show b
                                            price  = show c
                                            stock  = d
                                            day    = show e
                                        in
                                            action ++ units ++ " units of " ++ stock ++ " for " ++ price ++ " pounds each on day " ++ day


trade_report_list :: [Transaction] -> [String]
trade_report_list list = map transaction_to_string list


stock_test :: String -> Transaction -> Bool
stock_test stock (_, _, _, d, _) = if stock == d then True else False


get_trades :: String -> [Transaction] -> [Transaction]
get_trades stock list = filter (\ x -> stock_test stock x) list


trade_report :: String -> [Transaction] -> String
trade_report stock list = let
                                filtered = get_trades stock list
                                converted_filtered = trade_report_list filtered
                          in
                                unlines converted_filtered



-- Part B


update_money :: Transaction -> Int -> Int
update_money (a, b, c, _, _) money = let
                                        difference = b * c
                                     in
                                        if a == 'B' then money - difference else money + difference


profit :: [Transaction] -> String -> Int
profit list stock = let
                        filtered = get_trades stock list
                    in
                        foldr (\ x acc -> update_money x acc) 0 filtered



profit_report :: [String] -> [Transaction] -> String
profit_report [] list = []
profit_report (x:xs) list = x ++ ": " ++ show (profit list x) ++ "\n" ++ (profit_report xs list)




-- Part C


test_str_log = "BUY 100 VTI 1\nBUY 200 ONEQ 3\nBUY 50 VTI 5\nSELL 150 VTI 9\nBUY 100 IWRD 10\nSELL 200 ONEQ 11\nSELL 100 IWRD 12\n"



type Prices = [(String, [Int])]

test_prices :: Prices
test_prices = [
                ("VTI", [1689, 1785, 1772, 1765, 1739, 1725, 1615, 1683, 1655, 1725, 1703, 1726, 1725, 1742, 1707, 1688, 1697, 1688, 1675]),
                ("ONEQ", [201, 203, 199, 199, 193, 189, 189, 183, 185, 190, 186, 182, 186, 182, 182, 186, 183, 179, 178]),
                ("IWRD", [207, 211, 213, 221, 221, 222, 221, 218, 226, 234, 229, 229, 228, 222, 218, 223, 222, 218, 214])
              ]


convert_to_tuple string = let
                            list = words string
                          in
                            (head (list !! 0), read (list !! 1) :: Int, list !! 2, read (list !! 3) :: Int)


-- Test with argument: list_stocks (lines ("SELL 298 HELLO 58\n" ++ test_str_log ++ "BUY 324 THERE 60"))


-- Gets a list of all of the stocks that appear in the list of transactions
list_stocks str = let
                    list = map (\ x -> (words x)!! 2) str
                    no_repeats_list = foldl (\ acc x -> if (elem x acc == False) then acc ++ [x] else acc ++ []) [""] list
                  in
                    drop 1 no_repeats_list


-- Gets the list of prices for a specific stock
get_value_list stock list = let
                                tuple = head (filter (\ (x, _) -> x == stock) list)
                            in
                                (\ (_, y) -> y) tuple


-- Gets the stock value for that specific day
calculate_stock_value :: [Int] -> Int -> Int
calculate_stock_value (x:xs) day
    | (day == 1) = x
    | otherwise = calculate_stock_value xs (day - 1)


tuple_to_transaction :: (Char, Int, String, Int) -> Prices -> Transaction
tuple_to_transaction (a, b, c, d) price_list = let
                                                    value_list = get_value_list c price_list
                                                    e = calculate_stock_value value_list d
                                                 in
                                                    (a, b, e, c, d)


complex_test_prices = test_prices ++ [("HELLO", [1..100]), ("GENERAL", [1..100]), ("THERE", [100..1000]), ("KENOBI", [59..350])] :: Prices


complex_profit_report :: String -> Prices -> String
complex_profit_report transactions_string price_list = let
                                                            transactions_list   = lines transactions_string
                                                            tuple_list          = map convert_to_tuple transactions_list
                                                            transactions_tuples = map (\ x -> tuple_to_transaction x price_list) tuple_list
                                                            stock_list          = list_stocks transactions_list
                                                       in
                                                            profit_report stock_list transactions_tuples
        


# Uni-Haskell
Collection of smaller university projects that were programmed using Haskell as part of my COMP105 Programming Paradigms module, including assignments and weekly homework.

## Contents
1. [Assignment summaries](#assignmentSummaries)
    1. [Assignment 1](#assignment1)
    2. [Assignment 2](#assignment2)
    3. [Assignment 3](#assignment3)
2. [Homework topic summaries](#homeworkSummaries)

<a id="assignmentSummaries"></a>
### Assignment summaries

<a id="assignment1"></a>
##### <ins>Assignment 1 - Simplified run-length encoding</ins>
The full brief can be found in the file named *Assignment-1-handout.pdf*

My solution is found in the file *Assignment1.hs*

In this assignment, I implement a run-length encoder.
- If a string contains repeated letters, such as "aaaa", it is replaced with a shorter encoded string "a4", which says that the letter 'a' should be repeated four times.
- To encode a string into the repeat encoding, all repeated characters should be transformed into their repeat encodings.
  - Thus, the encoder would take `aaaabbb` and return `a4b3`.
- The decoder does the opposite: it takes repeat encoded strings and returns the original.
  - Thus, the decoder would take `a2b2c2` and return `aabbcc`.

To make things easier, the brief outlined a simplified version with the following properties:
- No character is ever repeated more than nine times.
- Single instances of a character will still be repeat encoded.
  - This means that the string `abc` will be encoded to `a1b1c1`, even though the encoding is longer than the original.

Restrictions:
The assignment's purpose was to test my skills at creating recursive functions and thus the code should:
- Use recursion wherever possible
- Not use any library functions except head and tail
- Not use list comprehensions.

<a id="assignment2"></a>
##### <ins>Assignment 2 - Transaction logs</ins>
The full brief can be found in the file named *Assignment-2-handout.pdf*

My solution is found in the file *Assignment1.hs*

- In this assignment, I create functions that handle the transaction history in a portfolio of stocks.
- A transaction is represented by a tuple e.g. `('B', 100, 1104, "VTI", 1)`
   - The first element is a character that is either 'B' or 'S'. This represents whether the transaction was buying or selling.
   - The second element is an integer representing how many units were bought or sold.
   - The third element is an integer representing the price per unit that we bought or sold at.
   - The fourth element represents the stock that we bought.
   - The final element represents the day that the transaction took place on.
- So `('B', 100, 1104, "VTI", 1)` says that we bought 100 units of VTI on day 1, and we paid £1104 per unit.
   - So the total amount that we spent was 100 × £1104 = £110400.
- A transaction log is a list of transactions in the order they were executed. For example:
   ```
   [
      ('B', 100, 1104, "VTI", 1),
      ('B', 200, 36, "ONEQ", 3),
      ('B', 50, 1223, "VTI", 5),
      ('S', 150, 1240, "VTI", 9),
      ('B', 100, 229, "IWRD", 10),
      ('S', 200, 32, "ONEQ", 11),
      ('S', 100, 210, "IWRD", 12)
   ]
   ```
   - Note that there is a mix of buy and sell transactions, and various stocks are bought and sold.
   - Note also that at the end of the log we do not own any stocks (eg., we bought 100 + 50 = 150 units of VTI, and then sold 150 units before the end of the log.)
      - The brief specifies I can assume that this is the case for all transaction logs.
- The type declaration for a `Transaction` is as follows:
   - `type Transaction = (Char, Int, Int, String, Int)`
- All transaction logs have the type `[Transaction]`

This assignment is split into three parts: A, B, and C
- Part A - the goal is to build a program to report the transactions for a particular stock in a human-readable format.
   - For example, given the transaction log above, the transactions on the stock VTI will be printed as:
      ```
      Bought 100 units of VTI for 1104 pounds each on day 1
      Bought 50 units of VTI for 1223 pounds each on day 5
      Sold 150 units of VTI for 1240 pounds each on day 9
      ```
   - The function to do this is `trade_report` which takes the name of a stock and a transaction log as its parameters.
   - The code to test this in the GHCi would be `trade_report "VTI" test_log`
- Part B - the goal is to build a function to tell the user how much profit or loss was made on each stock.
    - For example, given the transaction log above, the report will be:
      ```
      VTI: 14450
      ONEQ: -800
      IWRD: -1900
      ```
    - The money spent on a buy transaction is `units × price`
    - Likewise, the money earned on a sell transition is `units x price`
    - Thus, the total profit for a given stock is calculated by the sum of the `unit x price` calculations for each transaction
    - Thus, to find the profit or loss from a particular stock, we add up the money gained by selling and subtract the money spent from buying.
        - For example, given the transaction log from earlier, the transactions on the stock VTI will be `−(100 × 1104) − (50 × 1223) + (150 × 1240) = 14450`
    - The function to do this is `profit_report` which takes a list of names of stocks and a transaction log as its parameters.
    - The code to test this in the GHCi would be `profit_report ["VTI", "ONEQ"] test_log`
- Part C - the objective is to again produce a profit report, in the same format as part B, but this time the input is given in a less convenient format.
    - The trade log will be given as a plain text list of strings, such as:
      ```
      BUY 100 VTI 1
      BUY 200 ONEQ 3
      BUY 50 VTI 5
      SELL 150 VTI 9
      BUY 100 IWRD 10
      SELL 200 ONEQ 11
      SELL 100 IWRD 12
      ```
    - Each line has the following format
        - The first word is either BUY or SELL.
        - The second word is an integer giving the number of units that were bought or sold.
        - The third word is the stock.
        - The fourth word is the day on which the trade took place.
    - The brief says I can assume that there is exactly one space between each word.
    - Each line ends with the newline character \n.
    - Note that the prices do not appear in the transactions. These are instead given as a price database of type `[(String, [Int])]`. For example:
      ```
      [
      ("VTI", [1689, 1785, 1772, 1765, 1739, 1725, 1615, 1683, 1655, 1725, 1703, 1726, 1725, 1742, 1707, 1688, 1697, 1688, 1675]),
      ("ONEQ", [201, 203, 199, 199, 193, 189, 189, 183, 185, 190, 186, 182, 186, 182, 182, 186, 183, 179, 178]),
      ("IWRD", [207, 211, 213, 221, 221, 222, 221, 218, 226, 234, 229, 229, 228, 222, 218, 223, 222, 218, 214])
      ]
      ```
    - Each element of the list is a tuple.
    - The first element of the tuple gives the name of the stock.
    - The second element of the tuple lists prices for that stock.
        - The first element of the list is the price on day one, the second element is the price on day two, and so on.
        - So the price of VTI on day two is 1785.
    - The brief says I can assume that each day used in the transaction log has a corresponding price in the price database.
    - The function to do this is `complex_profit_report` which takes a transaction log (formatted as strings) and the list of stock prices as its parameters.
    - The code to test this in the GHCi would be `complex_profit_report test_str_log test_prices`

<a id="assignment3"></a>
##### <ins>Assignment 3 - </ins>
The full brief can be found in the file named *Assignment-3-handout.pdf*

My solution is found in the file *Assignment3.hs*

<a id="homeworkSummaries"></a>
### Homework topic summaries
Here is a brief of what topics each homework covers:
- *week1.hs*
  - what is a pure function
  - loading in files to the ghci
  - making my own functions
- *week2.hs*
  - The 'if' and 'let' statements
  - Tuples and lists
  - List functions
  - List ranges and comprehension (includes FizzBuzz)
- *week3.hs*
  - Recursion
  - List recursion
- *week5.hs*
  - Partial application
  - Polymorphic types
  - Anonymous functions
  - Function composition (`.` and `$`)
  - `map` and `filter`
- *week6.hs*
  - `fold`
  - `scan`
  - `takeWhile` and `dropWhile`
  - `zipWith`
- *week7.hs*
  - Custom types
  - `Maybe`
  - `Either`
- *week8.hs*
  - Introduction to IO
  - `getLine` and `putStrLn`
  - `Do` blocks
  - Looping in IO code
  - Compiling and running programs
- *week10.hs*
  - Lazy evaluation
  - Lazy evaluation on lists
  - Tail recursion

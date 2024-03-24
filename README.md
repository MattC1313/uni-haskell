# Uni-Haskell
Collection of smaller university projects that were programmed using Haskell as part of my COMP105 Programming Paradigms module, including assignments and weekly homework.

## Contents
1. [Assignment summaries](#assignmentSummaries)
2. [Homework topic summaries](#homeworkSummaries)

<a name="assignmentSummaries"></a>
### Assignment summaries
##### Assignment 1 - Simplified run-length encoding
The full brief can be found in the file named *Assignment-1-handout.pdf*

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

My solution is found in the file *Assignment1.hs*

<a name="homeworkSummaries"></a>
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

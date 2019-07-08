using StatsBase

#Problems (you can use binomial(n,k), instead of composing factorial() calls in julia)
#1-1
#a (12)₄ -> 11,880
ans =  factorial(12)/(factorial(12-4))
#b 12 choose 4 -> 495
ans = factorial(12)/(factorial(4)*factorial(12-4))
#c 100 choose 97 -> 162700
ans =  factorial(big(100))/(factorial(big(97))*factorial(100-97))
#d  12 choose 4,3,5 -> 27720
ans =  factorial(12)/(factorial(4)*factorial(3)*factorial(5))
#e (n)₃ -> n³-3n²+2n as n! == n(n-1)(n-2) and (n-3)! == 0! == 1
#d n choose 3 -> ⅙ n³-3n²+2n when  n!\3!(n-3)! == from #e n!== n³-3n²+2n and 3!(n-3)! == 6

#1-2 A function assigns a value from a range of k values to each point in a domain of m points. How many distinct functions can be defined?
#from(nᵏ) k posible states of m items == kᵐ

#1-3 How many code letters can be formed when each letter is represented by a sequence of four or fewer dots and/or dashes? (Some examples of such sequences: ⋯ -, --·, ·-)
ans = 2^1 + 2^2 +2^3 +2^4

#1-4
#a roll of 3 dice (assuming 6 states) and nᵏ
ans = 6 ^ 3

#b the toss of n coins from 2  possible states of n toss/items
#ans = 2ⁿ

#c the designation of four persons from a group of 10 to serve as president, vice-president, secretary, and treasurer.
#from 10 choose 4 order  matters(with duplicates) and without replacement
ans = factorial(10)/factorial(10-4)

#1-5 Consider sequences of ten symbols, each a: '+' or a: '−'
#a How many distinct sequences are possible?
#from nᵏ -> 2 states(+,-) of 10
ans = 2 ^ 10

#b How many of the sequences in (a) have at least eight +’s in them?
ans = factorial(10)/(factorial(2)*factorial(8)) + factorial(10)/(factorial(1)*factorial(9)) + factorial(10)/factorial(10)

#c How many contain exactly five +’s and exactly five—’s?
ans = factorial(10)/(factorial(5)*factorial(5))

#d Of the sequences in (c), how many have at least four +’s in a row?
ans = missing

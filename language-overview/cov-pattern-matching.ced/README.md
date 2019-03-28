# cov-pattern-matching.ced

```
module cov-pattern-matching.

-- You are encouraged to read the description of the file below before
-- continuing to read this one.
import datatypes.

{- Course-of-values Recursion
-- =============================================================================
-- Cedille implements a semantic termination checker for recursive functions
-- defined by μ-expressions. In the constructor patterns revealed by μ cases,
-- recursive occurrences of the datatype in constructor argument types are
-- replaced by an "abstract" type, which is the type of legal arguments for
-- further recursive calls. This can be seen in the definition of `add` in
-- datatypes.ced
--
-- The reason for this is to enable support for definitions expressed as
-- course-of-values recursion (and induction) schemes. The case-analysis
-- construct μ' /preserves/ the type of the scrutinee (whether it is an abstract
-- or concrete datatype), meaning that any arbitrarily computed subdata of a
-- term over which a recursive definition is given is a legal argument for
-- recursive calls.
--
-- For a very simple example with a static number of cases analyzed, consider
-- the definition of `fib` below:
-}

fib : Nat ➔ Nat
  = λ n. μ fib. n {
  | zero ➔ suc zero
  | suc n' ➔ μ' n' {
    | zero ➔ suc zero
    | suc n'' ➔ add (fib n') (fib n'')
    }
  }.

{- The predecessor `n'` has type `Type/fib`. We perform an additional round of
-- pattern matching to produce its predecessor, `n''` which also has this type.
-- Thus both are legal arguments for recursive calls with the μ-bound `fib`
--
-- Course-of-values recursion subsumes recursion with a fixed number of cases
-- analyzed: an arbitrarily computed predecessor is a legal argument for
-- recursion. To show this in action, we first define a version of predecessor
-- that preserves its argument type (whether it is abstract or concrete)
-}

predCV : ∀ N: ★. Is/Nat ·N ➾ N ➔ N
  = Λ N. Λ is. λ n. μ'<is> n {zero ➔ n | suc n ➔ n}.

{- Here we see our first use of the `Is/Nat` type predicate. Recall that
-- `Is/Nat ·N` is the type of witnesses that any term of type `N` may be treated
-- as if it had type `Nat` for the purposes of pattern matching. The global and
-- μ-local witnesses (such as in `fib`) are automatically inferred in Cedille;
-- witnesses passed as arguments must be given explicitly for the time being.
--
-- Perhaps surprisingly, `predCV` here and `pred` in datatypes.ced are
-- definitionaly equal!
-}

eq-pred-predCV : {pred ≃ predCV} = β.

{- That is because the additional type argument and witness are erased
--
-- This leads to a style of writing functions where, when possible,
-- you first write an abstract version (which preserves the type of its
-- arguments), then reuse this function when defining the concrete version of
-- that function. Here's an example of this in action to define `minus` in terms
-- of the type-preserving `minusCV`
-}

minusCV : ∀ N: ★. Is/Nat ·N ➾ N ➔ Nat ➔ N
  = Λ N. Λ is. λ m. λ n. μ mMin. n {
  | zero ➔ m
  | suc n ➔ predCV -is (mMin n)
  }.
minus = minusCV -is/Nat.

{- A type-preserving version of subtraction can be used to define division over
-- natural numbers close to the intuitive way (i.e. using iterated subtraction).
--
-- lt: test whether the first number is less than the second
-- ite: conditional branch
-}

lt : Nat ➔ Nat ➔ Bool
  = λ m. λ n. μ' (minus (suc m) n) {zero ➔ tt | suc _ ➔ ff}.

ite : ∀ X: ★. Bool ➔ X ➔ X ➔ X
  = Λ X. λ b. λ t. λ f. μ' b {| tt ➔ t | ff ➔ f}.

div : Nat ➔ Nat ➔ Nat
  = λ m. λ n. μ divN. m {
  | zero ➔ zero
  | suc m ➔
    [m' = to/Nat -isType/divN m] -                -- (1)
    [difMN = minusCV -isType/divN m (pred n)] -   -- (2)
      ite (lt (suc m') n) zero (suc (divN difMN)) -- (3)
  }.

{- (1) Cast the predecessor `m` (of type `Type/divN`) to `Nat`, and name this
--    `m'`
-- (2) Calculate the difference between the dividend and divisor, preserving the
--     abstract type
-- (3) If the dividend is less than the divisor, produce zero. Otherwise, divide
--     the difference `n` and increment the result.
-}
```

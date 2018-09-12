# type-quantification.ced

```
module TypeQuantification.

K ◂ ∀ X : ★ . ∀ Y : ★ . X ➔ Y ➔ X = Λ X . Λ Y . λ x . λ y . x.

Bool ◂ ★ = ∀ X : ★ . X ➔ X ➔ X .
tt ◂ Bool = Λ X . λ a . λ b . a.
ff ◂ Bool = Λ X . λ a . λ b . b.

Unit ◂ ★ = ∀ X : ★. X ➔ X.
unit ◂ Unit = Λ X. λ x. x.

{- instantiate type variables explicitly with the center dot notation.
   This is true whether the function whose type variables need instantiating
   is at the term or the type level. -}
test1 = K · Bool · Unit tt unit .

{- As an aside, Cedille's spine-local type inference can fill in those type arguments.
   See language-overview/type-inference.ced for more examples. -}
test2 = K tt unit . 

{- note the use of center dot below in applications of the List type constructor -}
List ◂ ★ ➔ ★ = λ A : ★ . ∀ X : ★ . (A ➔ X ➔ X) ➔ X ➔ X .
Nil ◂ ∀ A : ★ . List · A = Λ A . Λ X . λ c . λ n . n .
Cons ◂ ∀ A : ★ . A ➔ List · A ➔ List · A = Λ A . λ h . λ t . Λ X . λ c . λ n . c h (t · X c n) .
```

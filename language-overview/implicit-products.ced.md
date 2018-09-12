# implicit-products.ced

```
module ImplictProducts.

Nat ◂ ★ = ∀ X : ★ . (X ➔ X) ➔ X ➔ X .
Z ◂ Nat = Λ X . λ f . λ a . a .
S ◂ Nat ➔ Nat = λ n . Λ X . λ f . λ a . f (n · X f a) .

{- use the binder ∀ x : T to indicate an erased (i.e., specificational)
   term-level input x of type T. This is seen below in the ∀ n : Nat
   binder in the definition of Vector. -}
Vector ◂ ★ ➔ Nat ➔ ★ = λ A : ★ . λ n : Nat .
  ∀ X : Nat ➔ ★ .
    X Z ➔
    (∀ n : Nat . A ➔ X n ➔ X (S n)) ➔
    X n.

Vnil ◂ ∀ A : ★ . Vector · A Z =
  Λ A . Λ X . λ ni . λ c . ni .

{- to instantiate an implicit product, the notation in Cedille is f -t,
   where f is the function whose type starts with ∀ x : T (for some x and T),
   and t is the term with which to instantiate x.  This is shown below
   in subterm c -n. -}
Vcons ◂ ∀ A : ★ . ∀ n : Nat . A ➔ Vector · A n ➔ Vector · A (S n) =
  Λ A . Λ n . λ a . λ v . Λ X . λ ni . λ c . c -n a (v · X ni c) .
```

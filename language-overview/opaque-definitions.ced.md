# opaque-definitions.ced

```
module OpaqueDefinitions.

{- if you mark definitions as opaque, Cedille will never expand them
   during conversion checking, unless you explicitly open them.
   The point of opaque definitions is to support abstraction,
   which in Cedille is all the more needed as the basic terms are
   just pure lambda terms.  With lambda encodings, terms can quickly
   become large and hard to read.  Marking definitions as opaque can
   help mitigate this.  Below is an example. -}

{- we first make opaque definitions of Church nats: -}
opaque cNat ◂ ★ = ∀ X : ★ . (X ➔ X) ➔ X ➔ X .
opaque cZ ◂ cNat = open cNat - Λ X . λ f . λ a . a .
opaque cS ◂ cNat ➔ cNat = λ n . open cNat - Λ X . λ f . λ a . f (n · X f a) .

{- then we derive an eliminator and lemmas describing its reduction behavior -}
cNatElim ◂ cNat ➔ ∀ X : ★ . (X ➔ X) ➔ X ➔ X = λ x . open cNat - x .
redS ◂ ∀ X : ★ . ∀ f : X ➔ X . ∀ a : X . ∀ n : cNat . { cNatElim (cS n) f a ≃ f (n f a) } =
  Λ X . Λ f . Λ a . Λ n . open cS - β.
redZ ◂ ∀ X : ★ . ∀ f : X ➔ X . ∀ a : X . ∀ n : cNat . { cNatElim cZ f a ≃ a } =
  Λ X . Λ f . Λ a . Λ n . open cZ - β.

{- now write functions using the eliminator, like add -}
add ◂ cNat ➔ cNat ➔ cNat =
  λ n . λ m .
    cNatElim n cS m .

{- Finally, in the course of the reasoning below, we never see a
   lambda-encoded number, just applications of cS and cZ (and add). -}
add-test ◂ ∀ n : cNat . ∀ m : cNat . { add (cS (cS n)) m ≃ cS (cS (add n m)) } =
  Λ n . Λ m .
    ρ (redS -cS -m -(cS n)) -
    ρ (redS -cS -m -n) - β .

{- if we wished, we could make the definition of add opaque, and prove the
   basic lemmas describing its recursion behavior, similarly to what we
   did with cNatElim, redS and redZ.  Then we would not see unfoldings of
   add (so no "cNatElim n"), just applications of it to constructor terms.
   But this is a matter of taste.

   This feature we anticipate being most useful for people experimenting
   with new lambda encodings.  For ordinary use, in Cedille 1.1 we expect
   to release datatype notations and pattern-matching functions, which will
   elaborate to lambda encodings checkable by Cedille (Core). -}
```

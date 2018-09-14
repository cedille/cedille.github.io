# obviously-false-equations.ced

```
module ObviouslyFalseEquations.

Bool' ◂ ★ = ∀ X : ★ . X ➔ X ➔ X .
tt' ◂ Bool' = Λ X . λ a . λ b . a.
ff' ◂ Bool' = Λ X . λ a . λ b . b.

{- Cedille includes an inference rule, written δ, to
   inhabit any type given a proof of an equation between
   terms with distinct head-normal forms.  Such equations
   are false in Cedille's theory, since the equality type
   is interpreted as meaning that the sides of the equation
   are beta-eta equal. -}

BoolContra ◂ {tt' ≃ ff'} ➾ False =
  Λ e . δ - e . 
```

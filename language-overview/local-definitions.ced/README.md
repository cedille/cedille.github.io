# local-definitions.ced

```
module let.

import induction-for-church-nats.

{- Cedille supports local definitions within expressions, or "let-bound"
-- variables. The syntax for these in Cedille is `[x : T = t1] - t2` or
-- `[x = t1] - t2`, where `x` is an identifier, `t1` and `t2` are terms, and `T`
-- is an (optional) type
-}

num2 : Nat = [num1 = suc zero] - [num1' = suc zero] - suc num1.

{- Let-bound variables may be unerased or erased expressions, depending upon how
-- they appear in the body of the let expression. Above, `num1` is unerased and
-- `num1'` is erased, because the occurrence checker notices that the latter
-- does not occur anywhere in the erasure of the expression body
--
-- Automatically detecting when an let-bound expression is erasable can be
-- helpful for carrying out proofs with erased premises, e.g.
-}

eq-trans1-fail : ∀ A: ★. Π x: A. Π y: A. Π z: A. {x ≃ y} ➾ {y ≃ z} ➾ {x ≃ z}
  = Λ A. λ x. λ y. λ z. Λ eqxy. Λ eqyz. -- <-- error: occurs free in the erasure of body
    [eqxz : {x ≃ z} = ρ eqxy - eqyz] - eqxz.

eq-trans1 : ∀ A: ★. Π x: A. Π y: A. Π z: A. {x ≃ y} ➾ {y ≃ z} ➾ {x ≃ z}
  = Λ A. λ x. λ y. λ z. Λ eqxy. Λ eqyz.
    [eqxz : {x ≃ z} = ρ eqxy - eqyz] - ρ eqxz - β.

{- If you want to force a let bound variable to not occur within the erasure of
-- its body, you can use {} instead of [] for the let expression
-}

eq-trans2-fail : ∀ A: ★. Π x: A. Π y: A. Π z: A. {x ≃ y} ➾ {y ≃ z} ➾ {x ≃ z}
  = Λ A. λ x. λ y. λ z. Λ eqxy. Λ eqyz.
    {eqxz : {x ≃ z} = ρ eqxy - eqyz} - eqxz.
--   ^--^
--   |__|__ error: occurs free in the body

eq-trans2 : ∀ A: ★. Π x: A. Π y: A. Π z: A. {x ≃ y} ➾ {y ≃ z} ➾ {x ≃ z}
  = Λ A. λ x. λ y. λ z. Λ eqxy. Λ eqyz.
    {eqxz : {x ≃ z} = ρ eqxy - eqyz} - ρ eqxz - β.

-- The let-binding in `eq-trans1` is implicitly erased; in `eq-trans2` it is
-- explicitly erased.
```

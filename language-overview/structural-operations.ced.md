# structural-operations.ced

```
module StructuralOperations.

import induction-for-church-nats. -- from language-overview/

{- automatically constructing the motive for dependent eliminations.

   This can be done with θ<x1 ... xk>.  If the type we are checking the
   θ subterm against is T, then the θ expression will build the type
   λ x1 : X1. ... λ xk : Xk. T as the motive to apply to its
   (the θ-expression's) argument, where the variables x1 ... xk are in
   scope with types X1 , ...,  Xk respectively. 

   This is demonstrated in this addId proof, where we avoid writing
   down the motive for the inductionNat n subterm explicitly, and
   instead use θ to build it and apply inductionNat n to it
   automatically.

   If you select the entire body of the lambda (from θ to β below),
   you will see the computed motive. -}
addId ◂ Π n : Nat. {add n zero ≃ n} =
  λ n. θ<n> (inductionNat n) (Λ n. λ ih. ρ+ ih - β) β.
```

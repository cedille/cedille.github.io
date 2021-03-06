# type-inference.ced

```
module TypeInference.

Unit ◂ ★ = ∀ X : ★ . X ➔ X .
id ◂ Unit = Λ X . λ x . x .

Bot ◂ ★ = ∀ X: ★. X .

Bool ◂ ★ = ∀ X : ★ . X ➔ X ➔ X.
tt ◂ Bool = Λ X . λ t . λ f . t .
ff ◂ Bool = Λ X . λ t . λ f . f .
not ◂ Bool ➔ Bool = λ b . Λ X . λ t . λ f . b · X f t.

test1 = id id.

{- in Cedille navigation mode (Meta-s), select a span like the id id one
   by typing "p" twice with your cursor on the first id, and then hit
   "m" to see the meta-variables buffer.  Here, the types Unit and Bool
   just have a single type variables which gets solved immediately
   when the head of the locale is applied to its argument. -}
test2 = id id not tt .

Pair ◂ ★ ➔ ★ ➔ ★ = λ A : ★ . λ B : ★ . ∀ X : ★ . (A ➔ B ➔ X) ➔ X.
mkpair ◂ ∀ A : ★ . ∀ B : ★ . A ➔ B ➔ Pair · A · B =
  Λ A . Λ B . λ a . λ b . Λ X . λ c . c a b.

{- in the meta-vars buffer for mkpair not tt, you will see the notation

   ?A : ★ ◂ Bool ➔ Bool

   indicating (by the left triangle) that meta-variable A has been filled
   in from contextual type information (namely, the type we are declaring
   test3 to have. -}
test3 ◂ Pair · (Bool ➔ Bool) · Bool = mkpair not tt.

{- in general, the meta-vars buffer helps you know the following:
   - what meta-variables are in scope for the selected spine
   - where these meta-variables were introduced

     in the meta-vars buffer, press 'f' and 'b' to select a meta-var like
     ?X, then 'j' to jump to its introduction site.

     In `test3` this should take you to the span `mkpair not`

   - whether the meta-var was solved using contextual (indicated by "◂") or synthetic ("=")
     type information

     `contextual` means the expected (contextual) type of the entire application
     `synthetic` means the (synthesized) types of the term arguments

   - the application for which the meta-var first appeared in the expected type
     of a term

     'f' and 'b' in the meta-vars buffer will also select the '=' and '◂'
     symbols, and pressing 'j' when these are selected takes you to the
     introduction site associated with the meta-variable.

     In `test3`, selecting the '=' for ?Y will bring you to the span for `mkpair
     not tt`, indicating that the application of `mkpair not` to `tt` resulted
     in solving ?Y to Bool through type *synthesis* of the argument `tt`
-}

{- in test4, select the spine `const tt id` and bring up the meta-vars buffer.
   You can then confirm by navigation and jumping within it that ?X was
   introduced and solved at `const tt`, and ?Y was introduced at `const tt` and
   solved at `const tt id`
-}

const ◂ ∀ X: ★. ∀ Y: ★. X ➔ Y ➔ X
  = Λ X. Λ Y. λ x. λ y. x .

test4 ◂ Bool = const tt id .

{- Annotation requirements

   It is easy to describe where type annotations are required in Cedille for
   λ-abstractions and (first-order) type arguments:

   1. on the bound variables of λ-abstractions when this is not fully known
      contextually

      In an application spine, there are three sources of contextual
      information:

      1. the contextual type of the application
      2. the type of the spine head
      3. the information from preceding arguments
-}

test5-fail ◂ Bool = const tt (λ x. x) .
test5      ◂ Bool = const tt (λ x: Bool. x) .

{-    Here these three sources do not provide enough info to check the argument
      (λ x. x) of the head `const` so an annotation (or type argument
      instantiating ?Y) is required.

   2. as type arguments to polymorphic functions when this is needed to reveal a
      type quantifier or arrow
-}

test6-fail ◂ Bot ➔ Bool = λ bot. bot tt .
test6      ◂ Bot ➔ Bool = λ bot. bot ·Unit tt .

{-    in `test6-fail` the type of the head does not have an arrow in it, so we
      need to give a type argument to reveal the application. This is an
      intentional design choice -- Cedille will only generate meta-variables
      corresponding directly (injectively) to quantified type variables

   3. as type arguments within "maximal applications" to make sure all
      meta-variables are solved

      A maximal application is one with no more term arguments given.
      Type inference is local to the application "spine", meaning unsolved
      meta-variables are never propagated out of a maximal application.
-}

test7-fail ◂ (∀ X: ★. ∀ Y: ★. Y ➔ Y) ➔ Bool
  = λ f. f tt .

test7 ◂ (∀ X: ★. ∀ Y: ★. Y ➔ Y) ➔ Bool
  = λ f. f ·Unit tt .

test8-fail = mkpair tt .

test8 = Λ Y: ★. mkpair ·Bool ·Y tt .

{-    select span `f tt` of test7-fail and bring up the meta-vars buffer to see
      that ?X is unsolved. In test7, it is explicitly instantiated.

      This does also mean that in some cases currying is less convenient
      (see `test8-fail` and `test8`). This will be addressed in future versions
      Cedille's type inference.
-}

{- Higher-order type arguments:

   The approach to inference for higher-order type arguments is rather
   heuristic, and in general you will have to provide these explicitly for the
   time being.
   Again, this will be improved upon in the next version of the type inference algorithm.
-}

```

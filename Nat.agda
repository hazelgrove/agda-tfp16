open import Prelude

module Nat where
  data Nat : Set where
    Z : Nat
    1+ : Nat → Nat

  {-# BUILTIN NATURAL Nat #-}

  -- the succ operation is injective
  1+inj : (x y : Nat) → (1+ x == 1+ y) → x == y
  1+inj Z .0 refl = refl
  1+inj (1+ x) .(1+ x) refl = refl

  -- equality of naturals is decidable. we represent this as computing a
  -- choice of units, with inl <> meaning that the naturals are indeed the
  -- same and inr <> that they are not.
  natEQ : (x y : Nat) → ((x == y) + ((x == y) → ⊥))
  natEQ Z Z = Inl refl
  natEQ Z (1+ y) = Inr (λ ())
  natEQ (1+ x) Z = Inr (λ ())
  natEQ (1+ x) (1+ y) with natEQ x y
  natEQ (1+ x) (1+ .x) | Inl refl = Inl refl
  ... | Inr b = Inr (λ x₁ → b (1+inj x y x₁))

  max : Nat → Nat → Nat
  max Z m = m
  max n Z = n
  max (1+ n) (1+ m) = max n m

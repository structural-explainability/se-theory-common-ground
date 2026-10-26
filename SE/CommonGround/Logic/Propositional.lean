/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

public import SE.Logic.Language.Basic

/-!
# Propositional Formulas

A concrete propositional object language over an arbitrary type of atoms.

The Common Ground library keeps its object language abstract. The Common
Ground results need a concrete language so that joint consistency of theories
over disjoint vocabularies can be proved and not assumed.

Connectives: atoms, the contradiction `bot`, negation `neg`, and conjunction
`conj`. Other connectives are added when an example needs them.

This module gives syntax only. Meaning is given in
`SE.CommonGround.Logic.Semantics`.
-/

set_option autoImplicit false

namespace SE.CommonGround.Logic

open SE.Logic.Language

universe u

@[expose] public section

-- RR.DEFINES: SE.CommonGround.Logic.Formula
/--
Propositional formulas over the atoms `Atom`.
-/
inductive Formula (Atom : Type u) : Type u where
  /-- An atomic proposition. -/
  | atom : Atom → Formula Atom
  /-- The contradiction. -/
  | bot : Formula Atom
  /-- Negation. -/
  | neg : Formula Atom → Formula Atom
  /-- Conjunction. -/
  | conj : Formula Atom → Formula Atom → Formula Atom

-- RR.DEFINES: SE.CommonGround.Logic.language
/--
The Common Ground `PropositionalLanguage` whose propositions are the
formulas over `Atom`, whose negation is `Formula.neg`, and whose
contradiction is `Formula.bot`.
-/
def language (Atom : Type u) : PropositionalLanguage.{u} where
  carrier := { Proposition := Formula Atom }
  negation := { neg := Formula.neg }
  contradiction := { bottom := Formula.bot }

-- RR.DEFINES: SE.CommonGround.Logic.language_neg
/--
Negation in `language Atom` is `Formula.neg`.
-/
theorem language_neg {Atom : Type u} (p : Formula Atom) :
    (language Atom).neg p = Formula.neg p :=
  rfl

-- RR.DEFINES: SE.CommonGround.Logic.language_bottom
/--
The contradiction of `language Atom` is `Formula.bot`.
-/
theorem language_bottom {Atom : Type u} :
    (language Atom).bottom = Formula.bot :=
  rfl

end

end SE.CommonGround.Logic

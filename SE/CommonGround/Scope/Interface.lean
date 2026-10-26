/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

public import SE.CommonGround.Logic.Vocabulary

/-!
# Interface of a Framework on a Vocabulary

The interface of a framework `F` on a vocabulary `V` is the set of valuations
of `V` that `F` permits: those that extend to a model of `F`.

`satisfiable_union_iff_permits` reduces compatibility of a theory over `V` with
`F` to a question about this interface alone.

`valuationDiagram V u` is the theory over `V` that says exactly what the
valuation `u` says about the atoms of `V`.
-/

set_option autoImplicit false

namespace SE.CommonGround.Scope

open SE.CommonGround.Logic

universe u

@[expose] public section

variable {Atom : Type u}

-- RR.DEFINES: SE.CommonGround.Scope.Permits
/--
`F` permits `u` on `V` when some model of `F` agrees with `u` on `V`.
-/
def Permits
    (V : Vocabulary Atom)
    (F : MathlibMini.Set (Formula Atom))
    (u : Valuation Atom) :
    Prop :=
  ∃ w : Valuation Atom,
    Satisfies w F ∧ ∀ a : Atom, a ∈ V → (w a ↔ u a)

-- RR.DEFINES: SE.CommonGround.Scope.satisfiable_union_iff_permits
/--
A theory `R` over `V` is jointly satisfiable with `F` exactly when `F` permits
some valuation that satisfies `R`.
-/
theorem satisfiable_union_iff_permits
    {V : Vocabulary Atom}
    {R F : MathlibMini.Set (Formula Atom)}
    (hR : TheoryIn V R) :
    (∃ w : Valuation Atom, Satisfies w (R ∪ F)) ↔
      ∃ u : Valuation Atom, Satisfies u R ∧ Permits V F u := by
  constructor
  · rintro ⟨w, hw⟩
    have hw' := satisfies_union_iff.mp hw
    exact ⟨w, hw'.1, w, hw'.2, fun a _ => Iff.rfl⟩
  · rintro ⟨u, huR, w, hwF, hagree⟩
    have hwR : Satisfies w R :=
      (satisfies_congr (fun a ha => (hagree a ha).symm) hR).mp huR
    exact ⟨w, satisfies_union_iff.mpr ⟨hwR, hwF⟩⟩

-- RR.DEFINES: SE.CommonGround.Scope.valuationDiagram
/--
The theory over `V` consisting of `atom a` for each `a` in `V` that `u` makes
true and `neg (atom a)` for each `a` in `V` that `u` makes false.
-/
def valuationDiagram
    (V : Vocabulary Atom)
    (u : Valuation Atom) :
    MathlibMini.Set (Formula Atom) :=
  MathlibMini.Set.ofPredicate fun f =>
    (∃ a : Atom, a ∈ V ∧ u a ∧ f = Formula.atom a) ∨
    (∃ a : Atom, a ∈ V ∧ ¬ u a ∧ f = Formula.neg (Formula.atom a))

-- RR.DEFINES: SE.CommonGround.Scope.valuationDiagram_in_vocabulary
/--
The diagram of `u` on `V` lies in `V`.
-/
theorem valuationDiagram_in_vocabulary
    {V : Vocabulary Atom} {u : Valuation Atom} :
    TheoryIn V (valuationDiagram V u) := by
  intro f hf
  rcases MathlibMini.Set.mem_ofPredicate_iff.mp hf with
    ⟨a, ha, _, rfl⟩ | ⟨a, ha, _, rfl⟩
  · exact ha
  · exact ha

-- RR.DEFINES: SE.CommonGround.Scope.satisfies_valuationDiagram
/--
The valuation `u` satisfies its own diagram.
-/
theorem satisfies_valuationDiagram
    {V : Vocabulary Atom} {u : Valuation Atom} :
    Satisfies u (valuationDiagram V u) := by
  intro f hf
  rcases MathlibMini.Set.mem_ofPredicate_iff.mp hf with
    ⟨a, _, hua, rfl⟩ | ⟨a, _, hna, rfl⟩
  · exact hua
  · exact hna

end

end SE.CommonGround.Scope

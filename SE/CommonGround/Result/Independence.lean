/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

public import SE.NeutralSubstrate.FrameworkRelative.CompatibleCommitmentSet
public import SE.CommonGround.Logic.Consequence
public import SE.CommonGround.Fragment.Basic

/-!
# Independence of Common Ground from Admissibility

Admissibility alone does not give common ground for a nontrivial fragment.

`bareFrameworkSystem` counts every non-logical admissibility condition as
satisfied, so a framework is admissible exactly when it is satisfiable. In that
system a commitment set is framework-compatible exactly when it is valid. Any
nontrivial referential fragment therefore fails framework compatibility.
-/

set_option autoImplicit false

namespace SE.CommonGround.Result

open SE.Framework
open SE.Logic
open SE.Logic.Language
open SE.Logic.Theory
open SE.NeutralSubstrate.FrameworkRelative
open SE.CommonGround.Logic
open SE.CommonGround.Fragment

universe u

@[expose] public section

-- RR.DEFINES: SE.CommonGround.Result.bareFrameworkSystem
/--
The framework system whose carrier is the theories themselves and in which
every non-logical admissibility condition holds.
-/
def bareFrameworkSystem (Atom : Type u) :
    FrameworkSystem.{u, u} (language Atom).carrier where
  Carrier := MathlibMini.Set (Formula Atom)
  commitments F := F
  evidentiallyGrounded _ := True
  presentedAsInterpretiveFunction _ := True
  hasNamedSource _ := True
  hasDocumentedScope _ := True
  hasCitableBasis _ := True

-- RR.DEFINES: SE.CommonGround.Result.admissible_bare_iff
/--
In the bare framework system, a framework is admissible exactly when it is
satisfiable.
-/
theorem admissible_bare_iff
    {Atom : Type u} {F : MathlibMini.Set (Formula Atom)} :
    AdmissibleFramework
        (semanticConsequenceSystem Atom)
        (bareFrameworkSystem Atom)
        F ↔
      ∃ w : Valuation Atom, Satisfies w F := by
  constructor
  · intro h
    exact consistent_iff_satisfiable.mp (admissibleFramework_iff.mp h).1
  · intro h
    exact admissibleFramework_iff.mpr
      ⟨consistent_iff_satisfiable.mpr h,
       trivial,
       documentedInterpretiveFunction_iff.mpr ⟨trivial, trivial, trivial, trivial⟩⟩

-- RR.DEFINES: SE.CommonGround.Result.satisfies_combine_iff
/--
A valuation satisfies a combined theory exactly when it satisfies both parts.
-/
theorem satisfies_combine_iff
    {Atom : Type u} {w : Valuation Atom}
    {T U : CommitmentTheory (language Atom).carrier} :
    Satisfies w (combine T U) ↔ Satisfies w T ∧ Satisfies w U := by
  constructor
  · intro h
    exact
      ⟨fun f hf => h f (mem_combine_iff.mpr (Or.inl hf)),
       fun f hf => h f (mem_combine_iff.mpr (Or.inr hf))⟩
  · intro h f hf
    rcases mem_combine_iff.mp hf with hT | hU
    · exact h.1 f hT
    · exact h.2 f hU

-- RR.DEFINES: SE.CommonGround.Result.compatible_bare_iff_valid
/--
In the bare framework system, a commitment set is framework-compatible exactly
when every valuation satisfies it.
-/
theorem compatible_bare_iff_valid
    {Atom : Type u} {T : CommitmentTheory (language Atom).carrier} :
    FrameworkCompatibleCommitmentSet
        (semanticConsequenceSystem Atom)
        (bareFrameworkSystem Atom)
        T ↔
      ∀ v : Valuation Atom, Satisfies v T := by
  constructor
  · intro hcompat v
    apply Classical.byContradiction
    intro hv
    have hex : ∃ f : Formula Atom, f ∈ T ∧ ¬ eval v f := by
      apply Classical.byContradiction
      intro hno
      apply hv
      intro f hf
      apply Classical.byContradiction
      intro hnf
      exact hno ⟨f, hf, hnf⟩
    obtain ⟨f, hfT, hnf⟩ := hex
    have hsat :
        ∃ w : Valuation Atom,
          Satisfies w ({Formula.neg f} : MathlibMini.Set (Formula Atom)) := by
      refine ⟨v, ?_⟩
      intro g hg
      have hgf : g = Formula.neg f := MathlibMini.Set.mem_singleton_iff.mp hg
      subst hgf
      exact hnf
    have hadmissible :
        AdmissibleFramework
          (semanticConsequenceSystem Atom)
          (bareFrameworkSystem Atom)
          ({Formula.neg f} : MathlibMini.Set (Formula Atom)) :=
      admissible_bare_iff.mpr hsat
    have hconsistent :=
      (frameworkCompatibleCommitmentSet_iff.mp hcompat)
        ({Formula.neg f} : MathlibMini.Set (Formula Atom))
        (mem_frameworkClass_iff.mpr hadmissible)
    obtain ⟨w, hw⟩ := consistent_iff_satisfiable.mp hconsistent
    have hw' := satisfies_combine_iff.mp hw
    have hmem :
        Formula.neg f ∈ ({Formula.neg f} : MathlibMini.Set (Formula Atom)) :=
      MathlibMini.Set.mem_singleton_iff.mpr rfl
    exact hw'.2 (Formula.neg f) hmem (hw'.1 f hfT)
  · intro hvalid
    apply frameworkCompatibleCommitmentSet_iff.mpr
    intro F hF
    obtain ⟨w, hw⟩ := admissible_bare_iff.mp (mem_frameworkClass_iff.mp hF)
    apply consistent_iff_satisfiable.mpr
    exact ⟨w, satisfies_combine_iff.mpr ⟨hvalid w, hw⟩⟩

-- RR.DEFINES: SE.CommonGround.Result.not_compatible_bare_of_nontrivial
/--
A nontrivial referential fragment is not framework-compatible when
admissibility is the only condition on frameworks.
-/
theorem not_compatible_bare_of_nontrivial
    {Atom : Type u} (P : ReferentialFragment Atom) :
    ¬ FrameworkCompatibleCommitmentSet
        (semanticConsequenceSystem Atom)
        (bareFrameworkSystem Atom)
        P.commitments := by
  intro hcompat
  obtain ⟨v, hv⟩ := P.nontrivial
  exact hv (compatible_bare_iff_valid.mp hcompat v)

end

end SE.CommonGround.Result

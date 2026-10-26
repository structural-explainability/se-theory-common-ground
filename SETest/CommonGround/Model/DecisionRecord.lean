/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

import SE.CommonGround

/-!
# Decision Record Model

A concrete model. The fragment says a decision was made and that it occurred at
the recorded time. A causal framework avoids the fragment's vocabulary. A
re-dating framework denies the recorded time.

Checks that:

- the fragment is a valid `ReferentialFragment`;
- the causal framework is neutral on the fragment's vocabulary and jointly
  satisfiable with the fragment, by both routes;
- the re-dating framework is satisfiable, conflicts with the fragment, and is
  therefore not neutral;
- the conflicting framework is admissible when admissibility is the only
  condition, so admissibility alone does not give framework compatibility.
-/

set_option autoImplicit false

namespace SETest.CommonGround.Model.DecisionRecord

open SE.CommonGround.Logic
open SE.CommonGround.Fragment
open SE.CommonGround.Scope
open SE.CommonGround.Result

inductive Atom where
  | decisionMade
  | occurredAt
  | causedByScore
  | justifiedByPolicy

def fragmentVocabulary : Vocabulary Atom :=
  MathlibMini.Set.ofPredicate fun a =>
    match a with
    | Atom.decisionMade => True
    | Atom.occurredAt => True
    | Atom.causedByScore => False
    | Atom.justifiedByPolicy => False

def frameworkVocabulary : Vocabulary Atom :=
  MathlibMini.Set.ofPredicate fun a =>
    match a with
    | Atom.decisionMade => False
    | Atom.occurredAt => False
    | Atom.causedByScore => True
    | Atom.justifiedByPolicy => True

def referentialCommitments : MathlibMini.Set (Formula Atom) :=
  MathlibMini.Set.ofPredicate fun f =>
    f = Formula.atom Atom.decisionMade ∨ f = Formula.atom Atom.occurredAt

def causalFramework : MathlibMini.Set (Formula Atom) :=
  {Formula.atom Atom.causedByScore}

def redatingFramework : MathlibMini.Set (Formula Atom) :=
  {Formula.neg (Formula.atom Atom.occurredAt)}

def allTrue : Valuation Atom := fun _ => True

def allFalse : Valuation Atom := fun _ => False

theorem decisionMade_mem : Atom.decisionMade ∈ fragmentVocabulary :=
  MathlibMini.Set.mem_ofPredicate_iff.mpr trivial

theorem occurredAt_mem : Atom.occurredAt ∈ fragmentVocabulary :=
  MathlibMini.Set.mem_ofPredicate_iff.mpr trivial

theorem causedByScore_mem : Atom.causedByScore ∈ frameworkVocabulary :=
  MathlibMini.Set.mem_ofPredicate_iff.mpr trivial

theorem vocabularies_disjoint :
    VocabularyDisjoint fragmentVocabulary frameworkVocabulary := by
  intro a hV hW
  cases a
  · have h : False := MathlibMini.Set.mem_ofPredicate_iff.mp hW
    exact h.elim
  · have h : False := MathlibMini.Set.mem_ofPredicate_iff.mp hW
    exact h.elim
  · have h : False := MathlibMini.Set.mem_ofPredicate_iff.mp hV
    exact h.elim
  · have h : False := MathlibMini.Set.mem_ofPredicate_iff.mp hV
    exact h.elim

theorem commitments_in_vocabulary :
    TheoryIn fragmentVocabulary referentialCommitments := by
  intro f hf
  rcases MathlibMini.Set.mem_ofPredicate_iff.mp hf with rfl | rfl
  · exact decisionMade_mem
  · exact occurredAt_mem

theorem allTrue_satisfies_commitments :
    Satisfies allTrue referentialCommitments := by
  intro f hf
  rcases MathlibMini.Set.mem_ofPredicate_iff.mp hf with rfl | rfl
  · exact trivial
  · exact trivial

theorem allFalse_violates_commitments :
    ¬ Satisfies allFalse referentialCommitments := by
  intro h
  have hmem : Formula.atom Atom.decisionMade ∈ referentialCommitments :=
    MathlibMini.Set.mem_ofPredicate_iff.mpr (Or.inl rfl)
  exact h (Formula.atom Atom.decisionMade) hmem

def toyFragment : ReferentialFragment Atom where
  vocabulary := fragmentVocabulary
  commitments := referentialCommitments
  commitments_in_vocabulary := commitments_in_vocabulary
  satisfiable := ⟨allTrue, allTrue_satisfies_commitments⟩
  nontrivial := ⟨allFalse, allFalse_violates_commitments⟩
  bounded := by
    refine ⟨[Atom.decisionMade, Atom.occurredAt], ?_⟩
    intro a ha
    cases a
    · simp
    · simp
    · have h : False := MathlibMini.Set.mem_ofPredicate_iff.mp ha
      exact h.elim
    · have h : False := MathlibMini.Set.mem_ofPredicate_iff.mp ha
      exact h.elim

theorem causalFramework_in_vocabulary :
    TheoryIn frameworkVocabulary causalFramework := by
  intro f hf
  have hfe : f = Formula.atom Atom.causedByScore :=
    MathlibMini.Set.mem_singleton_iff.mp hf
  subst hfe
  exact causedByScore_mem

theorem causalFramework_satisfiable :
    ∃ w : Valuation Atom, Satisfies w causalFramework := by
  refine ⟨allTrue, ?_⟩
  intro f hf
  have hfe : f = Formula.atom Atom.causedByScore :=
    MathlibMini.Set.mem_singleton_iff.mp hf
  subst hfe
  exact trivial

theorem causalFramework_avoids :
    AvoidsVocabulary fragmentVocabulary causalFramework :=
  ⟨frameworkVocabulary, causalFramework_in_vocabulary, vocabularies_disjoint⟩

theorem causalFramework_neutral :
    NeutralOn fragmentVocabulary causalFramework :=
  neutralOn_of_avoids causalFramework_avoids causalFramework_satisfiable

theorem fragment_compatible_with_causal_by_neutrality :
    ∃ w : Valuation Atom,
      Satisfies w (toyFragment.commitments ∪ causalFramework) :=
  neutralOn_iff_compatible.mp causalFramework_neutral
    toyFragment.commitments
    toyFragment.commitments_in_vocabulary
    toyFragment.satisfiable

theorem fragment_compatible_with_causal_by_disjointness :
    ∃ w : Valuation Atom,
      Satisfies w (referentialCommitments ∪ causalFramework) :=
  satisfiable_union_of_disjoint
    vocabularies_disjoint
    commitments_in_vocabulary
    causalFramework_in_vocabulary
    ⟨allTrue, allTrue_satisfies_commitments⟩
    causalFramework_satisfiable

theorem redatingFramework_satisfiable :
    ∃ w : Valuation Atom, Satisfies w redatingFramework := by
  refine ⟨allFalse, ?_⟩
  intro f hf
  have hfe : f = Formula.neg (Formula.atom Atom.occurredAt) :=
    MathlibMini.Set.mem_singleton_iff.mp hf
  subst hfe
  intro h
  exact h

theorem redatingFramework_conflicts :
    ¬ ∃ w : Valuation Atom,
      Satisfies w (referentialCommitments ∪ redatingFramework) := by
  rintro ⟨w, hw⟩
  have hw' := satisfies_union_iff.mp hw
  have hocc : Formula.atom Atom.occurredAt ∈ referentialCommitments :=
    MathlibMini.Set.mem_ofPredicate_iff.mpr (Or.inr rfl)
  have hneg :
      Formula.neg (Formula.atom Atom.occurredAt) ∈ redatingFramework :=
    MathlibMini.Set.mem_singleton_iff.mpr rfl
  exact hw'.2 (Formula.neg (Formula.atom Atom.occurredAt)) hneg
    (hw'.1 (Formula.atom Atom.occurredAt) hocc)

theorem redatingFramework_not_neutral :
    ¬ NeutralOn fragmentVocabulary redatingFramework := by
  intro hneutral
  exact redatingFramework_conflicts
    (neutralOn_iff_compatible.mp hneutral
      toyFragment.commitments
      toyFragment.commitments_in_vocabulary
      toyFragment.satisfiable)

theorem redatingFramework_admissible_in_bare_system :
    SE.Framework.AdmissibleFramework
      (semanticConsequenceSystem Atom)
      (bareFrameworkSystem Atom)
      redatingFramework :=
  admissible_bare_iff.mpr redatingFramework_satisfiable

theorem toyFragment_not_compatible_in_bare_system :
    ¬ SE.NeutralSubstrate.FrameworkRelative.FrameworkCompatibleCommitmentSet
        (semanticConsequenceSystem Atom)
        (bareFrameworkSystem Atom)
        toyFragment.commitments :=
  not_compatible_bare_of_nontrivial toyFragment

#check dichotomy fragmentVocabulary redatingFramework

end SETest.CommonGround.Model.DecisionRecord

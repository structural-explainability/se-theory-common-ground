module

public import SE.CommonGround.Logic.JointConsistency
public import SE.CommonGround.Scope.Interface

/-!
# Scope Condition on Frameworks

`NeutralOn V F` says the framework `F` permits every valuation of the
vocabulary `V`. It mentions only `V` and `F`. It does not mention any
fragment's commitments, so it is characterized independently of compatibility
with them.

Two facts relate it to compatibility.

- `neutralOn_iff_compatible`: `F` is neutral on `V` exactly when `F` is
  compatible with every satisfiable theory over `V`. No weaker condition on `F`
  alone gives compatibility for every fragment over `V`. For one fixed
  fragment, weaker conditions can suffice, as
  `satisfiable_union_iff_permits` shows.
- `neutralOn_of_avoids`: a framework written entirely in a vocabulary disjoint
  from `V` is neutral on `V`, provided it is satisfiable. Disjointness can be
  checked by reading the framework.
-/

set_option autoImplicit false

namespace SE.CommonGround.Scope

open SE.CommonGround.Logic

universe u

@[expose] public section

variable {Atom : Type u}

-- RR.DEFINES: SE.CommonGround.Scope.NeutralOn
/--
`F` is neutral on `V` when it permits every valuation of `V`.
-/
def NeutralOn
    (V : Vocabulary Atom)
    (F : MathlibMini.Set (Formula Atom)) :
    Prop :=
  ∀ u : Valuation Atom, Permits V F u

-- RR.DEFINES: SE.CommonGround.Scope.AvoidsVocabulary
/--
`F` avoids `V` when `F` lies entirely in some vocabulary disjoint from `V`.
-/
def AvoidsVocabulary
    (V : Vocabulary Atom)
    (F : MathlibMini.Set (Formula Atom)) :
    Prop :=
  ∃ W : Vocabulary Atom, TheoryIn W F ∧ VocabularyDisjoint V W

-- RR.DEFINES: SE.CommonGround.Scope.neutralOn_of_avoids
/--
A satisfiable framework that avoids `V` is neutral on `V`.
-/
theorem neutralOn_of_avoids
    {V : Vocabulary Atom} {F : MathlibMini.Set (Formula Atom)}
    (havoids : AvoidsVocabulary V F)
    (hsat : ∃ w : Valuation Atom, Satisfies w F) :
    NeutralOn V F := by
  obtain ⟨W, hW, hdisjoint⟩ := havoids
  obtain ⟨w₂, hw₂⟩ := hsat
  intro u
  refine ⟨splice V u w₂, ?_, fun a ha => splice_iff_of_mem ha⟩
  have hagree : ∀ a : Atom, a ∈ W → (w₂ a ↔ splice V u w₂ a) := by
    intro a ha
    have hna : ¬ a ∈ V := fun hv => hdisjoint a hv ha
    exact (splice_iff_of_not_mem hna).symm
  exact (satisfies_congr hagree hW).mp hw₂

-- RR.DEFINES: SE.CommonGround.Scope.neutralOn_iff_compatible
/--
`F` is neutral on `V` exactly when `F` is jointly satisfiable with every
satisfiable theory over `V`.
-/
theorem neutralOn_iff_compatible
    {V : Vocabulary Atom} {F : MathlibMini.Set (Formula Atom)} :
    NeutralOn V F ↔
      ∀ R : MathlibMini.Set (Formula Atom),
        TheoryIn V R →
        (∃ v : Valuation Atom, Satisfies v R) →
        ∃ w : Valuation Atom, Satisfies w (R ∪ F) := by
  constructor
  · intro hneutral R hR hsat
    obtain ⟨u, huR⟩ := hsat
    exact (satisfiable_union_iff_permits hR).mpr ⟨u, huR, hneutral u⟩
  · intro hcompat u
    obtain ⟨w, hw⟩ :=
      hcompat (valuationDiagram V u)
        valuationDiagram_in_vocabulary
        ⟨u, satisfies_valuationDiagram⟩
    have hw' := satisfies_union_iff.mp hw
    refine ⟨w, hw'.2, fun a ha => ?_⟩
    constructor
    · intro hwa
      apply Classical.byContradiction
      intro hnu
      have hmem : Formula.neg (Formula.atom a) ∈ valuationDiagram V u :=
        MathlibMini.Set.mem_ofPredicate_iff.mpr (Or.inr ⟨a, ha, hnu, rfl⟩)
      exact hw'.1 _ hmem hwa
    · intro hua
      have hmem : Formula.atom a ∈ valuationDiagram V u :=
        MathlibMini.Set.mem_ofPredicate_iff.mpr (Or.inl ⟨a, ha, hua, rfl⟩)
      exact hw'.1 _ hmem

end

end SE.CommonGround.Scope

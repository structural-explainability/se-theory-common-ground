module

public import SE.Logic.Consistency
public import SE.CommonGround.Logic.Semantics

/-!
# Semantic Consequence System

Semantic consequence on `Formula` as an instance of the abstract
`SE.Logic.ConsequenceSystem` from Common Ground.

The three required properties hold:

- every member of a theory is entailed by it;
- generalized cut;
- a formula and its negation entail the contradiction.

Consistency in this instance coincides with satisfiability. That equivalence is
the bridge the later joint-consistency results use.
-/

set_option autoImplicit false

namespace SE.CommonGround.Logic

open SE.Logic
open SE.Logic.Language
open SE.Logic.Theory

universe u

@[expose] public section

-- RR.DEFINES: SE.CommonGround.Logic.semanticConsequenceSystem
/--
Semantic consequence over `Formula Atom`, as a Common Ground consequence
system for `language Atom`.
-/
def semanticConsequenceSystem (Atom : Type u) :
    ConsequenceSystem (language Atom) where
  entails T p := SemanticEntails T p
  entailsOfMem := by
    intro T p hp v hv
    exact hv p hp
  cut := by
    intro T U p hTU hUp v hv
    apply hUp
    intro q hq
    exact hTU q hq v hv
  contradiction := by
    intro T p hp hnp v hv
    have hpv : eval v p := hp v hv
    have hnpv : eval v (Formula.neg p) := hnp v hv
    exact hnpv hpv

-- RR.DEFINES: SE.CommonGround.Logic.consistent_iff_satisfiable
/--
In the semantic consequence system, a theory is consistent exactly when some
valuation satisfies it.
-/
theorem consistent_iff_satisfiable
    {Atom : Type u}
    {T : CommitmentTheory (language Atom).carrier} :
    Consistent (semanticConsequenceSystem Atom) T ↔
      ∃ v : Valuation Atom, Satisfies v T := by
  constructor
  · intro hcons
    apply Classical.byContradiction
    intro hno
    apply not_entailsBottom_of_consistent hcons
    intro v hv
    exact (hno ⟨v, hv⟩).elim
  · rintro ⟨v, hv⟩
    apply consistent_of_not_entailsBottom
    intro hent
    exact (eval_bot v).mp (hent v hv)

end

end SE.CommonGround.Logic

module

public import SE.CommonGround.Logic.Vocabulary

/-!
# Referential Fragment

A bounded referential fragment: a vocabulary and a theory over it.

Four conditions are required, so the result cannot be vacuous.

- The commitments lie in the vocabulary.
- The commitments are satisfiable.
- The commitments are nontrivial: some valuation violates them.
- The vocabulary is bounded: it lies inside a finite list of atoms.

This module says nothing about frameworks. Whether the commitments are
justified as referential, that is, the referential fixing semantics of the
fragment, is an obligation of the paper and of each realization. It is not
proved here.
-/

set_option autoImplicit false

namespace SE.CommonGround.Fragment

open SE.CommonGround.Logic

universe u

@[expose] public section

-- RR.DEFINES: SE.CommonGround.Fragment.ReferentialFragment
/--
A bounded, satisfiable, nontrivial theory over a vocabulary.
-/
structure ReferentialFragment (Atom : Type u) where
  /-- The vocabulary the fragment speaks about. -/
  vocabulary : Vocabulary Atom

  /-- The referential commitments of the fragment. -/
  commitments : MathlibMini.Set (Formula Atom)

  /-- Every commitment lies in the vocabulary. -/
  commitments_in_vocabulary : TheoryIn vocabulary commitments

  /-- Some valuation satisfies the commitments. -/
  satisfiable : ∃ v : Valuation Atom, Satisfies v commitments

  /-- Some valuation violates the commitments, so the fragment rules something out. -/
  nontrivial : ∃ v : Valuation Atom, ¬ Satisfies v commitments

  /-- The vocabulary lies inside a finite list of atoms. -/
  bounded : ∃ atoms : List Atom, ∀ a : Atom, a ∈ vocabulary → a ∈ atoms

end

end SE.CommonGround.Fragment

module

public import MathlibMini.Set
public import SE.CommonGround.Logic.Semantics

/-!
# Vocabulary

A vocabulary is a set of atoms.

A formula lies in a vocabulary when every atom occurring in it belongs to the
vocabulary. A theory lies in a vocabulary when all of its members do.

Valuations that agree on a vocabulary give every formula in that vocabulary the
same truth value (`eval_congr`). That is the only fact about vocabularies the
later results need from the semantics.
-/

set_option autoImplicit false

namespace SE.CommonGround.Logic

universe u

@[expose] public section

variable {Atom : Type u}

-- RR.DEFINES: SE.CommonGround.Logic.Vocabulary
/--
A vocabulary is a set of atoms.
-/
abbrev Vocabulary (Atom : Type u) : Type u :=
  MathlibMini.Set Atom

-- RR.DEFINES: SE.CommonGround.Logic.VocabularyDisjoint
/--
Two vocabularies are disjoint when no atom belongs to both.
-/
def VocabularyDisjoint (V W : Vocabulary Atom) : Prop :=
  ∀ a : Atom, a ∈ V → a ∈ W → False

-- RR.DEFINES: SE.CommonGround.Logic.FormulaIn
/--
A formula lies in a vocabulary when every atom occurring in it belongs to the
vocabulary.
-/
def FormulaIn (V : Vocabulary Atom) : Formula Atom → Prop
  | Formula.atom a => a ∈ V
  | Formula.bot => True
  | Formula.neg f => FormulaIn V f
  | Formula.conj f g => FormulaIn V f ∧ FormulaIn V g

-- RR.DEFINES: SE.CommonGround.Logic.TheoryIn
/--
A theory lies in a vocabulary when every member lies in the vocabulary.
-/
def TheoryIn
    (V : Vocabulary Atom)
    (T : MathlibMini.Set (Formula Atom)) :
    Prop :=
  ∀ f : Formula Atom, f ∈ T → FormulaIn V f

-- RR.DEFINES: SE.CommonGround.Logic.eval_congr
/--
Valuations that agree on a vocabulary agree on every formula in it.
-/
theorem eval_congr
    {V : Vocabulary Atom} {v w : Valuation Atom}
    (hagree : ∀ a : Atom, a ∈ V → (v a ↔ w a)) :
    ∀ f : Formula Atom, FormulaIn V f → (eval v f ↔ eval w f)
  | Formula.atom a, h => hagree a h
  | Formula.bot, _ => Iff.rfl
  | Formula.neg f, h => not_congr (eval_congr hagree f h)
  | Formula.conj f g, h =>
      and_congr (eval_congr hagree f h.1) (eval_congr hagree g h.2)

-- RR.DEFINES: SE.CommonGround.Logic.satisfies_congr
/--
Valuations that agree on a vocabulary satisfy the same theories over it.
-/
theorem satisfies_congr
    {V : Vocabulary Atom} {v w : Valuation Atom}
    (hagree : ∀ a : Atom, a ∈ V → (v a ↔ w a))
    {T : MathlibMini.Set (Formula Atom)}
    (hT : TheoryIn V T) :
    Satisfies v T ↔ Satisfies w T :=
  ⟨fun h f hf => (eval_congr hagree f (hT f hf)).mp (h f hf),
   fun h f hf => (eval_congr hagree f (hT f hf)).mpr (h f hf)⟩

end

end SE.CommonGround.Logic

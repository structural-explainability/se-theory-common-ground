module

public import MathlibMini.Set
public import SE.CommonGround.Logic.Propositional

/-!
# Classical Semantics

Truth, satisfaction and semantic consequence for `Formula`.

A valuation assigns a Lean proposition to each atom. `eval` extends a valuation
to all formulas. A theory is satisfied by a valuation when every member is true
under it. A theory semantically entails a formula when every valuation that
satisfies the theory makes the formula true.

This semantics is classical. It is stronger than the abstract consequence
system in Neutral Substrate requires, for example explosion holds. Results in
this repository that depend on classical features are therefore results about
this instance.
-/

set_option autoImplicit false

namespace SE.CommonGround.Logic

universe u

@[expose] public section

variable {Atom : Type u}

-- RR.DEFINES: SE.CommonGround.Logic.Valuation
/--
A valuation assigns a Lean proposition to each atom.
-/
abbrev Valuation (Atom : Type u) : Type u :=
  Atom → Prop

-- RR.DEFINES: SE.CommonGround.Logic.eval
/--
Truth of a formula under a valuation.
-/
def eval (v : Valuation Atom) : Formula Atom → Prop
  | Formula.atom a => v a
  | Formula.bot => False
  | Formula.neg f => ¬ eval v f
  | Formula.conj f g => eval v f ∧ eval v g

-- RR.DEFINES: SE.CommonGround.Logic.eval_atom
/-- An atom is true under a valuation exactly when the valuation makes it true. -/
theorem eval_atom (v : Valuation Atom) (a : Atom) :
    eval v (Formula.atom a) ↔ v a :=
  Iff.rfl

-- RR.DEFINES: SE.CommonGround.Logic.eval_bot
/-- The contradiction is false under any valuation. -/
theorem eval_bot (v : Valuation Atom) :
    eval v Formula.bot ↔ False :=
  Iff.rfl

-- RR.DEFINES: SE.CommonGround.Logic.eval_neg
/--
The negation of a formula is true under a valuation exactly when the formula
is false under it.
-/
theorem eval_neg (v : Valuation Atom) (f : Formula Atom) :
    eval v (Formula.neg f) ↔ ¬ eval v f :=
  Iff.rfl

-- RR.DEFINES: SE.CommonGround.Logic.eval_conj
/--
The conjunction of two formulas is true under a valuation exactly when both
formulas are true under it.
-/
theorem eval_conj (v : Valuation Atom) (f g : Formula Atom) :
    eval v (Formula.conj f g) ↔ eval v f ∧ eval v g :=
  Iff.rfl

-- RR.DEFINES: SE.CommonGround.Logic.Satisfies
/--
A valuation satisfies a theory when every member of the theory is true under it.
-/
def Satisfies
    (v : Valuation Atom)
    (T : MathlibMini.Set (Formula Atom)) :
    Prop :=
  ∀ f : Formula Atom, f ∈ T → eval v f

-- RR.DEFINES: SE.CommonGround.Logic.SemanticEntails
/--
A theory semantically entails a formula when every valuation satisfying the
theory makes the formula true.
-/
def SemanticEntails
    (T : MathlibMini.Set (Formula Atom))
    (f : Formula Atom) :
    Prop :=
  ∀ v : Valuation Atom, Satisfies v T → eval v f

-- RR.DEFINES: SE.CommonGround.Logic.satisfies_union_iff
/--
A valuation satisfies a union of theories exactly when it satisfies both.
-/
theorem satisfies_union_iff
    {v : Valuation Atom}
    {T U : MathlibMini.Set (Formula Atom)} :
    Satisfies v (T ∪ U) ↔ Satisfies v T ∧ Satisfies v U := by
  constructor
  · intro h
    exact
      ⟨fun f hf => h f (MathlibMini.Set.mem_union_iff.mpr (Or.inl hf)),
       fun f hf => h f (MathlibMini.Set.mem_union_iff.mpr (Or.inr hf))⟩
  · intro h f hf
    rcases MathlibMini.Set.mem_union_iff.mp hf with hT | hU
    · exact h.1 f hT
    · exact h.2 f hU

-- RR.DEFINES: SE.CommonGround.Logic.satisfies_mono
/--
Satisfying a larger theory implies satisfying any subset of it.
-/
theorem satisfies_mono
    {v : Valuation Atom}
    {T U : MathlibMini.Set (Formula Atom)}
    (hTU : T ⊆ U)
    (h : Satisfies v U) :
    Satisfies v T :=
  fun f hf => h f (hTU hf)

-- RR.DEFINES: SE.CommonGround.Logic.semanticEntails_bot_iff
/--
A theory semantically entails the contradiction exactly when no valuation
satisfies it.
-/
theorem semanticEntails_bot_iff
    {T : MathlibMini.Set (Formula Atom)} :
    SemanticEntails T Formula.bot ↔
      ∀ v : Valuation Atom, ¬ Satisfies v T := by
  constructor
  · intro h v hv
    exact (eval_bot v).mp (h v hv)
  · intro h v hv
    exact (eval_bot v).mpr (h v hv)

end

end SE.CommonGround.Logic

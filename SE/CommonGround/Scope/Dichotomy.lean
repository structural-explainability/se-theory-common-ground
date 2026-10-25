module

public import SE.CommonGround.Scope.InScope

/-!
# Scope Dichotomy

Every framework is either neutral on a vocabulary `V` or conflicts with some
satisfiable theory over `V`.

The second case is the exact witness that the scope condition fails. It names a
concrete satisfiable theory over `V` that the framework cannot coexist with.
Whether such a theory is the referential commitment set of a given fragment is
a question about that fragment, not something this module settles.
-/

set_option autoImplicit false

namespace SE.CommonGround.Scope

open SE.CommonGround.Logic

universe u

@[expose] public section

variable {Atom : Type u}

-- RR.DEFINES: SE.CommonGround.Scope.dichotomy
/--
Either `F` is neutral on `V`, or some satisfiable theory over `V` is not
jointly satisfiable with `F`.
-/
theorem dichotomy
    (V : Vocabulary Atom)
    (F : MathlibMini.Set (Formula Atom)) :
    NeutralOn V F ∨
      ∃ R : MathlibMini.Set (Formula Atom),
        TheoryIn V R ∧
        (∃ v : Valuation Atom, Satisfies v R) ∧
        ¬ ∃ w : Valuation Atom, Satisfies w (R ∪ F) := by
  rcases Classical.em (NeutralOn V F) with h | h
  · exact Or.inl h
  · right
    apply Classical.byContradiction
    intro hno
    apply h
    apply neutralOn_iff_compatible.mpr
    intro R hR hsat
    apply Classical.byContradiction
    intro hnsat
    exact hno ⟨R, hR, hsat, hnsat⟩

end

end SE.CommonGround.Scope

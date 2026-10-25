module

public import SE.CommonGround.Logic.Vocabulary

/-!
# Joint Consistency over Disjoint Vocabularies

If a theory over `V` and a theory over `W` are each satisfiable and `V` and `W`
are disjoint, their union is satisfiable.

Common Ground's consequence system is abstract and has no vocabularies, so
this property cannot be stated there. Here it is a theorem about the
propositional instance. The construction takes one valuation on `V` and the
other outside `V`.
-/

set_option autoImplicit false

namespace SE.CommonGround.Logic

universe u

@[expose] public section

variable {Atom : Type u}

-- RR.DEFINES: SE.CommonGround.Logic.splice
/--
The valuation that agrees with `v₁` on `V` and with `v₂` outside `V`.
-/
def splice
    (V : Vocabulary Atom)
    (v₁ v₂ : Valuation Atom) :
    Valuation Atom :=
  fun a => (a ∈ V ∧ v₁ a) ∨ (¬ a ∈ V ∧ v₂ a)

-- RR.DEFINES: SE.CommonGround.Logic.splice_iff_of_mem
/--
On `V`, the spliced valuation agrees with `v₁`.
-/
theorem splice_iff_of_mem
    {V : Vocabulary Atom} {v₁ v₂ : Valuation Atom} {a : Atom}
    (ha : a ∈ V) :
    splice V v₁ v₂ a ↔ v₁ a := by
  constructor
  · intro h
    rcases h with ⟨_, h⟩ | ⟨hna, _⟩
    · exact h
    · exact (hna ha).elim
  · intro h
    exact Or.inl ⟨ha, h⟩

-- RR.DEFINES: SE.CommonGround.Logic.splice_iff_of_not_mem
/--
Outside `V`, the spliced valuation agrees with `v₂`.
-/
theorem splice_iff_of_not_mem
    {V : Vocabulary Atom} {v₁ v₂ : Valuation Atom} {a : Atom}
    (ha : ¬ a ∈ V) :
    splice V v₁ v₂ a ↔ v₂ a := by
  constructor
  · intro h
    rcases h with ⟨hmem, _⟩ | ⟨_, h⟩
    · exact (ha hmem).elim
    · exact h
  · intro h
    exact Or.inr ⟨ha, h⟩

-- RR.DEFINES: SE.CommonGround.Logic.satisfiable_union_of_disjoint
/--
Satisfiable theories over disjoint vocabularies have a satisfiable union.
-/
theorem satisfiable_union_of_disjoint
    {V W : Vocabulary Atom}
    (hdisjoint : VocabularyDisjoint V W)
    {T U : MathlibMini.Set (Formula Atom)}
    (hT : TheoryIn V T)
    (hU : TheoryIn W U)
    (hTsat : ∃ v : Valuation Atom, Satisfies v T)
    (hUsat : ∃ v : Valuation Atom, Satisfies v U) :
    ∃ v : Valuation Atom, Satisfies v (T ∪ U) := by
  obtain ⟨v₁, h₁⟩ := hTsat
  obtain ⟨v₂, h₂⟩ := hUsat
  refine ⟨splice V v₁ v₂, satisfies_union_iff.mpr ⟨?_, ?_⟩⟩
  · have hagree : ∀ a : Atom, a ∈ V → (v₁ a ↔ splice V v₁ v₂ a) :=
      fun a ha => (splice_iff_of_mem ha).symm
    exact (satisfies_congr hagree hT).mp h₁
  · have hagree : ∀ a : Atom, a ∈ W → (v₂ a ↔ splice V v₁ v₂ a) := by
      intro a ha
      have hna : ¬ a ∈ V := fun hv => hdisjoint a hv ha
      exact (splice_iff_of_not_mem hna).symm
    exact (satisfies_congr hagree hU).mp h₂

end

end SE.CommonGround.Logic

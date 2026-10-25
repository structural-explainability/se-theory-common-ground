module

-- SE/CommonGround/Spec.lean
-- Canonical citation identifiers for the Common Ground theory.
-- Strings are stable across refactors; the identifier is the contract,
-- and the corresponding Lean declaration is the implementation.

@[expose] public section

namespace SE.CommonGround.Spec

/-- Paper item: referential fragment. -/
def se110DefReferentialFragment : String :=
  "se110.def.ReferentialFragment"

/-- Paper item: interface permission of a framework on a vocabulary. -/
def se110DefPermits : String :=
  "se110.def.Permits"

/-- Paper item: framework neutral on a vocabulary. -/
def se110DefNeutralOn : String :=
  "se110.def.NeutralOn"

/-- Paper item: framework avoiding a vocabulary. -/
def se110DefAvoidsVocabulary : String :=
  "se110.def.AvoidsVocabulary"

/-- Paper item: compatibility reduces to the framework's interface. -/
def se110PropositionSatisfiableUnionIffPermits : String :=
  "se110.proposition.SatisfiableUnionIffPermits"

/-- Paper item: neutrality is compatibility with every satisfiable theory. -/
def se110PropositionNeutralOnIffCompatible : String :=
  "se110.proposition.NeutralOnIffCompatible"

/-- Paper item: scope dichotomy. -/
def se110PropositionDichotomy : String :=
  "se110.proposition.Dichotomy"

/-- Paper item: admissibility alone gives compatibility only for valid theories. -/
def se110PropositionCompatibleBareIffValid : String :=
  "se110.proposition.CompatibleBareIffValid"

end SE.CommonGround.Spec

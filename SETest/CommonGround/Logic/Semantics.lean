module

import SE.CommonGround.Logic.Semantics

/-!
# Semantics Tests

Compile-time API tests for `SE.CommonGround.Logic.Semantics`.
-/

set_option autoImplicit false

namespace SETest.CommonGround.Logic.Semantics

#check SE.CommonGround.Logic.Valuation
#check SE.CommonGround.Logic.eval
#check SE.CommonGround.Logic.eval_atom
#check SE.CommonGround.Logic.eval_bot
#check SE.CommonGround.Logic.eval_neg
#check SE.CommonGround.Logic.eval_conj
#check SE.CommonGround.Logic.Satisfies
#check SE.CommonGround.Logic.SemanticEntails
#check SE.CommonGround.Logic.satisfies_union_iff
#check SE.CommonGround.Logic.satisfies_mono
#check SE.CommonGround.Logic.semanticEntails_bot_iff

end SETest.CommonGround.Logic.Semantics

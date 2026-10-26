/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

import SE.CommonGround.Logic.Vocabulary

/-!
# Vocabulary Tests

Compile-time API tests for `SE.CommonGround.Logic.Vocabulary`.
-/

set_option autoImplicit false

namespace SETest.CommonGround.Logic.Vocabulary

#check SE.CommonGround.Logic.Vocabulary
#check SE.CommonGround.Logic.VocabularyDisjoint
#check SE.CommonGround.Logic.FormulaIn
#check SE.CommonGround.Logic.TheoryIn
#check SE.CommonGround.Logic.eval_congr
#check SE.CommonGround.Logic.satisfies_congr

end SETest.CommonGround.Logic.Vocabulary

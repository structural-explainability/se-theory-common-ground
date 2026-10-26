/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

import SE.CommonGround.Logic.Consequence

/-!
# Semantic Consequence Tests

Compile-time API tests for `SE.CommonGround.Logic.Consequence`.
-/

set_option autoImplicit false

namespace SETest.CommonGround.Logic.Consequence

#check SE.CommonGround.Logic.semanticConsequenceSystem
#check SE.CommonGround.Logic.consistent_iff_satisfiable

end SETest.CommonGround.Logic.Consequence

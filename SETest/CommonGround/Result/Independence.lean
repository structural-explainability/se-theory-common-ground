/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

import SE.CommonGround.Result.Independence

/-!
# Independence Tests

Compile-time API tests for `SE.CommonGround.Result.Independence`.
-/

set_option autoImplicit false

namespace SETest.CommonGround.Result.Independence

#check SE.CommonGround.Result.bareFrameworkSystem
#check SE.CommonGround.Result.admissible_bare_iff
#check SE.CommonGround.Result.satisfies_combine_iff
#check SE.CommonGround.Result.compatible_bare_iff_valid
#check SE.CommonGround.Result.not_compatible_bare_of_nontrivial

end SETest.CommonGround.Result.Independence

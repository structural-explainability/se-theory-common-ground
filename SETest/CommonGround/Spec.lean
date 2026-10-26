/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

import SE.CommonGround.Spec

/-!
# Specification Identifier Tests

Compile-time tests for the stable Common Ground citation identifiers.
-/

set_option autoImplicit false

namespace SETest.CommonGround.Spec

#check SE.CommonGround.Spec.se110DefReferentialFragment
#check SE.CommonGround.Spec.se110DefPermits
#check SE.CommonGround.Spec.se110DefNeutralOn
#check SE.CommonGround.Spec.se110DefAvoidsVocabulary
#check SE.CommonGround.Spec.se110PropositionSatisfiableUnionIffPermits
#check SE.CommonGround.Spec.se110PropositionNeutralOnIffCompatible
#check SE.CommonGround.Spec.se110PropositionDichotomy
#check SE.CommonGround.Spec.se110PropositionCompatibleBareIffValid

end SETest.CommonGround.Spec

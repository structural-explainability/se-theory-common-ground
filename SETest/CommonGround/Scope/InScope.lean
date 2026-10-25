module

import SE.CommonGround.Scope.InScope

/-!
# Scope Condition Tests

Compile-time API tests for `SE.CommonGround.Scope.InScope`.
-/

set_option autoImplicit false

namespace SETest.CommonGround.Scope.InScope

#check SE.CommonGround.Scope.NeutralOn
#check SE.CommonGround.Scope.AvoidsVocabulary
#check SE.CommonGround.Scope.neutralOn_of_avoids
#check SE.CommonGround.Scope.neutralOn_iff_compatible

end SETest.CommonGround.Scope.InScope

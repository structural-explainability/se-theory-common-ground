module

import SE.CommonGround.Scope.Interface

/-!
# Interface Tests

Compile-time API tests for `SE.CommonGround.Scope.Interface`.
-/

set_option autoImplicit false

namespace SETest.CommonGround.Scope.Interface

#check SE.CommonGround.Scope.Permits
#check SE.CommonGround.Scope.satisfiable_union_iff_permits
#check SE.CommonGround.Scope.valuationDiagram
#check SE.CommonGround.Scope.valuationDiagram_in_vocabulary
#check SE.CommonGround.Scope.satisfies_valuationDiagram

end SETest.CommonGround.Scope.Interface

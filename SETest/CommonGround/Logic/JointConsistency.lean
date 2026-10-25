module

import SE.CommonGround.Logic.JointConsistency

/-!
# Joint Consistency Tests

Compile-time API tests for `SE.CommonGround.Logic.JointConsistency`.
-/

set_option autoImplicit false

namespace SETest.CommonGround.Logic.JointConsistency

#check SE.CommonGround.Logic.splice
#check SE.CommonGround.Logic.splice_iff_of_mem
#check SE.CommonGround.Logic.splice_iff_of_not_mem
#check SE.CommonGround.Logic.satisfiable_union_of_disjoint

end SETest.CommonGround.Logic.JointConsistency

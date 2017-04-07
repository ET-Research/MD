source "../../config/inList-0.1.0.tm"
source "../../config/listDiff-0.1.0.tm"
source "../../config/assertDictKeyLegal-0.1.0.tm"

::namd::assertDictKeyLegal {k1 1 k2 2} {k1 1} "expect true"
::namd::assertDictKeyLegal {k1 1 k2 2} {k3 1} "expect false"

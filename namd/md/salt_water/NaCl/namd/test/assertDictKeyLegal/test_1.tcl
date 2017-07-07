source module/tk/dict/assertDictKeyLegal-0.1.0.tm

::namd::tk::dict::assertDictKeyLegal {k1 1 k2 2} {k1 1} "expect true"
::namd::tk::dict::assertDictKeyLegal {k1 1 k2 2} {k3 1} "expect false"

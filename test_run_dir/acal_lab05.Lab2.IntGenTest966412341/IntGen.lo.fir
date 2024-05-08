circuit IntGen :
  module IntGen :
    input clock : Clock
    input reset : UInt<1>
    input io_key_in : UInt<4>
    output io_value_valid : UInt<1>
    output io_value_bits : UInt<32>

    node _T = eq(io_key_in, UInt<4>("hf")) @[IntGen.scala 13:24]
    reg state : UInt<2>, clock with :
      reset => (UInt<1>("h0"), state) @[IntGen.scala 16:24]
    node _T_1 = eq(UInt<2>("h0"), state) @[Conditional.scala 37:30]
    node _T_2 = eq(UInt<2>("h1"), state) @[Conditional.scala 37:30]
    node equal = _T
    node _GEN_0 = mux(equal, UInt<2>("h2"), state) @[IntGen.scala 23:21 IntGen.scala 23:28 IntGen.scala 16:24]
    node _T_3 = eq(UInt<2>("h2"), state) @[Conditional.scala 37:30]
    node _GEN_1 = mux(_T_3, UInt<2>("h1"), state) @[Conditional.scala 39:67 IntGen.scala 26:19 IntGen.scala 16:24]
    node _GEN_2 = mux(_T_2, _GEN_0, _GEN_1) @[Conditional.scala 39:67]
    node _GEN_3 = mux(_T_1, UInt<2>("h1"), _GEN_2) @[Conditional.scala 40:58 IntGen.scala 20:15]
    reg in_buffer : UInt<4>, clock with :
      reset => (UInt<1>("h0"), in_buffer) @[IntGen.scala 31:28]
    reg number : UInt<32>, clock with :
      reset => (UInt<1>("h0"), number) @[IntGen.scala 33:25]
    node _T_4 = eq(state, UInt<2>("h1")) @[IntGen.scala 34:16]
    node _T_5 = dshl(number, UInt<2>("h3")) @[IntGen.scala 37:26]
    node _T_6 = dshl(number, UInt<1>("h1")) @[IntGen.scala 37:42]
    node _T_7 = add(_T_5, _T_6) @[IntGen.scala 37:33]
    node _T_8 = tail(_T_7, 1) @[IntGen.scala 37:33]
    node _T_9 = add(_T_8, in_buffer) @[IntGen.scala 37:49]
    node _T_10 = tail(_T_9, 1) @[IntGen.scala 37:49]
    node _T_11 = eq(state, UInt<2>("h2")) @[IntGen.scala 38:22]
    node _GEN_4 = mux(_T_11, UInt<1>("h0"), io_key_in) @[IntGen.scala 38:33 IntGen.scala 41:19 IntGen.scala 31:28]
    node _GEN_5 = mux(_T_11, UInt<1>("h0"), number) @[IntGen.scala 38:33 IntGen.scala 42:16 IntGen.scala 33:25]
    node _GEN_6 = mux(_T_4, _T_10, _GEN_5) @[IntGen.scala 34:28 IntGen.scala 37:16]
    node _GEN_7 = mux(_T_4, io_key_in, _GEN_4) @[IntGen.scala 34:28 IntGen.scala 31:28]
    node _T_12 = eq(state, UInt<2>("h2")) @[IntGen.scala 45:33]
    node _T_13 = mux(_T_12, UInt<1>("h1"), UInt<1>("h0")) @[IntGen.scala 45:26]
    io_value_valid <= _T_13 @[IntGen.scala 45:20]
    io_value_bits <= number @[IntGen.scala 46:19]
    state <= mux(reset, UInt<2>("h0"), _GEN_3) @[IntGen.scala 16:24 IntGen.scala 16:24]
    in_buffer <= _GEN_7
    number <= mux(reset, UInt<32>("h0"), bits(_GEN_6, 31, 0)) @[IntGen.scala 33:25 IntGen.scala 33:25]

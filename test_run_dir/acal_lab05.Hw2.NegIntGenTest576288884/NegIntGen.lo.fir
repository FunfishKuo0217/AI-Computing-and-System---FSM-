circuit NegIntGen :
  module NegIntGen :
    input clock : Clock
    input reset : UInt<1>
    input io_key_in : UInt<4>
    output io_value_valid : UInt<1>
    output io_value_bits : UInt<32>

    node _T = eq(io_key_in, UInt<4>("hf")) @[NegIntGen.scala 14:24]
    reg state : UInt<2>, clock with :
      reset => (UInt<1>("h0"), state) @[NegIntGen.scala 18:24]
    node _T_1 = eq(UInt<2>("h0"), state) @[Conditional.scala 37:30]
    node _T_2 = eq(io_key_in, UInt<4>("hd")) @[NegIntGen.scala 22:28]
    node _GEN_0 = mux(_T_2, UInt<2>("h3"), UInt<2>("h1")) @[NegIntGen.scala 22:37 NegIntGen.scala 23:23 NegIntGen.scala 24:31]
    node _T_3 = eq(UInt<2>("h1"), state) @[Conditional.scala 37:30]
    node equal = _T
    node _GEN_1 = mux(equal, UInt<2>("h2"), state) @[NegIntGen.scala 26:33 NegIntGen.scala 26:40 NegIntGen.scala 18:24]
    node _T_4 = eq(UInt<2>("h3"), state) @[Conditional.scala 37:30]
    node _T_5 = eq(UInt<2>("h2"), state) @[Conditional.scala 37:30]
    node _GEN_2 = mux(_T_5, UInt<2>("h1"), state) @[Conditional.scala 39:67 NegIntGen.scala 29:19 NegIntGen.scala 18:24]
    node _GEN_3 = mux(_T_4, _GEN_1, _GEN_2) @[Conditional.scala 39:67]
    node _GEN_4 = mux(_T_3, _GEN_1, _GEN_3) @[Conditional.scala 39:67]
    node _GEN_5 = mux(_T_1, _GEN_0, _GEN_4) @[Conditional.scala 40:58]
    node _T_6 = eq(io_key_in, UInt<4>("hd")) @[NegIntGen.scala 32:20]
    node _GEN_6 = mux(_T_6, UInt<2>("h3"), _GEN_5) @[NegIntGen.scala 32:29 NegIntGen.scala 33:15]
    reg in_buffer : UInt<4>, clock with :
      reset => (UInt<1>("h0"), in_buffer) @[NegIntGen.scala 36:28]
    reg number : UInt<32>, clock with :
      reset => (UInt<1>("h0"), number) @[NegIntGen.scala 37:25]
    node _T_7 = eq(state, UInt<2>("h1")) @[NegIntGen.scala 39:16]
    node _T_8 = dshl(number, UInt<2>("h3")) @[NegIntGen.scala 40:26]
    node _T_9 = dshl(number, UInt<1>("h1")) @[NegIntGen.scala 40:42]
    node _T_10 = add(_T_8, _T_9) @[NegIntGen.scala 40:33]
    node _T_11 = tail(_T_10, 1) @[NegIntGen.scala 40:33]
    node _T_12 = add(_T_11, in_buffer) @[NegIntGen.scala 40:49]
    node _T_13 = tail(_T_12, 1) @[NegIntGen.scala 40:49]
    node _T_14 = eq(state, UInt<2>("h3")) @[NegIntGen.scala 41:22]
    node _T_15 = eq(state, UInt<2>("h2")) @[NegIntGen.scala 44:22]
    node _GEN_7 = mux(_T_15, UInt<1>("h0"), io_key_in) @[NegIntGen.scala 44:33 NegIntGen.scala 47:19 NegIntGen.scala 36:28]
    node _GEN_8 = mux(_T_15, UInt<1>("h0"), number) @[NegIntGen.scala 44:33 NegIntGen.scala 48:16 NegIntGen.scala 37:25]
    node _GEN_9 = mux(_T_14, UInt<4>("hd"), _GEN_8) @[NegIntGen.scala 41:37 NegIntGen.scala 42:16]
    node _GEN_10 = mux(_T_14, io_key_in, _GEN_7) @[NegIntGen.scala 41:37 NegIntGen.scala 36:28]
    node _GEN_11 = mux(_T_7, _T_13, _GEN_9) @[NegIntGen.scala 39:28 NegIntGen.scala 40:16]
    node _GEN_12 = mux(_T_7, io_key_in, _GEN_10) @[NegIntGen.scala 39:28 NegIntGen.scala 36:28]
    node _T_16 = eq(state, UInt<2>("h2")) @[NegIntGen.scala 51:33]
    node _T_17 = mux(_T_16, UInt<1>("h1"), UInt<1>("h0")) @[NegIntGen.scala 51:26]
    io_value_valid <= _T_17 @[NegIntGen.scala 51:20]
    io_value_bits <= number @[NegIntGen.scala 52:19]
    state <= mux(reset, UInt<2>("h0"), _GEN_6) @[NegIntGen.scala 18:24 NegIntGen.scala 18:24]
    in_buffer <= _GEN_12
    number <= mux(reset, UInt<32>("h0"), bits(_GEN_11, 31, 0)) @[NegIntGen.scala 37:25 NegIntGen.scala 37:25]

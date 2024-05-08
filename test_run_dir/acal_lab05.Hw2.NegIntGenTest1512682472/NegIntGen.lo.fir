circuit NegIntGen :
  module NegIntGen :
    input clock : Clock
    input reset : UInt<1>
    input io_key_in : UInt<4>
    output io_value_valid : UInt<1>
    output io_value_bits : UInt<32>

    node _T = eq(io_key_in, UInt<4>("hf")) @[NegIntGen.scala 14:24]
    reg neg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), neg) @[NegIntGen.scala 17:22]
    node _T_1 = eq(io_key_in, UInt<4>("hd")) @[NegIntGen.scala 18:22]
    reg state : UInt<2>, clock with :
      reset => (UInt<1>("h0"), state) @[NegIntGen.scala 22:24]
    node _T_2 = eq(UInt<2>("h0"), state) @[Conditional.scala 37:30]
    node _T_3 = eq(UInt<2>("h1"), state) @[Conditional.scala 37:30]
    node equal = _T
    node _GEN_0 = mux(equal, UInt<2>("h2"), state) @[NegIntGen.scala 26:33 NegIntGen.scala 26:40 NegIntGen.scala 22:24]
    node _T_4 = eq(UInt<2>("h2"), state) @[Conditional.scala 37:30]
    node _GEN_1 = mux(_T_4, UInt<2>("h1"), state) @[Conditional.scala 39:67 NegIntGen.scala 27:26 NegIntGen.scala 22:24]
    node _GEN_2 = mux(_T_3, _GEN_0, _GEN_1) @[Conditional.scala 39:67]
    node _GEN_3 = mux(_T_2, UInt<2>("h1"), _GEN_2) @[Conditional.scala 40:58 NegIntGen.scala 25:25]
    reg in_buffer : UInt<4>, clock with :
      reset => (UInt<1>("h0"), in_buffer) @[NegIntGen.scala 31:28]
    reg number : UInt<32>, clock with :
      reset => (UInt<1>("h0"), number) @[NegIntGen.scala 32:25]
    node _T_5 = eq(state, UInt<2>("h1")) @[NegIntGen.scala 34:16]
    node _T_6 = neq(in_buffer, UInt<4>("hb")) @[NegIntGen.scala 37:25]
    node _T_7 = neq(in_buffer, UInt<4>("hd")) @[NegIntGen.scala 37:48]
    node _T_8 = or(_T_6, _T_7) @[NegIntGen.scala 37:34]
    node _T_9 = neq(in_buffer, UInt<4>("he")) @[NegIntGen.scala 37:71]
    node _T_10 = or(_T_8, _T_9) @[NegIntGen.scala 37:57]
    node _T_11 = dshl(number, UInt<2>("h3")) @[NegIntGen.scala 41:42]
    node _T_12 = dshl(number, UInt<1>("h1")) @[NegIntGen.scala 41:58]
    node _T_13 = add(_T_11, _T_12) @[NegIntGen.scala 41:49]
    node _T_14 = tail(_T_13, 1) @[NegIntGen.scala 41:49]
    node _T_15 = add(_T_14, in_buffer) @[NegIntGen.scala 41:65]
    node _T_16 = tail(_T_15, 1) @[NegIntGen.scala 41:65]
    node _GEN_4 = mux(neg, UInt<1>("h0"), _T_16) @[NegIntGen.scala 38:22 NegIntGen.scala 39:24 NegIntGen.scala 41:32]
    node _GEN_5 = mux(_T_10, _GEN_4, number) @[NegIntGen.scala 37:80 NegIntGen.scala 32:25]
    node _T_17 = eq(state, UInt<2>("h2")) @[NegIntGen.scala 44:22]
    node _GEN_6 = mux(_T_17, UInt<1>("h0"), io_key_in) @[NegIntGen.scala 44:33 NegIntGen.scala 47:19 NegIntGen.scala 31:28]
    node _GEN_7 = mux(_T_17, UInt<1>("h0"), number) @[NegIntGen.scala 44:33 NegIntGen.scala 48:16 NegIntGen.scala 32:25]
    node _GEN_8 = mux(_T_5, _GEN_5, _GEN_7) @[NegIntGen.scala 34:28]
    node _GEN_9 = mux(_T_5, io_key_in, _GEN_6) @[NegIntGen.scala 34:28 NegIntGen.scala 31:28]
    node _T_18 = eq(state, UInt<2>("h2")) @[NegIntGen.scala 51:33]
    node _T_19 = mux(_T_18, UInt<1>("h1"), UInt<1>("h0")) @[NegIntGen.scala 51:26]
    io_value_valid <= _T_19 @[NegIntGen.scala 51:20]
    io_value_bits <= number @[NegIntGen.scala 52:19]
    neg <= mux(reset, UInt<1>("h0"), _T_1) @[NegIntGen.scala 17:22 NegIntGen.scala 17:22 NegIntGen.scala 18:9]
    state <= mux(reset, UInt<2>("h0"), _GEN_3) @[NegIntGen.scala 22:24 NegIntGen.scala 22:24]
    in_buffer <= _GEN_9
    number <= mux(reset, UInt<32>("h0"), bits(_GEN_8, 31, 0)) @[NegIntGen.scala 32:25 NegIntGen.scala 32:25]

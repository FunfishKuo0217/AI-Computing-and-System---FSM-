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
    node _T_6 = not(number) @[NegIntGen.scala 39:29]
    node _T_7 = add(_T_6, UInt<1>("h1")) @[NegIntGen.scala 39:37]
    node _T_8 = tail(_T_7, 1) @[NegIntGen.scala 39:37]
    node _T_9 = dshl(_T_8, UInt<2>("h3")) @[NegIntGen.scala 39:43]
    node _T_10 = not(number) @[NegIntGen.scala 39:56]
    node _T_11 = add(_T_10, UInt<1>("h1")) @[NegIntGen.scala 39:64]
    node _T_12 = tail(_T_11, 1) @[NegIntGen.scala 39:64]
    node _T_13 = dshl(_T_12, UInt<1>("h1")) @[NegIntGen.scala 39:70]
    node _T_14 = add(_T_9, _T_13) @[NegIntGen.scala 39:51]
    node _T_15 = tail(_T_14, 1) @[NegIntGen.scala 39:51]
    node _T_16 = add(_T_15, in_buffer) @[NegIntGen.scala 39:78]
    node _T_17 = tail(_T_16, 1) @[NegIntGen.scala 39:78]
    node _T_18 = not(_T_17) @[NegIntGen.scala 39:24]
    node _T_19 = add(_T_18, UInt<1>("h1")) @[NegIntGen.scala 39:92]
    node _T_20 = tail(_T_19, 1) @[NegIntGen.scala 39:92]
    node _T_21 = dshl(number, UInt<2>("h3")) @[NegIntGen.scala 41:30]
    node _T_22 = dshl(number, UInt<1>("h1")) @[NegIntGen.scala 41:46]
    node _T_23 = add(_T_21, _T_22) @[NegIntGen.scala 41:37]
    node _T_24 = tail(_T_23, 1) @[NegIntGen.scala 41:37]
    node _T_25 = add(_T_24, in_buffer) @[NegIntGen.scala 41:53]
    node _T_26 = tail(_T_25, 1) @[NegIntGen.scala 41:53]
    node _GEN_4 = mux(neg, _T_20, _T_26) @[NegIntGen.scala 37:18 NegIntGen.scala 39:20 NegIntGen.scala 41:20]
    node _T_27 = eq(state, UInt<2>("h2")) @[NegIntGen.scala 45:22]
    node _GEN_5 = mux(_T_27, UInt<1>("h0"), io_key_in) @[NegIntGen.scala 45:33 NegIntGen.scala 48:19 NegIntGen.scala 31:28]
    node _GEN_6 = mux(_T_27, UInt<1>("h0"), number) @[NegIntGen.scala 45:33 NegIntGen.scala 49:16 NegIntGen.scala 32:25]
    node _GEN_7 = mux(_T_5, _GEN_4, _GEN_6) @[NegIntGen.scala 34:28]
    node _GEN_8 = mux(_T_5, io_key_in, _GEN_5) @[NegIntGen.scala 34:28 NegIntGen.scala 31:28]
    node _T_28 = eq(state, UInt<2>("h2")) @[NegIntGen.scala 52:33]
    node _T_29 = mux(_T_28, UInt<1>("h1"), UInt<1>("h0")) @[NegIntGen.scala 52:26]
    io_value_valid <= _T_29 @[NegIntGen.scala 52:20]
    io_value_bits <= number @[NegIntGen.scala 53:19]
    neg <= mux(reset, UInt<1>("h0"), _T_1) @[NegIntGen.scala 17:22 NegIntGen.scala 17:22 NegIntGen.scala 18:9]
    state <= mux(reset, UInt<2>("h0"), _GEN_3) @[NegIntGen.scala 22:24 NegIntGen.scala 22:24]
    in_buffer <= _GEN_8
    number <= mux(reset, UInt<32>("h0"), bits(_GEN_7, 31, 0)) @[NegIntGen.scala 32:25 NegIntGen.scala 32:25]

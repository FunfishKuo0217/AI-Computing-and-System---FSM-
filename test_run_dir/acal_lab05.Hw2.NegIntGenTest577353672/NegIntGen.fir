circuit NegIntGen :
  module NegIntGen :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip key_in : UInt<4>, value : { valid : UInt<1>, bits : UInt<32>}}

    wire equal : UInt<1>
    equal <= UInt<1>("h0")
    node _T = eq(io.key_in, UInt<4>("hf")) @[NegIntGen.scala 14:24]
    equal <= _T @[NegIntGen.scala 14:11]
    reg neg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[NegIntGen.scala 17:22]
    node _T_1 = eq(io.key_in, UInt<4>("hd")) @[NegIntGen.scala 18:22]
    neg <= _T_1 @[NegIntGen.scala 18:9]
    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[NegIntGen.scala 22:24]
    node _T_2 = eq(UInt<2>("h0"), state) @[Conditional.scala 37:30]
    when _T_2 : @[Conditional.scala 40:58]
      state <= UInt<2>("h1") @[NegIntGen.scala 25:25]
    else :
      node _T_3 = eq(UInt<2>("h1"), state) @[Conditional.scala 37:30]
      when _T_3 : @[Conditional.scala 39:67]
        when equal : @[NegIntGen.scala 26:33]
          state <= UInt<2>("h2") @[NegIntGen.scala 26:40]
      else :
        node _T_4 = eq(UInt<2>("h2"), state) @[Conditional.scala 37:30]
        when _T_4 : @[Conditional.scala 39:67]
          state <= UInt<2>("h1") @[NegIntGen.scala 27:26]
    reg in_buffer : UInt, clock with :
      reset => (UInt<1>("h0"), in_buffer) @[NegIntGen.scala 31:28]
    in_buffer <= io.key_in @[NegIntGen.scala 31:28]
    reg number : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[NegIntGen.scala 32:25]
    node _T_5 = eq(state, UInt<2>("h1")) @[NegIntGen.scala 34:16]
    when _T_5 : @[NegIntGen.scala 34:28]
      when neg : @[NegIntGen.scala 37:18]
        number <= UInt<1>("h0") @[NegIntGen.scala 38:20]
      else :
        node _T_6 = dshl(number, UInt<2>("h3")) @[NegIntGen.scala 40:38]
        node _T_7 = dshl(number, UInt<1>("h1")) @[NegIntGen.scala 40:54]
        node _T_8 = add(_T_6, _T_7) @[NegIntGen.scala 40:45]
        node _T_9 = tail(_T_8, 1) @[NegIntGen.scala 40:45]
        node _T_10 = add(_T_9, in_buffer) @[NegIntGen.scala 40:61]
        node _T_11 = tail(_T_10, 1) @[NegIntGen.scala 40:61]
        number <= _T_11 @[NegIntGen.scala 40:28]
    else :
      node _T_12 = eq(state, UInt<2>("h2")) @[NegIntGen.scala 42:22]
      when _T_12 : @[NegIntGen.scala 42:33]
        in_buffer <= UInt<1>("h0") @[NegIntGen.scala 45:19]
        number <= UInt<1>("h0") @[NegIntGen.scala 46:16]
    node _T_13 = eq(state, UInt<2>("h2")) @[NegIntGen.scala 49:33]
    node _T_14 = mux(_T_13, UInt<1>("h1"), UInt<1>("h0")) @[NegIntGen.scala 49:26]
    io.value.valid <= _T_14 @[NegIntGen.scala 49:20]
    io.value.bits <= number @[NegIntGen.scala 50:19]


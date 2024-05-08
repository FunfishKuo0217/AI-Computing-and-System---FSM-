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
      node _T_6 = neq(in_buffer, UInt<4>("hb")) @[NegIntGen.scala 37:25]
      node _T_7 = neq(in_buffer, UInt<4>("hd")) @[NegIntGen.scala 37:48]
      node _T_8 = or(_T_6, _T_7) @[NegIntGen.scala 37:34]
      node _T_9 = neq(in_buffer, UInt<4>("he")) @[NegIntGen.scala 37:71]
      node _T_10 = or(_T_8, _T_9) @[NegIntGen.scala 37:57]
      when _T_10 : @[NegIntGen.scala 37:80]
        when neg : @[NegIntGen.scala 38:22]
          number <= number @[NegIntGen.scala 39:24]
        else :
          node _T_11 = dshl(number, UInt<2>("h3")) @[NegIntGen.scala 41:42]
          node _T_12 = dshl(number, UInt<1>("h1")) @[NegIntGen.scala 41:58]
          node _T_13 = add(_T_11, _T_12) @[NegIntGen.scala 41:49]
          node _T_14 = tail(_T_13, 1) @[NegIntGen.scala 41:49]
          node _T_15 = add(_T_14, in_buffer) @[NegIntGen.scala 41:65]
          node _T_16 = tail(_T_15, 1) @[NegIntGen.scala 41:65]
          number <= _T_16 @[NegIntGen.scala 41:32]
    else :
      node _T_17 = eq(state, UInt<2>("h2")) @[NegIntGen.scala 44:22]
      when _T_17 : @[NegIntGen.scala 44:33]
        in_buffer <= UInt<1>("h0") @[NegIntGen.scala 47:19]
        number <= UInt<1>("h0") @[NegIntGen.scala 48:16]
    node _T_18 = eq(state, UInt<2>("h2")) @[NegIntGen.scala 51:33]
    node _T_19 = mux(_T_18, UInt<1>("h1"), UInt<1>("h0")) @[NegIntGen.scala 51:26]
    io.value.valid <= _T_19 @[NegIntGen.scala 51:20]
    io.value.bits <= number @[NegIntGen.scala 52:19]


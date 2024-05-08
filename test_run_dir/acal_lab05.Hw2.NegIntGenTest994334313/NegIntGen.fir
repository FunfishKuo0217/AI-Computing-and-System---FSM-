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
          node _T_11 = not(number) @[NegIntGen.scala 38:39]
          node _T_12 = add(_T_11, UInt<1>("h1")) @[NegIntGen.scala 38:47]
          node _T_13 = tail(_T_12, 1) @[NegIntGen.scala 38:47]
          node _T_14 = dshl(_T_13, UInt<2>("h3")) @[NegIntGen.scala 38:53]
          node _T_15 = not(number) @[NegIntGen.scala 38:66]
          node _T_16 = add(_T_15, UInt<1>("h1")) @[NegIntGen.scala 38:74]
          node _T_17 = tail(_T_16, 1) @[NegIntGen.scala 38:74]
          node _T_18 = dshl(_T_17, UInt<1>("h1")) @[NegIntGen.scala 38:80]
          node _T_19 = add(_T_14, _T_18) @[NegIntGen.scala 38:61]
          node _T_20 = tail(_T_19, 1) @[NegIntGen.scala 38:61]
          node _T_21 = add(_T_20, in_buffer) @[NegIntGen.scala 38:88]
          node _T_22 = tail(_T_21, 1) @[NegIntGen.scala 38:88]
          node _T_23 = not(_T_22) @[NegIntGen.scala 38:34]
          node _T_24 = add(_T_23, UInt<1>("h1")) @[NegIntGen.scala 38:102]
          node _T_25 = tail(_T_24, 1) @[NegIntGen.scala 38:102]
          number <= _T_25 @[NegIntGen.scala 38:30]
        else :
          node _T_26 = dshl(number, UInt<2>("h3")) @[NegIntGen.scala 39:42]
          node _T_27 = dshl(number, UInt<1>("h1")) @[NegIntGen.scala 39:58]
          node _T_28 = add(_T_26, _T_27) @[NegIntGen.scala 39:49]
          node _T_29 = tail(_T_28, 1) @[NegIntGen.scala 39:49]
          node _T_30 = add(_T_29, in_buffer) @[NegIntGen.scala 39:65]
          node _T_31 = tail(_T_30, 1) @[NegIntGen.scala 39:65]
          number <= _T_31 @[NegIntGen.scala 39:32]
    else :
      node _T_32 = eq(state, UInt<2>("h2")) @[NegIntGen.scala 42:22]
      when _T_32 : @[NegIntGen.scala 42:33]
        in_buffer <= UInt<1>("h0") @[NegIntGen.scala 45:19]
        number <= UInt<1>("h0") @[NegIntGen.scala 46:16]
    node _T_33 = eq(state, UInt<2>("h2")) @[NegIntGen.scala 49:33]
    node _T_34 = mux(_T_33, UInt<1>("h1"), UInt<1>("h0")) @[NegIntGen.scala 49:26]
    io.value.valid <= _T_34 @[NegIntGen.scala 49:20]
    io.value.bits <= number @[NegIntGen.scala 50:19]


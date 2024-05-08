circuit NegIntGen :
  module NegIntGen :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip key_in : UInt<4>, value : { valid : UInt<1>, bits : UInt<32>}}

    wire equal : UInt<1>
    equal <= UInt<1>("h0")
    node _T = eq(io.key_in, UInt<4>("hf")) @[NegIntGen.scala 14:24]
    equal <= _T @[NegIntGen.scala 14:11]
    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[NegIntGen.scala 18:24]
    node _T_1 = eq(UInt<2>("h0"), state) @[Conditional.scala 37:30]
    when _T_1 : @[Conditional.scala 40:58]
      node _T_2 = eq(io.key_in, UInt<4>("hd")) @[NegIntGen.scala 22:28]
      when _T_2 : @[NegIntGen.scala 22:37]
        state <= UInt<2>("h3") @[NegIntGen.scala 23:23]
      else :
        state <= UInt<2>("h1") @[NegIntGen.scala 24:31]
    else :
      node _T_3 = eq(UInt<2>("h1"), state) @[Conditional.scala 37:30]
      when _T_3 : @[Conditional.scala 39:67]
        when equal : @[NegIntGen.scala 26:33]
          state <= UInt<2>("h2") @[NegIntGen.scala 26:40]
      else :
        node _T_4 = eq(UInt<2>("h3"), state) @[Conditional.scala 37:30]
        when _T_4 : @[Conditional.scala 39:67]
          when equal : @[NegIntGen.scala 27:36]
            state <= UInt<2>("h2") @[NegIntGen.scala 27:43]
        else :
          node _T_5 = eq(UInt<2>("h2"), state) @[Conditional.scala 37:30]
          when _T_5 : @[Conditional.scala 39:67]
            state <= UInt<2>("h1") @[NegIntGen.scala 29:19]
    node _T_6 = eq(io.key_in, UInt<4>("hd")) @[NegIntGen.scala 33:20]
    when _T_6 : @[NegIntGen.scala 33:29]
      state <= UInt<2>("h3") @[NegIntGen.scala 34:15]
    reg in_buffer : UInt, clock with :
      reset => (UInt<1>("h0"), in_buffer) @[NegIntGen.scala 37:28]
    in_buffer <= io.key_in @[NegIntGen.scala 37:28]
    reg number : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[NegIntGen.scala 38:25]
    node _T_7 = eq(state, UInt<2>("h1")) @[NegIntGen.scala 40:16]
    when _T_7 : @[NegIntGen.scala 40:28]
      node _T_8 = dshl(number, UInt<2>("h3")) @[NegIntGen.scala 41:26]
      node _T_9 = dshl(number, UInt<1>("h1")) @[NegIntGen.scala 41:42]
      node _T_10 = add(_T_8, _T_9) @[NegIntGen.scala 41:33]
      node _T_11 = tail(_T_10, 1) @[NegIntGen.scala 41:33]
      node _T_12 = add(_T_11, in_buffer) @[NegIntGen.scala 41:49]
      node _T_13 = tail(_T_12, 1) @[NegIntGen.scala 41:49]
      number <= _T_13 @[NegIntGen.scala 41:16]
    else :
      node _T_14 = eq(state, UInt<2>("h3")) @[NegIntGen.scala 42:22]
      when _T_14 : @[NegIntGen.scala 42:37]
        node _T_15 = dshl(number, UInt<2>("h3")) @[NegIntGen.scala 44:26]
        node _T_16 = dshl(number, UInt<1>("h1")) @[NegIntGen.scala 44:42]
        node _T_17 = add(_T_15, _T_16) @[NegIntGen.scala 44:33]
        node _T_18 = tail(_T_17, 1) @[NegIntGen.scala 44:33]
        node _T_19 = sub(_T_18, in_buffer) @[NegIntGen.scala 44:49]
        node _T_20 = tail(_T_19, 1) @[NegIntGen.scala 44:49]
        number <= _T_20 @[NegIntGen.scala 44:16]
      else :
        node _T_21 = eq(state, UInt<2>("h2")) @[NegIntGen.scala 45:22]
        when _T_21 : @[NegIntGen.scala 45:33]
          in_buffer <= UInt<1>("h0") @[NegIntGen.scala 48:19]
          number <= UInt<1>("h0") @[NegIntGen.scala 49:16]
    node _T_22 = eq(state, UInt<2>("h2")) @[NegIntGen.scala 52:33]
    node _T_23 = mux(_T_22, UInt<1>("h1"), UInt<1>("h0")) @[NegIntGen.scala 52:26]
    io.value.valid <= _T_23 @[NegIntGen.scala 52:20]
    io.value.bits <= number @[NegIntGen.scala 53:19]


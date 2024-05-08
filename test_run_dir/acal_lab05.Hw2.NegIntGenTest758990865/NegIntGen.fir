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
            state <= UInt<2>("h1") @[NegIntGen.scala 28:26]
    reg in_buffer : UInt, clock with :
      reset => (UInt<1>("h0"), in_buffer) @[NegIntGen.scala 32:28]
    in_buffer <= io.key_in @[NegIntGen.scala 32:28]
    reg number : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[NegIntGen.scala 33:25]
    node _T_6 = eq(state, UInt<2>("h1")) @[NegIntGen.scala 35:16]
    when _T_6 : @[NegIntGen.scala 35:28]
      node _T_7 = dshl(number, UInt<2>("h3")) @[NegIntGen.scala 36:26]
      node _T_8 = dshl(number, UInt<1>("h1")) @[NegIntGen.scala 36:42]
      node _T_9 = add(_T_7, _T_8) @[NegIntGen.scala 36:33]
      node _T_10 = tail(_T_9, 1) @[NegIntGen.scala 36:33]
      node _T_11 = add(_T_10, in_buffer) @[NegIntGen.scala 36:49]
      node _T_12 = tail(_T_11, 1) @[NegIntGen.scala 36:49]
      number <= _T_12 @[NegIntGen.scala 36:16]
    else :
      node _T_13 = eq(state, UInt<2>("h3")) @[NegIntGen.scala 37:22]
      when _T_13 : @[NegIntGen.scala 37:37]
        number <= UInt<4>("hd") @[NegIntGen.scala 38:16]
      else :
        node _T_14 = eq(state, UInt<2>("h2")) @[NegIntGen.scala 40:22]
        when _T_14 : @[NegIntGen.scala 40:33]
          in_buffer <= UInt<1>("h0") @[NegIntGen.scala 43:19]
          number <= UInt<1>("h0") @[NegIntGen.scala 44:16]
    node _T_15 = eq(state, UInt<2>("h2")) @[NegIntGen.scala 47:33]
    node _T_16 = mux(_T_15, UInt<1>("h1"), UInt<1>("h0")) @[NegIntGen.scala 47:26]
    io.value.valid <= _T_16 @[NegIntGen.scala 47:20]
    io.value.bits <= number @[NegIntGen.scala 48:19]


circuit IntGen :
  module IntGen :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip key_in : UInt<4>, value : { valid : UInt<1>, bits : UInt<32>}}

    wire equal : UInt<1>
    equal <= UInt<1>("h0")
    node _T = eq(io.key_in, UInt<4>("hf")) @[IntGen.scala 13:24]
    equal <= _T @[IntGen.scala 13:11]
    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[IntGen.scala 16:24]
    node _T_1 = eq(UInt<2>("h0"), state) @[Conditional.scala 37:30]
    when _T_1 : @[Conditional.scala 40:58]
      state <= UInt<2>("h1") @[IntGen.scala 20:15]
    else :
      node _T_2 = eq(UInt<2>("h1"), state) @[Conditional.scala 37:30]
      when _T_2 : @[Conditional.scala 39:67]
        when equal : @[IntGen.scala 23:21]
          state <= UInt<2>("h2") @[IntGen.scala 23:28]
      else :
        node _T_3 = eq(UInt<2>("h2"), state) @[Conditional.scala 37:30]
        when _T_3 : @[Conditional.scala 39:67]
          state <= UInt<2>("h1") @[IntGen.scala 26:19]
    reg in_buffer : UInt, clock with :
      reset => (UInt<1>("h0"), in_buffer) @[IntGen.scala 31:28]
    in_buffer <= io.key_in @[IntGen.scala 31:28]
    reg number : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[IntGen.scala 33:25]
    node _T_4 = eq(state, UInt<2>("h1")) @[IntGen.scala 34:16]
    when _T_4 : @[IntGen.scala 34:28]
      node _T_5 = dshl(number, UInt<2>("h3")) @[IntGen.scala 37:26]
      node _T_6 = dshl(number, UInt<1>("h1")) @[IntGen.scala 37:42]
      node _T_7 = add(_T_5, _T_6) @[IntGen.scala 37:33]
      node _T_8 = tail(_T_7, 1) @[IntGen.scala 37:33]
      node _T_9 = add(_T_8, in_buffer) @[IntGen.scala 37:49]
      node _T_10 = tail(_T_9, 1) @[IntGen.scala 37:49]
      number <= _T_10 @[IntGen.scala 37:16]
    else :
      node _T_11 = eq(state, UInt<2>("h2")) @[IntGen.scala 38:22]
      when _T_11 : @[IntGen.scala 38:33]
        in_buffer <= UInt<1>("h0") @[IntGen.scala 41:19]
        number <= UInt<1>("h0") @[IntGen.scala 42:16]
    node _T_12 = eq(state, UInt<2>("h2")) @[IntGen.scala 45:33]
    node _T_13 = mux(_T_12, UInt<1>("h1"), UInt<1>("h0")) @[IntGen.scala 45:26]
    io.value.valid <= _T_13 @[IntGen.scala 45:20]
    io.value.bits <= number @[IntGen.scala 46:19]


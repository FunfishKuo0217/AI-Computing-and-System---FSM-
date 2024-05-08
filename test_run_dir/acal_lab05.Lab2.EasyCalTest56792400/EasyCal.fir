circuit EasyCal :
  module EasyCal :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip key_in : UInt<4>, value : { valid : UInt<1>, bits : UInt<32>}}

    wire operator : UInt<1>
    operator <= UInt<1>("h0")
    node _T = geq(io.key_in, UInt<4>("ha")) @[EasyCal.scala 15:27]
    node _T_1 = leq(io.key_in, UInt<4>("hc")) @[EasyCal.scala 15:48]
    node _T_2 = and(_T, _T_1) @[EasyCal.scala 15:35]
    operator <= _T_2 @[EasyCal.scala 15:14]
    wire num : UInt<1>
    num <= UInt<1>("h0")
    node _T_3 = lt(io.key_in, UInt<4>("ha")) @[EasyCal.scala 18:22]
    num <= _T_3 @[EasyCal.scala 18:9]
    wire equal : UInt<1>
    equal <= UInt<1>("h0")
    node _T_4 = eq(io.key_in, UInt<4>("hf")) @[EasyCal.scala 23:24]
    equal <= _T_4 @[EasyCal.scala 23:11]
    reg in_buffer : UInt, clock with :
      reset => (UInt<1>("h0"), in_buffer) @[EasyCal.scala 28:28]
    in_buffer <= io.key_in @[EasyCal.scala 28:28]
    reg src1 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[EasyCal.scala 29:23]
    reg op : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[EasyCal.scala 30:21]
    reg src2 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[EasyCal.scala 31:23]
    reg state : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[EasyCal.scala 39:24]
    node _T_5 = eq(UInt<3>("h0"), state) @[Conditional.scala 37:30]
    when _T_5 : @[Conditional.scala 40:58]
      state <= UInt<3>("h1") @[EasyCal.scala 45:19]
    else :
      node _T_6 = eq(UInt<3>("h1"), state) @[Conditional.scala 37:30]
      when _T_6 : @[Conditional.scala 39:67]
        when operator : @[EasyCal.scala 48:28]
          state <= UInt<3>("h2") @[EasyCal.scala 48:35]
      else :
        node _T_7 = eq(UInt<3>("h2"), state) @[Conditional.scala 37:30]
        when _T_7 : @[Conditional.scala 39:67]
          when num : @[EasyCal.scala 51:23]
            state <= UInt<3>("h3") @[EasyCal.scala 51:30]
        else :
          node _T_8 = eq(UInt<3>("h3"), state) @[Conditional.scala 37:30]
          when _T_8 : @[Conditional.scala 39:67]
            when equal : @[EasyCal.scala 54:25]
              state <= UInt<3>("h4") @[EasyCal.scala 54:32]
          else :
            node _T_9 = eq(UInt<3>("h4"), state) @[Conditional.scala 37:30]
            when _T_9 : @[Conditional.scala 39:67]
              state <= UInt<3>("h1") @[EasyCal.scala 57:19]
    node _T_10 = eq(state, UInt<3>("h1")) @[EasyCal.scala 62:16]
    when _T_10 : @[EasyCal.scala 62:26]
      node _T_11 = dshl(src1, UInt<2>("h3")) @[EasyCal.scala 62:40]
      node _T_12 = dshl(src1, UInt<1>("h1")) @[EasyCal.scala 62:54]
      node _T_13 = add(_T_11, _T_12) @[EasyCal.scala 62:47]
      node _T_14 = tail(_T_13, 1) @[EasyCal.scala 62:47]
      node _T_15 = add(_T_14, in_buffer) @[EasyCal.scala 62:61]
      node _T_16 = tail(_T_15, 1) @[EasyCal.scala 62:61]
      src1 <= _T_16 @[EasyCal.scala 62:32]
    node _T_17 = eq(state, UInt<3>("h3")) @[EasyCal.scala 63:16]
    when _T_17 : @[EasyCal.scala 63:26]
      node _T_18 = dshl(src2, UInt<2>("h3")) @[EasyCal.scala 63:40]
      node _T_19 = dshl(src2, UInt<1>("h1")) @[EasyCal.scala 63:54]
      node _T_20 = add(_T_18, _T_19) @[EasyCal.scala 63:47]
      node _T_21 = tail(_T_20, 1) @[EasyCal.scala 63:47]
      node _T_22 = add(_T_21, in_buffer) @[EasyCal.scala 63:61]
      node _T_23 = tail(_T_22, 1) @[EasyCal.scala 63:61]
      src2 <= _T_23 @[EasyCal.scala 63:32]
    node _T_24 = eq(state, UInt<3>("h2")) @[EasyCal.scala 64:16]
    when _T_24 : @[EasyCal.scala 64:24]
      node _T_25 = sub(in_buffer, UInt<4>("ha")) @[EasyCal.scala 64:41]
      node _T_26 = tail(_T_25, 1) @[EasyCal.scala 64:41]
      op <= _T_26 @[EasyCal.scala 64:28]
    node _T_27 = eq(state, UInt<3>("h4")) @[EasyCal.scala 66:16]
    when _T_27 : @[EasyCal.scala 66:27]
      src1 <= UInt<1>("h0") @[EasyCal.scala 67:14]
      src2 <= UInt<1>("h0") @[EasyCal.scala 68:14]
      op <= UInt<1>("h0") @[EasyCal.scala 69:12]
      in_buffer <= UInt<1>("h0") @[EasyCal.scala 70:19]
    node _T_28 = eq(state, UInt<3>("h4")) @[EasyCal.scala 73:33]
    node _T_29 = mux(_T_28, UInt<1>("h1"), UInt<1>("h0")) @[EasyCal.scala 73:26]
    io.value.valid <= _T_29 @[EasyCal.scala 73:20]
    node _T_30 = add(src1, src2) @[EasyCal.scala 75:22]
    node _T_31 = tail(_T_30, 1) @[EasyCal.scala 75:22]
    node _T_32 = sub(src1, src2) @[EasyCal.scala 76:22]
    node _T_33 = tail(_T_32, 1) @[EasyCal.scala 76:22]
    node _T_34 = mul(src1, src2) @[EasyCal.scala 77:22]
    node _T_35 = eq(UInt<1>("h0"), op) @[Mux.scala 80:60]
    node _T_36 = mux(_T_35, _T_31, UInt<1>("h0")) @[Mux.scala 80:57]
    node _T_37 = eq(UInt<1>("h1"), op) @[Mux.scala 80:60]
    node _T_38 = mux(_T_37, _T_33, _T_36) @[Mux.scala 80:57]
    node _T_39 = eq(UInt<2>("h2"), op) @[Mux.scala 80:60]
    node _T_40 = mux(_T_39, _T_34, _T_38) @[Mux.scala 80:57]
    io.value.bits <= _T_40 @[EasyCal.scala 74:19]


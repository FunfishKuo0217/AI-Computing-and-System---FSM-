circuit LongCal :
  module LongCal :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip key_in : UInt<4>, value : { valid : UInt<1>, bits : UInt<32>}}

    wire operator : UInt<1>
    operator <= UInt<1>("h0")
    node _T = geq(io.key_in, UInt<4>("ha")) @[LongCal.scala 15:27]
    node _T_1 = leq(io.key_in, UInt<4>("hc")) @[LongCal.scala 15:48]
    node _T_2 = and(_T, _T_1) @[LongCal.scala 15:35]
    operator <= _T_2 @[LongCal.scala 15:14]
    wire num : UInt<1>
    num <= UInt<1>("h0")
    node _T_3 = lt(io.key_in, UInt<4>("ha")) @[LongCal.scala 18:22]
    num <= _T_3 @[LongCal.scala 18:9]
    wire equal : UInt<1>
    equal <= UInt<1>("h0")
    node _T_4 = eq(io.key_in, UInt<4>("hf")) @[LongCal.scala 23:24]
    equal <= _T_4 @[LongCal.scala 23:11]
    wire negStart : UInt<1>
    negStart <= UInt<1>("h0")
    node _T_5 = eq(io.key_in, UInt<4>("hd")) @[LongCal.scala 26:27]
    negStart <= _T_5 @[LongCal.scala 26:14]
    wire negEnd : UInt<1>
    negEnd <= UInt<1>("h0")
    node _T_6 = eq(io.key_in, UInt<4>("he")) @[LongCal.scala 28:25]
    negEnd <= _T_6 @[LongCal.scala 28:12]
    reg in_buffer : UInt, clock with :
      reset => (UInt<1>("h0"), in_buffer) @[LongCal.scala 33:28]
    in_buffer <= io.key_in @[LongCal.scala 33:28]
    reg src1 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[LongCal.scala 34:23]
    reg op : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[LongCal.scala 35:21]
    reg src2 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[LongCal.scala 36:23]
    reg state : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[LongCal.scala 42:24]
    node _T_7 = eq(UInt<3>("h0"), state) @[Conditional.scala 37:30]
    when _T_7 : @[Conditional.scala 40:58]
      when negStart : @[LongCal.scala 48:27]
        state <= UInt<3>("h5") @[LongCal.scala 48:35]
      else :
        state <= UInt<3>("h1") @[LongCal.scala 49:32]
    else :
      node _T_8 = eq(UInt<3>("h1"), state) @[Conditional.scala 37:30]
      when _T_8 : @[Conditional.scala 39:67]
        when operator : @[LongCal.scala 52:28]
          state <= UInt<3>("h2") @[LongCal.scala 52:35]
        when equal : @[LongCal.scala 53:25]
          state <= UInt<3>("h4") @[LongCal.scala 53:32]
      else :
        node _T_9 = eq(UInt<3>("h5"), state) @[Conditional.scala 37:30]
        when _T_9 : @[Conditional.scala 39:67]
          when negEnd : @[LongCal.scala 56:25]
            state <= UInt<3>("h2") @[LongCal.scala 56:32]
        else :
          node _T_10 = eq(UInt<3>("h6"), state) @[Conditional.scala 37:30]
          when _T_10 : @[Conditional.scala 39:67]
            when negEnd : @[LongCal.scala 59:25]
              state <= UInt<3>("h2") @[LongCal.scala 59:32]
          else :
            node _T_11 = eq(UInt<3>("h2"), state) @[Conditional.scala 37:30]
            when _T_11 : @[Conditional.scala 39:67]
              when equal : @[LongCal.scala 62:25]
                state <= UInt<3>("h4") @[LongCal.scala 62:32]
              when num : @[LongCal.scala 63:23]
                state <= UInt<3>("h3") @[LongCal.scala 63:30]
              when negStart : @[LongCal.scala 64:28]
                state <= UInt<3>("h6") @[LongCal.scala 64:35]
            else :
              node _T_12 = eq(UInt<3>("h3"), state) @[Conditional.scala 37:30]
              when _T_12 : @[Conditional.scala 39:67]
                when operator : @[LongCal.scala 67:28]
                  state <= UInt<3>("h2") @[LongCal.scala 67:35]
                when equal : @[LongCal.scala 68:25]
                  state <= UInt<3>("h4") @[LongCal.scala 68:32]
              else :
                node _T_13 = eq(UInt<3>("h4"), state) @[Conditional.scala 37:30]
                when _T_13 : @[Conditional.scala 39:67]
                  node _T_14 = eq(io.key_in, UInt<4>("hd")) @[LongCal.scala 71:28]
                  when _T_14 : @[LongCal.scala 71:37]
                    state <= UInt<3>("h5") @[LongCal.scala 71:45]
                  else :
                    state <= UInt<3>("h1") @[LongCal.scala 72:32]
    node _T_15 = eq(io.key_in, UInt<4>("hd")) @[LongCal.scala 75:20]
    when _T_15 : @[LongCal.scala 75:29]
      state <= UInt<3>("h5") @[LongCal.scala 76:15]
    node _T_16 = eq(state, UInt<3>("h1")) @[LongCal.scala 80:16]
    when _T_16 : @[LongCal.scala 80:26]
      node _T_17 = dshl(src1, UInt<2>("h3")) @[LongCal.scala 80:40]
      node _T_18 = dshl(src1, UInt<1>("h1")) @[LongCal.scala 80:54]
      node _T_19 = add(_T_17, _T_18) @[LongCal.scala 80:47]
      node _T_20 = tail(_T_19, 1) @[LongCal.scala 80:47]
      node _T_21 = add(_T_20, in_buffer) @[LongCal.scala 80:61]
      node _T_22 = tail(_T_21, 1) @[LongCal.scala 80:61]
      src1 <= _T_22 @[LongCal.scala 80:32]
    node _T_23 = eq(state, UInt<3>("h3")) @[LongCal.scala 81:16]
    when _T_23 : @[LongCal.scala 81:26]
      node _T_24 = dshl(src2, UInt<2>("h3")) @[LongCal.scala 81:40]
      node _T_25 = dshl(src2, UInt<1>("h1")) @[LongCal.scala 81:54]
      node _T_26 = add(_T_24, _T_25) @[LongCal.scala 81:47]
      node _T_27 = tail(_T_26, 1) @[LongCal.scala 81:47]
      node _T_28 = add(_T_27, in_buffer) @[LongCal.scala 81:61]
      node _T_29 = tail(_T_28, 1) @[LongCal.scala 81:61]
      src2 <= _T_29 @[LongCal.scala 81:32]
    node _T_30 = eq(state, UInt<3>("h5")) @[LongCal.scala 82:16]
    when _T_30 : @[LongCal.scala 82:29]
      node _T_31 = neq(in_buffer, UInt<4>("hd")) @[LongCal.scala 83:25]
      node _T_32 = neq(in_buffer, UInt<4>("hb")) @[LongCal.scala 83:49]
      node _T_33 = and(_T_31, _T_32) @[LongCal.scala 83:35]
      node _T_34 = neq(in_buffer, UInt<4>("he")) @[LongCal.scala 83:73]
      node _T_35 = and(_T_33, _T_34) @[LongCal.scala 83:59]
      when _T_35 : @[LongCal.scala 83:83]
        node _T_36 = dshl(src1, UInt<2>("h3")) @[LongCal.scala 84:26]
        node _T_37 = dshl(src1, UInt<1>("h1")) @[LongCal.scala 84:40]
        node _T_38 = add(_T_36, _T_37) @[LongCal.scala 84:33]
        node _T_39 = tail(_T_38, 1) @[LongCal.scala 84:33]
        node _T_40 = sub(_T_39, in_buffer) @[LongCal.scala 84:47]
        node _T_41 = tail(_T_40, 1) @[LongCal.scala 84:47]
        src1 <= _T_41 @[LongCal.scala 84:18]
    node _T_42 = eq(state, UInt<3>("h6")) @[LongCal.scala 86:16]
    when _T_42 : @[LongCal.scala 86:29]
      node _T_43 = neq(in_buffer, UInt<4>("hd")) @[LongCal.scala 87:25]
      node _T_44 = neq(in_buffer, UInt<4>("hb")) @[LongCal.scala 87:49]
      node _T_45 = and(_T_43, _T_44) @[LongCal.scala 87:35]
      node _T_46 = neq(in_buffer, UInt<4>("he")) @[LongCal.scala 87:73]
      node _T_47 = and(_T_45, _T_46) @[LongCal.scala 87:59]
      when _T_47 : @[LongCal.scala 87:83]
        node _T_48 = dshl(src2, UInt<2>("h3")) @[LongCal.scala 88:26]
        node _T_49 = dshl(src2, UInt<1>("h1")) @[LongCal.scala 88:40]
        node _T_50 = add(_T_48, _T_49) @[LongCal.scala 88:33]
        node _T_51 = tail(_T_50, 1) @[LongCal.scala 88:33]
        node _T_52 = sub(_T_51, in_buffer) @[LongCal.scala 88:47]
        node _T_53 = tail(_T_52, 1) @[LongCal.scala 88:47]
        src2 <= _T_53 @[LongCal.scala 88:18]
    node _T_54 = eq(state, UInt<3>("h2")) @[LongCal.scala 90:16]
    when _T_54 : @[LongCal.scala 90:24]
      node _T_55 = sub(in_buffer, UInt<4>("ha")) @[LongCal.scala 90:41]
      node _T_56 = tail(_T_55, 1) @[LongCal.scala 90:41]
      op <= _T_56 @[LongCal.scala 90:28]
    node _T_57 = eq(state, UInt<3>("h4")) @[LongCal.scala 92:16]
    when _T_57 : @[LongCal.scala 92:27]
      src1 <= UInt<1>("h0") @[LongCal.scala 93:14]
      src2 <= UInt<1>("h0") @[LongCal.scala 94:14]
      op <= UInt<1>("h0") @[LongCal.scala 95:12]
      in_buffer <= UInt<1>("h0") @[LongCal.scala 96:19]
    node _T_58 = eq(state, UInt<3>("h4")) @[LongCal.scala 100:33]
    node _T_59 = mux(_T_58, UInt<1>("h1"), UInt<1>("h0")) @[LongCal.scala 100:26]
    io.value.valid <= _T_59 @[LongCal.scala 100:20]
    io.value.bits <= src1 @[LongCal.scala 105:19]


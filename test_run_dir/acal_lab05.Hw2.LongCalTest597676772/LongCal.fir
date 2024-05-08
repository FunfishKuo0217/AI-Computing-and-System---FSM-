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
    node _T_4 = eq(io.key_in, UInt<4>("hf")) @[LongCal.scala 21:24]
    equal <= _T_4 @[LongCal.scala 21:11]
    wire negStart : UInt<1>
    negStart <= UInt<1>("h0")
    node _T_5 = eq(io.key_in, UInt<4>("hd")) @[LongCal.scala 24:27]
    negStart <= _T_5 @[LongCal.scala 24:14]
    wire negEnd : UInt<1>
    negEnd <= UInt<1>("h0")
    node _T_6 = eq(io.key_in, UInt<4>("he")) @[LongCal.scala 27:25]
    negEnd <= _T_6 @[LongCal.scala 27:12]
    reg in_buffer : UInt, clock with :
      reset => (UInt<1>("h0"), in_buffer) @[LongCal.scala 30:28]
    in_buffer <= io.key_in @[LongCal.scala 30:28]
    reg src1 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[LongCal.scala 31:23]
    reg op : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[LongCal.scala 32:21]
    reg src2 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[LongCal.scala 33:23]
    reg state : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[LongCal.scala 39:24]
    node _T_7 = eq(UInt<3>("h2"), state) @[Conditional.scala 37:30]
    when _T_7 : @[Conditional.scala 40:58]
      when equal : @[LongCal.scala 44:24]
        state <= UInt<3>("h4") @[LongCal.scala 45:23]
      else :
        when negStart : @[LongCal.scala 47:31]
          state <= UInt<3>("h6") @[LongCal.scala 48:27]
        else :
          state <= UInt<3>("h3") @[LongCal.scala 50:27]
    else :
      node _T_8 = eq(UInt<3>("h0"), state) @[Conditional.scala 37:30]
      when _T_8 : @[Conditional.scala 39:67]
        when negStart : @[LongCal.scala 55:27]
          state <= UInt<3>("h5") @[LongCal.scala 55:34]
        else :
          state <= UInt<3>("h1") @[LongCal.scala 56:31]
      else :
        node _T_9 = eq(UInt<3>("h1"), state) @[Conditional.scala 37:30]
        when _T_9 : @[Conditional.scala 39:67]
          when equal : @[LongCal.scala 59:25]
            state <= UInt<3>("h4") @[LongCal.scala 59:32]
          when operator : @[LongCal.scala 60:28]
            state <= UInt<3>("h2") @[LongCal.scala 60:35]
        else :
          node _T_10 = eq(UInt<3>("h5"), state) @[Conditional.scala 37:30]
          when _T_10 : @[Conditional.scala 39:67]
            when negEnd : @[LongCal.scala 63:26]
              state <= UInt<3>("h2") @[LongCal.scala 63:33]
          else :
            node _T_11 = eq(UInt<3>("h3"), state) @[Conditional.scala 37:30]
            when _T_11 : @[Conditional.scala 39:67]
              when operator : @[LongCal.scala 66:28]
                state <= UInt<3>("h2") @[LongCal.scala 66:35]
              when equal : @[LongCal.scala 67:25]
                state <= UInt<3>("h4") @[LongCal.scala 67:32]
            else :
              node _T_12 = eq(UInt<3>("h6"), state) @[Conditional.scala 37:30]
              when _T_12 : @[Conditional.scala 39:67]
                when negEnd : @[LongCal.scala 70:25]
                  state <= UInt<3>("h2") @[LongCal.scala 70:32]
              else :
                node _T_13 = eq(UInt<3>("h4"), state) @[Conditional.scala 37:30]
                when _T_13 : @[Conditional.scala 39:67]
                  node _T_14 = eq(io.key_in, UInt<4>("hd")) @[LongCal.scala 73:28]
                  when _T_14 : @[LongCal.scala 73:37]
                    state <= UInt<3>("h5") @[LongCal.scala 74:23]
                  else :
                    state <= UInt<3>("h1") @[LongCal.scala 76:23]
    node _T_15 = eq(state, UInt<3>("h1")) @[LongCal.scala 82:16]
    when _T_15 : @[LongCal.scala 82:26]
      node _T_16 = dshl(src1, UInt<2>("h3")) @[LongCal.scala 83:22]
      node _T_17 = dshl(src1, UInt<1>("h1")) @[LongCal.scala 83:36]
      node _T_18 = add(_T_16, _T_17) @[LongCal.scala 83:29]
      node _T_19 = tail(_T_18, 1) @[LongCal.scala 83:29]
      node _T_20 = add(_T_19, in_buffer) @[LongCal.scala 83:43]
      node _T_21 = tail(_T_20, 1) @[LongCal.scala 83:43]
      src1 <= _T_21 @[LongCal.scala 83:14]
    node _T_22 = eq(state, UInt<3>("h5")) @[LongCal.scala 85:16]
    when _T_22 : @[LongCal.scala 85:29]
      node _T_23 = neq(in_buffer, UInt<4>("hd")) @[LongCal.scala 86:25]
      node _T_24 = neq(in_buffer, UInt<4>("hb")) @[LongCal.scala 86:49]
      node _T_25 = and(_T_23, _T_24) @[LongCal.scala 86:35]
      node _T_26 = neq(in_buffer, UInt<4>("he")) @[LongCal.scala 86:73]
      node _T_27 = and(_T_25, _T_26) @[LongCal.scala 86:59]
      when _T_27 : @[LongCal.scala 86:83]
        node _T_28 = dshl(src1, UInt<2>("h3")) @[LongCal.scala 87:26]
        node _T_29 = dshl(src1, UInt<1>("h1")) @[LongCal.scala 87:40]
        node _T_30 = add(_T_28, _T_29) @[LongCal.scala 87:33]
        node _T_31 = tail(_T_30, 1) @[LongCal.scala 87:33]
        node _T_32 = sub(_T_31, in_buffer) @[LongCal.scala 87:47]
        node _T_33 = tail(_T_32, 1) @[LongCal.scala 87:47]
        src1 <= _T_33 @[LongCal.scala 87:18]
    node _T_34 = eq(state, UInt<3>("h3")) @[LongCal.scala 91:16]
    when _T_34 : @[LongCal.scala 91:26]
      node _T_35 = dshl(src2, UInt<2>("h3")) @[LongCal.scala 92:22]
      node _T_36 = dshl(src2, UInt<1>("h1")) @[LongCal.scala 92:36]
      node _T_37 = add(_T_35, _T_36) @[LongCal.scala 92:29]
      node _T_38 = tail(_T_37, 1) @[LongCal.scala 92:29]
      node _T_39 = add(_T_38, in_buffer) @[LongCal.scala 92:43]
      node _T_40 = tail(_T_39, 1) @[LongCal.scala 92:43]
      src2 <= _T_40 @[LongCal.scala 92:14]
    node _T_41 = eq(state, UInt<3>("h6")) @[LongCal.scala 94:16]
    when _T_41 : @[LongCal.scala 94:29]
      node _T_42 = neq(in_buffer, UInt<4>("hd")) @[LongCal.scala 95:25]
      node _T_43 = neq(in_buffer, UInt<4>("hb")) @[LongCal.scala 95:49]
      node _T_44 = and(_T_42, _T_43) @[LongCal.scala 95:35]
      node _T_45 = neq(in_buffer, UInt<4>("he")) @[LongCal.scala 95:73]
      node _T_46 = and(_T_44, _T_45) @[LongCal.scala 95:59]
      when _T_46 : @[LongCal.scala 95:83]
        node _T_47 = dshl(src2, UInt<2>("h3")) @[LongCal.scala 96:26]
        node _T_48 = dshl(src2, UInt<1>("h1")) @[LongCal.scala 96:40]
        node _T_49 = add(_T_47, _T_48) @[LongCal.scala 96:33]
        node _T_50 = tail(_T_49, 1) @[LongCal.scala 96:33]
        node _T_51 = sub(_T_50, in_buffer) @[LongCal.scala 96:47]
        node _T_52 = tail(_T_51, 1) @[LongCal.scala 96:47]
        src2 <= _T_52 @[LongCal.scala 96:18]
    node _T_53 = eq(state, UInt<3>("h2")) @[LongCal.scala 99:16]
    when _T_53 : @[LongCal.scala 99:24]
      node _T_54 = sub(in_buffer, UInt<4>("ha")) @[LongCal.scala 99:41]
      node _T_55 = tail(_T_54, 1) @[LongCal.scala 99:41]
      op <= _T_55 @[LongCal.scala 99:28]
    node _T_56 = eq(state, UInt<3>("h4")) @[LongCal.scala 101:16]
    when _T_56 : @[LongCal.scala 101:27]
      src1 <= UInt<1>("h0") @[LongCal.scala 102:14]
      src2 <= UInt<1>("h0") @[LongCal.scala 103:14]
      op <= UInt<1>("h0") @[LongCal.scala 104:12]
      in_buffer <= UInt<1>("h0") @[LongCal.scala 105:19]
    node _T_57 = eq(state, UInt<3>("h4")) @[LongCal.scala 108:33]
    node _T_58 = mux(_T_57, UInt<1>("h1"), UInt<1>("h0")) @[LongCal.scala 108:26]
    io.value.valid <= _T_58 @[LongCal.scala 108:20]
    node _T_59 = add(src1, src2) @[LongCal.scala 109:27]
    node _T_60 = tail(_T_59, 1) @[LongCal.scala 109:27]
    io.value.bits <= _T_60 @[LongCal.scala 109:19]
    node _T_61 = add(src1, src2) @[LongCal.scala 111:22]
    node _T_62 = tail(_T_61, 1) @[LongCal.scala 111:22]
    node _T_63 = sub(src1, src2) @[LongCal.scala 112:22]
    node _T_64 = tail(_T_63, 1) @[LongCal.scala 112:22]
    node _T_65 = eq(UInt<1>("h0"), op) @[Mux.scala 80:60]
    node _T_66 = mux(_T_65, _T_62, UInt<1>("h0")) @[Mux.scala 80:57]
    node _T_67 = eq(UInt<1>("h1"), op) @[Mux.scala 80:60]
    node _T_68 = mux(_T_67, _T_64, _T_66) @[Mux.scala 80:57]


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
    wire neg : UInt<1>
    neg <= UInt<1>("h0")
    node _T_5 = eq(io.key_in, UInt<4>("hd")) @[LongCal.scala 24:22]
    neg <= _T_5 @[LongCal.scala 24:9]
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
    reg ans : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[LongCal.scala 34:22]
    reg state : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[LongCal.scala 40:24]
    node _T_7 = eq(UInt<3>("h0"), state) @[Conditional.scala 37:30]
    when _T_7 : @[Conditional.scala 40:58]
      when neg : @[LongCal.scala 45:22]
        state <= UInt<3>("h5") @[LongCal.scala 46:23]
      else :
        state <= UInt<3>("h1") @[LongCal.scala 47:31]
    else :
      node _T_8 = eq(UInt<3>("h1"), state) @[Conditional.scala 37:30]
      when _T_8 : @[Conditional.scala 39:67]
        when equal : @[LongCal.scala 50:25]
          state <= UInt<3>("h4") @[LongCal.scala 50:32]
        when operator : @[LongCal.scala 51:28]
          state <= UInt<3>("h2") @[LongCal.scala 51:35]
      else :
        node _T_9 = eq(UInt<3>("h5"), state) @[Conditional.scala 37:30]
        when _T_9 : @[Conditional.scala 39:67]
          when negEnd : @[LongCal.scala 54:26]
            state <= UInt<3>("h2") @[LongCal.scala 54:33]
        else :
          node _T_10 = eq(UInt<3>("h2"), state) @[Conditional.scala 37:30]
          when _T_10 : @[Conditional.scala 39:67]
            when neg : @[LongCal.scala 57:22]
              state <= UInt<3>("h6") @[LongCal.scala 58:23]
            else :
              when equal : @[LongCal.scala 59:30]
                state <= UInt<3>("h4") @[LongCal.scala 60:23]
              else :
                state <= UInt<3>("h3") @[LongCal.scala 61:31]
          else :
            node _T_11 = eq(UInt<3>("h3"), state) @[Conditional.scala 37:30]
            when _T_11 : @[Conditional.scala 39:67]
              when operator : @[LongCal.scala 64:28]
                state <= UInt<3>("h2") @[LongCal.scala 64:35]
              when equal : @[LongCal.scala 65:25]
                state <= UInt<3>("h4") @[LongCal.scala 65:32]
            else :
              node _T_12 = eq(UInt<3>("h6"), state) @[Conditional.scala 37:30]
              when _T_12 : @[Conditional.scala 39:67]
                when negEnd : @[LongCal.scala 68:25]
                  state <= UInt<3>("h2") @[LongCal.scala 68:32]
              else :
                node _T_13 = eq(UInt<3>("h4"), state) @[Conditional.scala 37:30]
                when _T_13 : @[Conditional.scala 39:67]
                  when neg : @[LongCal.scala 71:22]
                    state <= UInt<3>("h5") @[LongCal.scala 72:23]
                  else :
                    state <= UInt<3>("h1") @[LongCal.scala 73:31]
    node _T_14 = eq(state, UInt<3>("h1")) @[LongCal.scala 78:16]
    when _T_14 : @[LongCal.scala 78:26]
      node _T_15 = dshl(src1, UInt<2>("h3")) @[LongCal.scala 79:22]
      node _T_16 = dshl(src1, UInt<1>("h1")) @[LongCal.scala 79:36]
      node _T_17 = add(_T_15, _T_16) @[LongCal.scala 79:29]
      node _T_18 = tail(_T_17, 1) @[LongCal.scala 79:29]
      node _T_19 = add(_T_18, in_buffer) @[LongCal.scala 79:43]
      node _T_20 = tail(_T_19, 1) @[LongCal.scala 79:43]
      src1 <= _T_20 @[LongCal.scala 79:14]
    node _T_21 = eq(state, UInt<3>("h5")) @[LongCal.scala 81:16]
    when _T_21 : @[LongCal.scala 81:29]
      node _T_22 = neq(in_buffer, UInt<4>("hd")) @[LongCal.scala 82:25]
      node _T_23 = neq(in_buffer, UInt<4>("hb")) @[LongCal.scala 82:49]
      node _T_24 = and(_T_22, _T_23) @[LongCal.scala 82:35]
      node _T_25 = neq(in_buffer, UInt<4>("he")) @[LongCal.scala 82:73]
      node _T_26 = and(_T_24, _T_25) @[LongCal.scala 82:59]
      when _T_26 : @[LongCal.scala 82:83]
        node _T_27 = dshl(src1, UInt<2>("h3")) @[LongCal.scala 83:26]
        node _T_28 = dshl(src1, UInt<1>("h1")) @[LongCal.scala 83:40]
        node _T_29 = add(_T_27, _T_28) @[LongCal.scala 83:33]
        node _T_30 = tail(_T_29, 1) @[LongCal.scala 83:33]
        node _T_31 = sub(_T_30, in_buffer) @[LongCal.scala 83:47]
        node _T_32 = tail(_T_31, 1) @[LongCal.scala 83:47]
        src1 <= _T_32 @[LongCal.scala 83:18]
    node _T_33 = eq(state, UInt<3>("h3")) @[LongCal.scala 87:16]
    when _T_33 : @[LongCal.scala 87:26]
      node _T_34 = dshl(src2, UInt<2>("h3")) @[LongCal.scala 88:22]
      node _T_35 = dshl(src2, UInt<1>("h1")) @[LongCal.scala 88:36]
      node _T_36 = add(_T_34, _T_35) @[LongCal.scala 88:29]
      node _T_37 = tail(_T_36, 1) @[LongCal.scala 88:29]
      node _T_38 = add(_T_37, in_buffer) @[LongCal.scala 88:43]
      node _T_39 = tail(_T_38, 1) @[LongCal.scala 88:43]
      src2 <= _T_39 @[LongCal.scala 88:14]
    node _T_40 = eq(state, UInt<3>("h6")) @[LongCal.scala 90:16]
    when _T_40 : @[LongCal.scala 90:29]
      node _T_41 = neq(in_buffer, UInt<4>("hd")) @[LongCal.scala 91:25]
      node _T_42 = neq(in_buffer, UInt<4>("hb")) @[LongCal.scala 91:49]
      node _T_43 = and(_T_41, _T_42) @[LongCal.scala 91:35]
      node _T_44 = neq(in_buffer, UInt<4>("he")) @[LongCal.scala 91:73]
      node _T_45 = and(_T_43, _T_44) @[LongCal.scala 91:59]
      when _T_45 : @[LongCal.scala 91:83]
        node _T_46 = dshl(src2, UInt<2>("h3")) @[LongCal.scala 92:26]
        node _T_47 = dshl(src2, UInt<1>("h1")) @[LongCal.scala 92:40]
        node _T_48 = add(_T_46, _T_47) @[LongCal.scala 92:33]
        node _T_49 = tail(_T_48, 1) @[LongCal.scala 92:33]
        node _T_50 = sub(_T_49, in_buffer) @[LongCal.scala 92:47]
        node _T_51 = tail(_T_50, 1) @[LongCal.scala 92:47]
        src2 <= _T_51 @[LongCal.scala 92:18]
    node _T_52 = eq(state, UInt<3>("h2")) @[LongCal.scala 95:16]
    when _T_52 : @[LongCal.scala 95:24]
      node _T_53 = sub(in_buffer, UInt<4>("ha")) @[LongCal.scala 96:25]
      node _T_54 = tail(_T_53, 1) @[LongCal.scala 96:25]
      op <= _T_54 @[LongCal.scala 96:12]
    node _T_55 = eq(state, UInt<3>("h4")) @[LongCal.scala 99:16]
    when _T_55 : @[LongCal.scala 99:27]
      src1 <= UInt<1>("h0") @[LongCal.scala 100:14]
      src2 <= UInt<1>("h0") @[LongCal.scala 101:14]
      op <= UInt<1>("h0") @[LongCal.scala 102:12]
      in_buffer <= UInt<1>("h0") @[LongCal.scala 103:19]
    node _T_56 = eq(state, UInt<3>("h4")) @[LongCal.scala 106:33]
    node _T_57 = mux(_T_56, UInt<1>("h1"), UInt<1>("h0")) @[LongCal.scala 106:26]
    io.value.valid <= _T_57 @[LongCal.scala 106:20]
    node _T_58 = add(src1, src2) @[LongCal.scala 108:22]
    node _T_59 = tail(_T_58, 1) @[LongCal.scala 108:22]
    node _T_60 = sub(src1, src2) @[LongCal.scala 109:22]
    node _T_61 = tail(_T_60, 1) @[LongCal.scala 109:22]
    node _T_62 = eq(UInt<1>("h0"), op) @[Mux.scala 80:60]
    node _T_63 = mux(_T_62, _T_59, UInt<1>("h0")) @[Mux.scala 80:57]
    node _T_64 = eq(UInt<1>("h1"), op) @[Mux.scala 80:60]
    node _T_65 = mux(_T_64, _T_61, _T_63) @[Mux.scala 80:57]
    io.value.bits <= _T_65 @[LongCal.scala 107:19]


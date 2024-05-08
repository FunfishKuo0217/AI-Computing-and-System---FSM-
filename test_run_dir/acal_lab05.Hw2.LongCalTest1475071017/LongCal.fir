circuit LongCal :
  module LongCal :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip key_in : UInt<4>, value : { valid : UInt<1>, bits : UInt<32>}}

    wire operator : UInt<1>
    operator <= UInt<1>("h0")
    wire num : UInt<1>
    num <= UInt<1>("h0")
    wire equal : UInt<1>
    equal <= UInt<1>("h0")
    wire negStart : UInt<1>
    negStart <= UInt<1>("h0")
    wire negEnd : UInt<1>
    negEnd <= UInt<1>("h0")
    node _T = geq(io.key_in, UInt<4>("ha")) @[LongCal.scala 19:27]
    node _T_1 = leq(io.key_in, UInt<4>("hc")) @[LongCal.scala 19:48]
    node _T_2 = and(_T, _T_1) @[LongCal.scala 19:35]
    operator <= _T_2 @[LongCal.scala 19:14]
    node _T_3 = lt(io.key_in, UInt<4>("ha")) @[LongCal.scala 20:22]
    num <= _T_3 @[LongCal.scala 20:9]
    node _T_4 = eq(io.key_in, UInt<4>("hf")) @[LongCal.scala 21:24]
    equal <= _T_4 @[LongCal.scala 21:11]
    node _T_5 = eq(io.key_in, UInt<4>("hd")) @[LongCal.scala 22:27]
    negStart <= _T_5 @[LongCal.scala 22:14]
    node _T_6 = eq(io.key_in, UInt<4>("he")) @[LongCal.scala 23:25]
    negEnd <= _T_6 @[LongCal.scala 23:12]
    reg in_buffer : UInt, clock with :
      reset => (UInt<1>("h0"), in_buffer) @[LongCal.scala 26:28]
    in_buffer <= io.key_in @[LongCal.scala 26:28]
    reg src1 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[LongCal.scala 27:23]
    reg op : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[LongCal.scala 28:21]
    reg src2 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[LongCal.scala 29:23]
    reg regSrc : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[LongCal.scala 30:25]
    reg regSrc1Neg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[LongCal.scala 31:29]
    reg regSrc2Neg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[LongCal.scala 32:29]
    reg state : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[LongCal.scala 38:24]
    node _T_7 = eq(UInt<3>("h0"), state) @[Conditional.scala 37:30]
    when _T_7 : @[Conditional.scala 40:58]
      when negStart : @[LongCal.scala 44:27]
        state <= UInt<3>("h5") @[LongCal.scala 44:35]
      else :
        state <= UInt<3>("h1") @[LongCal.scala 45:32]
    else :
      node _T_8 = eq(UInt<3>("h1"), state) @[Conditional.scala 37:30]
      when _T_8 : @[Conditional.scala 39:67]
        when negEnd : @[LongCal.scala 48:25]
          state <= UInt<3>("h6") @[LongCal.scala 48:33]
        else :
          when equal : @[LongCal.scala 49:29]
            state <= UInt<3>("h4") @[LongCal.scala 49:36]
          else :
            when operator : @[LongCal.scala 50:33]
              state <= UInt<3>("h2") @[LongCal.scala 50:40]
      else :
        node _T_9 = eq(UInt<3>("h5"), state) @[Conditional.scala 37:30]
        when _T_9 : @[Conditional.scala 39:67]
          when num : @[LongCal.scala 54:22]
            node _T_10 = eq(regSrc, UInt<1>("h0")) @[LongCal.scala 54:37]
            node _T_11 = mux(_T_10, UInt<3>("h1"), UInt<3>("h3")) @[LongCal.scala 54:36]
            state <= _T_11 @[LongCal.scala 54:30]
          else :
            when equal : @[LongCal.scala 55:30]
              state <= UInt<3>("h4") @[LongCal.scala 55:37]
        else :
          node _T_12 = eq(UInt<3>("h6"), state) @[Conditional.scala 37:30]
          when _T_12 : @[Conditional.scala 39:67]
            when equal : @[LongCal.scala 58:24]
              state <= UInt<3>("h4") @[LongCal.scala 58:31]
            else :
              when operator : @[LongCal.scala 59:32]
                state <= UInt<3>("h2") @[LongCal.scala 59:38]
          else :
            node _T_13 = eq(UInt<3>("h2"), state) @[Conditional.scala 37:30]
            when _T_13 : @[Conditional.scala 39:67]
              when num : @[LongCal.scala 62:23]
                state <= UInt<3>("h3") @[LongCal.scala 62:30]
              else :
                when negStart : @[LongCal.scala 63:33]
                  state <= UInt<3>("h5") @[LongCal.scala 63:40]
            else :
              node _T_14 = eq(UInt<3>("h3"), state) @[Conditional.scala 37:30]
              when _T_14 : @[Conditional.scala 39:67]
                when operator : @[LongCal.scala 66:28]
                  state <= UInt<3>("h2") @[LongCal.scala 66:35]
                else :
                  when equal : @[LongCal.scala 67:30]
                    state <= UInt<3>("h4") @[LongCal.scala 67:37]
                  else :
                    when negEnd : @[LongCal.scala 68:31]
                      state <= UInt<3>("h6") @[LongCal.scala 68:38]
              else :
                node _T_15 = eq(UInt<3>("h4"), state) @[Conditional.scala 37:30]
                when _T_15 : @[Conditional.scala 39:67]
                  state <= UInt<3>("h0") @[LongCal.scala 70:27]
    node _T_16 = eq(state, UInt<3>("h1")) @[LongCal.scala 75:16]
    when _T_16 : @[LongCal.scala 75:26]
      node _T_17 = dshl(src1, UInt<2>("h3")) @[LongCal.scala 75:40]
      node _T_18 = dshl(src1, UInt<1>("h1")) @[LongCal.scala 75:54]
      node _T_19 = add(_T_17, _T_18) @[LongCal.scala 75:47]
      node _T_20 = tail(_T_19, 1) @[LongCal.scala 75:47]
      node _T_21 = add(_T_20, in_buffer) @[LongCal.scala 75:61]
      node _T_22 = tail(_T_21, 1) @[LongCal.scala 75:61]
      src1 <= _T_22 @[LongCal.scala 75:32]
    node _T_23 = eq(state, UInt<3>("h3")) @[LongCal.scala 76:16]
    when _T_23 : @[LongCal.scala 76:26]
      node _T_24 = dshl(src2, UInt<2>("h3")) @[LongCal.scala 76:40]
      node _T_25 = dshl(src2, UInt<1>("h1")) @[LongCal.scala 76:54]
      node _T_26 = add(_T_24, _T_25) @[LongCal.scala 76:47]
      node _T_27 = tail(_T_26, 1) @[LongCal.scala 76:47]
      node _T_28 = add(_T_27, in_buffer) @[LongCal.scala 76:61]
      node _T_29 = tail(_T_28, 1) @[LongCal.scala 76:61]
      src2 <= _T_29 @[LongCal.scala 76:32]
    node _T_30 = eq(state, UInt<3>("h5")) @[LongCal.scala 77:16]
    when _T_30 : @[LongCal.scala 77:30]
      node _T_31 = eq(regSrc, UInt<1>("h0")) @[LongCal.scala 79:14]
      when _T_31 : @[LongCal.scala 79:23]
        regSrc1Neg <= UInt<1>("h1") @[LongCal.scala 79:35]
      else :
        regSrc2Neg <= UInt<1>("h1") @[LongCal.scala 80:31]
    node _T_32 = eq(state, UInt<3>("h6")) @[LongCal.scala 83:16]
    when _T_32 : @[LongCal.scala 83:28]
      node _T_33 = eq(regSrc, UInt<1>("h0")) @[LongCal.scala 84:14]
      when _T_33 : @[LongCal.scala 84:22]
        node _T_34 = not(src1) @[LongCal.scala 85:21]
        node _T_35 = add(_T_34, UInt<1>("h1")) @[LongCal.scala 85:27]
        node _T_36 = tail(_T_35, 1) @[LongCal.scala 85:27]
        src1 <= _T_36 @[LongCal.scala 85:18]
        regSrc1Neg <= UInt<1>("h0") @[LongCal.scala 86:24]
      else :
        node _T_37 = not(src2) @[LongCal.scala 89:21]
        node _T_38 = add(_T_37, UInt<1>("h1")) @[LongCal.scala 89:27]
        node _T_39 = tail(_T_38, 1) @[LongCal.scala 89:27]
        src2 <= _T_39 @[LongCal.scala 89:18]
        regSrc2Neg <= UInt<1>("h0") @[LongCal.scala 90:24]
    node _T_40 = eq(state, UInt<3>("h2")) @[LongCal.scala 93:16]
    when _T_40 : @[LongCal.scala 93:24]
      regSrc <= UInt<1>("h1") @[LongCal.scala 94:16]
      node _T_41 = sub(in_buffer, UInt<4>("ha")) @[LongCal.scala 95:25]
      node _T_42 = tail(_T_41, 1) @[LongCal.scala 95:25]
      op <= _T_42 @[LongCal.scala 95:12]
      when regSrc : @[LongCal.scala 96:21]
        node _T_43 = add(src1, src2) @[LongCal.scala 98:30]
        node _T_44 = tail(_T_43, 1) @[LongCal.scala 98:30]
        node _T_45 = sub(src1, src2) @[LongCal.scala 99:30]
        node _T_46 = tail(_T_45, 1) @[LongCal.scala 99:30]
        node _T_47 = eq(UInt<1>("h0"), op) @[Mux.scala 80:60]
        node _T_48 = mux(_T_47, _T_44, UInt<1>("h0")) @[Mux.scala 80:57]
        node _T_49 = eq(UInt<1>("h1"), op) @[Mux.scala 80:60]
        node _T_50 = mux(_T_49, _T_46, _T_48) @[Mux.scala 80:57]
        src1 <= _T_50 @[LongCal.scala 97:18]
        src2 <= UInt<1>("h0") @[LongCal.scala 101:18]
    node _T_51 = eq(state, UInt<3>("h4")) @[LongCal.scala 106:16]
    when _T_51 : @[LongCal.scala 106:27]
      src1 <= UInt<1>("h0") @[LongCal.scala 107:14]
      src2 <= UInt<1>("h0") @[LongCal.scala 108:14]
      op <= UInt<1>("h0") @[LongCal.scala 109:12]
      in_buffer <= UInt<1>("h0") @[LongCal.scala 110:19]
      regSrc1Neg <= UInt<1>("h0") @[LongCal.scala 111:20]
      regSrc2Neg <= UInt<1>("h0") @[LongCal.scala 112:20]
      regSrc <= UInt<1>("h0") @[LongCal.scala 113:16]
    node _T_52 = eq(state, UInt<3>("h4")) @[LongCal.scala 117:33]
    node _T_53 = mux(_T_52, UInt<1>("h1"), UInt<1>("h0")) @[LongCal.scala 117:26]
    io.value.valid <= _T_53 @[LongCal.scala 117:20]
    node _T_54 = add(src1, src2) @[LongCal.scala 118:26]
    node _T_55 = tail(_T_54, 1) @[LongCal.scala 118:26]
    io.value.bits <= _T_55 @[LongCal.scala 118:19]


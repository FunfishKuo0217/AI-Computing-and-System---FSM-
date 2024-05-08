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
    reg in_buffer : UInt, clock with :
      reset => (UInt<1>("h0"), in_buffer) @[LongCal.scala 27:28]
    in_buffer <= io.key_in @[LongCal.scala 27:28]
    reg src1 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[LongCal.scala 28:23]
    reg op : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[LongCal.scala 29:21]
    reg src2 : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[LongCal.scala 30:23]
    reg ans : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[LongCal.scala 31:22]
    reg state : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[LongCal.scala 37:24]
    node _T_6 = eq(UInt<3>("h0"), state) @[Conditional.scala 37:30]
    when _T_6 : @[Conditional.scala 40:58]
      when neg : @[LongCal.scala 42:22]
        state <= UInt<3>("h5") @[LongCal.scala 43:23]
      else :
        state <= UInt<3>("h1") @[LongCal.scala 44:31]
    else :
      node _T_7 = eq(UInt<3>("h1"), state) @[Conditional.scala 37:30]
      when _T_7 : @[Conditional.scala 39:67]
        when equal : @[LongCal.scala 47:25]
          state <= UInt<3>("h4") @[LongCal.scala 47:32]
        when operator : @[LongCal.scala 48:28]
          state <= UInt<3>("h2") @[LongCal.scala 48:35]
      else :
        node _T_8 = eq(UInt<3>("h5"), state) @[Conditional.scala 37:30]
        when _T_8 : @[Conditional.scala 39:67]
          when equal : @[LongCal.scala 51:25]
            state <= UInt<3>("h4") @[LongCal.scala 51:32]
          when operator : @[LongCal.scala 52:28]
            state <= UInt<3>("h2") @[LongCal.scala 52:35]
        else :
          node _T_9 = eq(UInt<3>("h2"), state) @[Conditional.scala 37:30]
          when _T_9 : @[Conditional.scala 39:67]
            when neg : @[LongCal.scala 55:22]
              state <= UInt<3>("h6") @[LongCal.scala 56:23]
            else :
              state <= UInt<3>("h3") @[LongCal.scala 57:31]
          else :
            node _T_10 = eq(UInt<3>("h3"), state) @[Conditional.scala 37:30]
            when _T_10 : @[Conditional.scala 39:67]
              when operator : @[LongCal.scala 60:27]
                state <= UInt<3>("h2") @[LongCal.scala 60:34]
              when equal : @[LongCal.scala 61:25]
                state <= UInt<3>("h4") @[LongCal.scala 61:32]
            else :
              node _T_11 = eq(UInt<3>("h6"), state) @[Conditional.scala 37:30]
              when _T_11 : @[Conditional.scala 39:67]
                when operator : @[LongCal.scala 64:27]
                  state <= UInt<3>("h2") @[LongCal.scala 64:34]
                when equal : @[LongCal.scala 65:25]
                  state <= UInt<3>("h4") @[LongCal.scala 65:32]
              else :
                node _T_12 = eq(UInt<3>("h4"), state) @[Conditional.scala 37:30]
                when _T_12 : @[Conditional.scala 39:67]
                  when neg : @[LongCal.scala 68:22]
                    state <= UInt<3>("h5") @[LongCal.scala 69:23]
                  else :
                    state <= UInt<3>("h1") @[LongCal.scala 70:31]
    node _T_13 = eq(state, UInt<3>("h1")) @[LongCal.scala 75:16]
    when _T_13 : @[LongCal.scala 75:26]
      node _T_14 = dshl(src1, UInt<2>("h3")) @[LongCal.scala 75:40]
      node _T_15 = dshl(src1, UInt<1>("h1")) @[LongCal.scala 75:54]
      node _T_16 = add(_T_14, _T_15) @[LongCal.scala 75:47]
      node _T_17 = tail(_T_16, 1) @[LongCal.scala 75:47]
      node _T_18 = add(_T_17, in_buffer) @[LongCal.scala 75:61]
      node _T_19 = tail(_T_18, 1) @[LongCal.scala 75:61]
      src1 <= _T_19 @[LongCal.scala 75:32]
    node _T_20 = eq(state, UInt<3>("h5")) @[LongCal.scala 76:16]
    when _T_20 : @[LongCal.scala 76:29]
      node _T_21 = neq(in_buffer, UInt<4>("hd")) @[LongCal.scala 77:25]
      node _T_22 = neq(in_buffer, UInt<4>("hb")) @[LongCal.scala 77:49]
      node _T_23 = and(_T_21, _T_22) @[LongCal.scala 77:35]
      node _T_24 = neq(in_buffer, UInt<4>("he")) @[LongCal.scala 77:73]
      node _T_25 = and(_T_23, _T_24) @[LongCal.scala 77:59]
      when _T_25 : @[LongCal.scala 77:83]
        src1 <= UInt<1>("h1") @[LongCal.scala 79:18]
    node _T_26 = eq(state, UInt<3>("h3")) @[LongCal.scala 83:16]
    when _T_26 : @[LongCal.scala 83:26]
      node _T_27 = dshl(src2, UInt<2>("h3")) @[LongCal.scala 83:40]
      node _T_28 = dshl(src2, UInt<1>("h1")) @[LongCal.scala 83:54]
      node _T_29 = add(_T_27, _T_28) @[LongCal.scala 83:47]
      node _T_30 = tail(_T_29, 1) @[LongCal.scala 83:47]
      node _T_31 = add(_T_30, in_buffer) @[LongCal.scala 83:61]
      node _T_32 = tail(_T_31, 1) @[LongCal.scala 83:61]
      src2 <= _T_32 @[LongCal.scala 83:32]
    node _T_33 = eq(state, UInt<3>("h6")) @[LongCal.scala 84:16]
    when _T_33 : @[LongCal.scala 84:29]
      node _T_34 = neq(in_buffer, UInt<4>("hd")) @[LongCal.scala 85:25]
      node _T_35 = neq(in_buffer, UInt<4>("hb")) @[LongCal.scala 85:49]
      node _T_36 = and(_T_34, _T_35) @[LongCal.scala 85:35]
      node _T_37 = neq(in_buffer, UInt<4>("he")) @[LongCal.scala 85:73]
      node _T_38 = and(_T_36, _T_37) @[LongCal.scala 85:59]
      when _T_38 : @[LongCal.scala 85:83]
        node _T_39 = dshl(src2, UInt<2>("h3")) @[LongCal.scala 86:26]
        node _T_40 = dshl(src2, UInt<1>("h1")) @[LongCal.scala 86:40]
        node _T_41 = add(_T_39, _T_40) @[LongCal.scala 86:33]
        node _T_42 = tail(_T_41, 1) @[LongCal.scala 86:33]
        node _T_43 = sub(_T_42, in_buffer) @[LongCal.scala 86:47]
        node _T_44 = tail(_T_43, 1) @[LongCal.scala 86:47]
        src2 <= _T_44 @[LongCal.scala 86:18]
    node _T_45 = eq(state, UInt<3>("h2")) @[LongCal.scala 89:16]
    when _T_45 : @[LongCal.scala 89:24]
      node _T_46 = sub(in_buffer, UInt<4>("ha")) @[LongCal.scala 90:25]
      node _T_47 = tail(_T_46, 1) @[LongCal.scala 90:25]
      op <= _T_47 @[LongCal.scala 90:12]
    node _T_48 = eq(state, UInt<3>("h4")) @[LongCal.scala 93:16]
    when _T_48 : @[LongCal.scala 93:27]
      src1 <= UInt<1>("h0") @[LongCal.scala 94:14]
      src2 <= UInt<1>("h0") @[LongCal.scala 95:14]
      op <= UInt<1>("h0") @[LongCal.scala 96:12]
      in_buffer <= UInt<1>("h0") @[LongCal.scala 97:19]
    node _T_49 = eq(state, UInt<3>("h4")) @[LongCal.scala 100:33]
    node _T_50 = mux(_T_49, UInt<1>("h1"), UInt<1>("h0")) @[LongCal.scala 100:26]
    io.value.valid <= _T_50 @[LongCal.scala 100:20]
    node _T_51 = add(src1, src2) @[LongCal.scala 102:22]
    node _T_52 = tail(_T_51, 1) @[LongCal.scala 102:22]
    node _T_53 = sub(src1, src2) @[LongCal.scala 103:22]
    node _T_54 = tail(_T_53, 1) @[LongCal.scala 103:22]
    node _T_55 = eq(UInt<1>("h0"), op) @[Mux.scala 80:60]
    node _T_56 = mux(_T_55, _T_52, UInt<1>("h0")) @[Mux.scala 80:57]
    node _T_57 = eq(UInt<1>("h1"), op) @[Mux.scala 80:60]
    node _T_58 = mux(_T_57, _T_54, _T_56) @[Mux.scala 80:57]
    io.value.bits <= _T_58 @[LongCal.scala 101:19]


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
      src1 <= UInt<2>("h3") @[LongCal.scala 77:14]
    node _T_14 = eq(state, UInt<3>("h5")) @[LongCal.scala 79:16]
    when _T_14 : @[LongCal.scala 79:29]
      node _T_15 = neq(in_buffer, UInt<4>("hd")) @[LongCal.scala 80:25]
      node _T_16 = neq(in_buffer, UInt<4>("hb")) @[LongCal.scala 80:49]
      node _T_17 = and(_T_15, _T_16) @[LongCal.scala 80:35]
      node _T_18 = neq(in_buffer, UInt<4>("he")) @[LongCal.scala 80:73]
      node _T_19 = and(_T_17, _T_18) @[LongCal.scala 80:59]
      when _T_19 : @[LongCal.scala 80:83]
        src1 <= UInt<1>("h1") @[LongCal.scala 82:18]
    node _T_20 = eq(state, UInt<3>("h3")) @[LongCal.scala 86:16]
    when _T_20 : @[LongCal.scala 86:26]
      src2 <= UInt<3>("h4") @[LongCal.scala 88:14]
    node _T_21 = eq(state, UInt<3>("h6")) @[LongCal.scala 90:16]
    when _T_21 : @[LongCal.scala 90:29]
      node _T_22 = neq(in_buffer, UInt<4>("hd")) @[LongCal.scala 91:25]
      node _T_23 = neq(in_buffer, UInt<4>("hb")) @[LongCal.scala 91:49]
      node _T_24 = and(_T_22, _T_23) @[LongCal.scala 91:35]
      node _T_25 = neq(in_buffer, UInt<4>("he")) @[LongCal.scala 91:73]
      node _T_26 = and(_T_24, _T_25) @[LongCal.scala 91:59]
      when _T_26 : @[LongCal.scala 91:83]
        src2 <= UInt<2>("h2") @[LongCal.scala 93:18]
    node _T_27 = eq(state, UInt<3>("h2")) @[LongCal.scala 96:16]
    when _T_27 : @[LongCal.scala 96:24]
      node _T_28 = sub(in_buffer, UInt<4>("ha")) @[LongCal.scala 97:25]
      node _T_29 = tail(_T_28, 1) @[LongCal.scala 97:25]
      op <= _T_29 @[LongCal.scala 97:12]
    node _T_30 = eq(state, UInt<3>("h4")) @[LongCal.scala 100:16]
    when _T_30 : @[LongCal.scala 100:27]
      src1 <= UInt<1>("h0") @[LongCal.scala 101:14]
      src2 <= UInt<1>("h0") @[LongCal.scala 102:14]
      op <= UInt<1>("h0") @[LongCal.scala 103:12]
      in_buffer <= UInt<1>("h0") @[LongCal.scala 104:19]
    node _T_31 = eq(state, UInt<3>("h4")) @[LongCal.scala 107:33]
    node _T_32 = mux(_T_31, UInt<1>("h1"), UInt<1>("h0")) @[LongCal.scala 107:26]
    io.value.valid <= _T_32 @[LongCal.scala 107:20]
    node _T_33 = add(src1, src2) @[LongCal.scala 109:22]
    node _T_34 = tail(_T_33, 1) @[LongCal.scala 109:22]
    node _T_35 = sub(src1, src2) @[LongCal.scala 110:22]
    node _T_36 = tail(_T_35, 1) @[LongCal.scala 110:22]
    node _T_37 = eq(UInt<1>("h0"), op) @[Mux.scala 80:60]
    node _T_38 = mux(_T_37, _T_34, UInt<1>("h0")) @[Mux.scala 80:57]
    node _T_39 = eq(UInt<1>("h1"), op) @[Mux.scala 80:60]
    node _T_40 = mux(_T_39, _T_36, _T_38) @[Mux.scala 80:57]
    io.value.bits <= _T_40 @[LongCal.scala 108:19]


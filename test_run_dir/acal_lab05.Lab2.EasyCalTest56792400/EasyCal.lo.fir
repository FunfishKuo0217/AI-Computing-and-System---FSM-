circuit EasyCal :
  module EasyCal :
    input clock : Clock
    input reset : UInt<1>
    input io_key_in : UInt<4>
    output io_value_valid : UInt<1>
    output io_value_bits : UInt<32>

    node _T = geq(io_key_in, UInt<4>("ha")) @[EasyCal.scala 15:27]
    node _T_1 = leq(io_key_in, UInt<4>("hc")) @[EasyCal.scala 15:48]
    node _T_2 = and(_T, _T_1) @[EasyCal.scala 15:35]
    node _T_3 = lt(io_key_in, UInt<4>("ha")) @[EasyCal.scala 18:22]
    node _T_4 = eq(io_key_in, UInt<4>("hf")) @[EasyCal.scala 23:24]
    reg in_buffer : UInt<4>, clock with :
      reset => (UInt<1>("h0"), in_buffer) @[EasyCal.scala 28:28]
    reg src1 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), src1) @[EasyCal.scala 29:23]
    reg op : UInt<2>, clock with :
      reset => (UInt<1>("h0"), op) @[EasyCal.scala 30:21]
    reg src2 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), src2) @[EasyCal.scala 31:23]
    reg state : UInt<3>, clock with :
      reset => (UInt<1>("h0"), state) @[EasyCal.scala 39:24]
    node _T_5 = eq(UInt<3>("h0"), state) @[Conditional.scala 37:30]
    node _T_6 = eq(UInt<3>("h1"), state) @[Conditional.scala 37:30]
    node operator = _T_2
    node _GEN_0 = mux(operator, UInt<3>("h2"), state) @[EasyCal.scala 48:28 EasyCal.scala 48:35 EasyCal.scala 39:24]
    node _T_7 = eq(UInt<3>("h2"), state) @[Conditional.scala 37:30]
    node num = _T_3
    node _GEN_1 = mux(num, UInt<3>("h3"), state) @[EasyCal.scala 51:23 EasyCal.scala 51:30 EasyCal.scala 39:24]
    node _T_8 = eq(UInt<3>("h3"), state) @[Conditional.scala 37:30]
    node equal = _T_4
    node _GEN_2 = mux(equal, UInt<3>("h4"), state) @[EasyCal.scala 54:25 EasyCal.scala 54:32 EasyCal.scala 39:24]
    node _T_9 = eq(UInt<3>("h4"), state) @[Conditional.scala 37:30]
    node _GEN_3 = mux(_T_9, UInt<3>("h1"), state) @[Conditional.scala 39:67 EasyCal.scala 57:19 EasyCal.scala 39:24]
    node _GEN_4 = mux(_T_8, _GEN_2, _GEN_3) @[Conditional.scala 39:67]
    node _GEN_5 = mux(_T_7, _GEN_1, _GEN_4) @[Conditional.scala 39:67]
    node _GEN_6 = mux(_T_6, _GEN_0, _GEN_5) @[Conditional.scala 39:67]
    node _GEN_7 = mux(_T_5, UInt<3>("h1"), _GEN_6) @[Conditional.scala 40:58 EasyCal.scala 45:19]
    node _T_10 = eq(state, UInt<3>("h1")) @[EasyCal.scala 62:16]
    node _T_11 = dshl(src1, UInt<2>("h3")) @[EasyCal.scala 62:40]
    node _T_12 = dshl(src1, UInt<1>("h1")) @[EasyCal.scala 62:54]
    node _T_13 = add(_T_11, _T_12) @[EasyCal.scala 62:47]
    node _T_14 = tail(_T_13, 1) @[EasyCal.scala 62:47]
    node _T_15 = add(_T_14, in_buffer) @[EasyCal.scala 62:61]
    node _T_16 = tail(_T_15, 1) @[EasyCal.scala 62:61]
    node _GEN_8 = mux(_T_10, _T_16, src1) @[EasyCal.scala 62:26 EasyCal.scala 62:32 EasyCal.scala 29:23]
    node _T_17 = eq(state, UInt<3>("h3")) @[EasyCal.scala 63:16]
    node _T_18 = dshl(src2, UInt<2>("h3")) @[EasyCal.scala 63:40]
    node _T_19 = dshl(src2, UInt<1>("h1")) @[EasyCal.scala 63:54]
    node _T_20 = add(_T_18, _T_19) @[EasyCal.scala 63:47]
    node _T_21 = tail(_T_20, 1) @[EasyCal.scala 63:47]
    node _T_22 = add(_T_21, in_buffer) @[EasyCal.scala 63:61]
    node _T_23 = tail(_T_22, 1) @[EasyCal.scala 63:61]
    node _GEN_9 = mux(_T_17, _T_23, src2) @[EasyCal.scala 63:26 EasyCal.scala 63:32 EasyCal.scala 31:23]
    node _T_24 = eq(state, UInt<3>("h2")) @[EasyCal.scala 64:16]
    node _T_25 = sub(in_buffer, UInt<4>("ha")) @[EasyCal.scala 64:41]
    node _T_26 = tail(_T_25, 1) @[EasyCal.scala 64:41]
    node _GEN_10 = mux(_T_24, _T_26, op) @[EasyCal.scala 64:24 EasyCal.scala 64:28 EasyCal.scala 30:21]
    node _T_27 = eq(state, UInt<3>("h4")) @[EasyCal.scala 66:16]
    node _GEN_11 = mux(_T_27, UInt<1>("h0"), _GEN_8) @[EasyCal.scala 66:27 EasyCal.scala 67:14]
    node _GEN_12 = mux(_T_27, UInt<1>("h0"), _GEN_9) @[EasyCal.scala 66:27 EasyCal.scala 68:14]
    node _GEN_13 = mux(_T_27, UInt<1>("h0"), _GEN_10) @[EasyCal.scala 66:27 EasyCal.scala 69:12]
    node _GEN_14 = mux(_T_27, UInt<1>("h0"), io_key_in) @[EasyCal.scala 66:27 EasyCal.scala 70:19 EasyCal.scala 28:28]
    node _T_28 = eq(state, UInt<3>("h4")) @[EasyCal.scala 73:33]
    node _T_29 = mux(_T_28, UInt<1>("h1"), UInt<1>("h0")) @[EasyCal.scala 73:26]
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
    io_value_valid <= _T_29 @[EasyCal.scala 73:20]
    io_value_bits <= bits(_T_40, 31, 0) @[EasyCal.scala 74:19]
    in_buffer <= _GEN_14
    src1 <= mux(reset, UInt<32>("h0"), bits(_GEN_11, 31, 0)) @[EasyCal.scala 29:23 EasyCal.scala 29:23]
    op <= mux(reset, UInt<2>("h0"), bits(_GEN_13, 1, 0)) @[EasyCal.scala 30:21 EasyCal.scala 30:21]
    src2 <= mux(reset, UInt<32>("h0"), bits(_GEN_12, 31, 0)) @[EasyCal.scala 31:23 EasyCal.scala 31:23]
    state <= mux(reset, UInt<3>("h0"), _GEN_7) @[EasyCal.scala 39:24 EasyCal.scala 39:24]

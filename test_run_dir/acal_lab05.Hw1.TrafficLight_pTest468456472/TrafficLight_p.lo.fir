circuit TrafficLight_p :
  module TrafficLight_p :
    input clock : Clock
    input reset : UInt<1>
    input io_P_button : UInt<1>
    output io_H_traffic : UInt<2>
    output io_V_traffic : UInt<2>
    output io_P_traffic : UInt<2>
    output io_timer : UInt<5>

    reg state : UInt<3>, clock with :
      reset => (UInt<1>("h0"), state) @[TrafficLight_p.scala 25:22]
    reg cntReg : UInt<4>, clock with :
      reset => (UInt<1>("h0"), cntReg) @[TrafficLight_p.scala 29:23]
    node _T = eq(cntReg, UInt<1>("h0")) @[TrafficLight_p.scala 31:21]
    node _T_11 = eq(UInt<3>("h1"), state) @[Conditional.scala 37:30]
    node _T_12 = eq(UInt<3>("h2"), state) @[Conditional.scala 37:30]
    node _T_13 = eq(UInt<3>("h3"), state) @[Conditional.scala 37:30]
    node _T_14 = eq(UInt<3>("h4"), state) @[Conditional.scala 37:30]
    node _T_15 = eq(UInt<3>("h5"), state) @[Conditional.scala 37:30]
    node _GEN_15 = mux(_T_15, UInt<2>("h2"), UInt<1>("h0")) @[Conditional.scala 39:67 TrafficLight_p.scala 107:15 TrafficLight_p.scala 76:11]
    node _GEN_18 = mux(_T_14, UInt<1>("h0"), _GEN_15) @[Conditional.scala 39:67 TrafficLight_p.scala 101:15]
    node _GEN_22 = mux(_T_13, UInt<1>("h1"), _GEN_18) @[Conditional.scala 39:67 TrafficLight_p.scala 95:15]
    node _GEN_26 = mux(_T_12, UInt<1>("h0"), _GEN_22) @[Conditional.scala 39:67 TrafficLight_p.scala 89:15]
    node _GEN_30 = mux(_T_11, UInt<1>("h1"), _GEN_26) @[Conditional.scala 40:58 TrafficLight_p.scala 83:15]
    node cntMode = _GEN_30
    node _T_1 = eq(cntMode, UInt<1>("h0")) @[TrafficLight_p.scala 34:18]
    node _T_2 = eq(cntMode, UInt<1>("h1")) @[TrafficLight_p.scala 36:24]
    node _GEN_0 = mux(_T_2, UInt<2>("h2"), UInt<3>("h4")) @[TrafficLight_p.scala 36:32 TrafficLight_p.scala 37:14 TrafficLight_p.scala 39:14]
    node _GEN_1 = mux(_T_1, UInt<3>("h6"), _GEN_0) @[TrafficLight_p.scala 34:26 TrafficLight_p.scala 35:14]
    node _T_3 = sub(cntReg, UInt<1>("h1")) @[TrafficLight_p.scala 42:22]
    node _T_4 = tail(_T_3, 1) @[TrafficLight_p.scala 42:22]
    node cntDone = _T @[TrafficLight_p.scala 30:21 TrafficLight_p.scala 31:11]
    node _GEN_2 = mux(cntDone, _GEN_1, _T_4) @[TrafficLight_p.scala 33:16 TrafficLight_p.scala 42:12]
    node _T_5 = eq(UInt<3>("h0"), state) @[Conditional.scala 37:30]
    node _T_6 = eq(UInt<3>("h1"), state) @[Conditional.scala 37:30]
    node _GEN_3 = mux(cntDone, UInt<3>("h2"), state) @[TrafficLight_p.scala 55:23 TrafficLight_p.scala 55:30 TrafficLight_p.scala 25:22]
    node _T_7 = eq(UInt<3>("h2"), state) @[Conditional.scala 37:30]
    node _GEN_4 = mux(cntDone, UInt<3>("h3"), state) @[TrafficLight_p.scala 58:23 TrafficLight_p.scala 58:30 TrafficLight_p.scala 25:22]
    node _T_8 = eq(UInt<3>("h3"), state) @[Conditional.scala 37:30]
    node _GEN_5 = mux(cntDone, UInt<3>("h4"), state) @[TrafficLight_p.scala 61:23 TrafficLight_p.scala 61:30 TrafficLight_p.scala 25:22]
    node _T_9 = eq(UInt<3>("h4"), state) @[Conditional.scala 37:30]
    node _GEN_6 = mux(cntDone, UInt<3>("h1"), state) @[TrafficLight_p.scala 64:23 TrafficLight_p.scala 64:30 TrafficLight_p.scala 25:22]
    node _T_10 = eq(UInt<3>("h5"), state) @[Conditional.scala 37:30]
    node _GEN_7 = mux(cntDone, state, state) @[TrafficLight_p.scala 68:23 TrafficLight_p.scala 68:30 TrafficLight_p.scala 25:22]
    node _GEN_8 = mux(_T_10, _GEN_7, state) @[Conditional.scala 39:67 TrafficLight_p.scala 25:22]
    node _GEN_9 = mux(_T_9, _GEN_6, _GEN_8) @[Conditional.scala 39:67]
    node _GEN_10 = mux(_T_8, _GEN_5, _GEN_9) @[Conditional.scala 39:67]
    node _GEN_11 = mux(_T_7, _GEN_4, _GEN_10) @[Conditional.scala 39:67]
    node _GEN_12 = mux(_T_6, _GEN_3, _GEN_11) @[Conditional.scala 39:67]
    node _GEN_13 = mux(_T_5, UInt<3>("h1"), _GEN_12) @[Conditional.scala 40:58 TrafficLight_p.scala 52:15]
    node _GEN_14 = mux(io_P_button, UInt<3>("h5"), _GEN_13) @[TrafficLight_p.scala 47:20 TrafficLight_p.scala 48:11]
    node _GEN_16 = mux(_T_15, UInt<1>("h1"), UInt<1>("h0")) @[Conditional.scala 39:67 TrafficLight_p.scala 108:20 TrafficLight_p.scala 77:16]
    node _GEN_17 = mux(_T_15, UInt<2>("h3"), UInt<1>("h0")) @[Conditional.scala 39:67 TrafficLight_p.scala 110:20 TrafficLight_p.scala 79:16]
    node _GEN_19 = mux(_T_14, UInt<1>("h1"), _GEN_16) @[Conditional.scala 39:67 TrafficLight_p.scala 102:20]
    node _GEN_20 = mux(_T_14, UInt<2>("h2"), _GEN_16) @[Conditional.scala 39:67 TrafficLight_p.scala 103:20]
    node _GEN_21 = mux(_T_14, UInt<1>("h1"), _GEN_17) @[Conditional.scala 39:67 TrafficLight_p.scala 104:20]
    node _GEN_23 = mux(_T_13, UInt<1>("h1"), _GEN_19) @[Conditional.scala 39:67 TrafficLight_p.scala 96:20]
    node _GEN_24 = mux(_T_13, UInt<2>("h3"), _GEN_20) @[Conditional.scala 39:67 TrafficLight_p.scala 97:20]
    node _GEN_25 = mux(_T_13, UInt<1>("h1"), _GEN_21) @[Conditional.scala 39:67 TrafficLight_p.scala 98:20]
    node _GEN_27 = mux(_T_12, UInt<2>("h2"), _GEN_23) @[Conditional.scala 39:67 TrafficLight_p.scala 90:20]
    node _GEN_28 = mux(_T_12, UInt<1>("h1"), _GEN_24) @[Conditional.scala 39:67 TrafficLight_p.scala 91:20]
    node _GEN_29 = mux(_T_12, UInt<1>("h1"), _GEN_25) @[Conditional.scala 39:67 TrafficLight_p.scala 92:20]
    node _GEN_31 = mux(_T_11, UInt<2>("h3"), _GEN_27) @[Conditional.scala 40:58 TrafficLight_p.scala 84:20]
    node _GEN_32 = mux(_T_11, UInt<1>("h1"), _GEN_28) @[Conditional.scala 40:58 TrafficLight_p.scala 85:20]
    node _GEN_33 = mux(_T_11, UInt<1>("h1"), _GEN_29) @[Conditional.scala 40:58 TrafficLight_p.scala 86:20]
    io_H_traffic <= _GEN_31
    io_V_traffic <= _GEN_32
    io_P_traffic <= _GEN_33
    io_timer <= cntReg @[TrafficLight_p.scala 114:12]
    state <= mux(reset, UInt<3>("h0"), _GEN_14) @[TrafficLight_p.scala 25:22 TrafficLight_p.scala 25:22]
    cntReg <= mux(reset, UInt<4>("h0"), _GEN_2) @[TrafficLight_p.scala 29:23 TrafficLight_p.scala 29:23]

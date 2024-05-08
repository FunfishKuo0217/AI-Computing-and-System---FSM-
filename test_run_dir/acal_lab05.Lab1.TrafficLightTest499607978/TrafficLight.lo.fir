circuit TrafficLight :
  module SevenSeg :
    input clock : Clock
    input reset : UInt<1>
    input io_num : UInt<4>
    output io_display : UInt<7>

    node _T = eq(UInt<1>("h0"), io_num) @[Conditional.scala 37:30]
    node _T_1 = eq(UInt<1>("h1"), io_num) @[Conditional.scala 37:30]
    node _T_2 = eq(UInt<2>("h2"), io_num) @[Conditional.scala 37:30]
    node _T_3 = eq(UInt<2>("h3"), io_num) @[Conditional.scala 37:30]
    node _T_4 = eq(UInt<3>("h4"), io_num) @[Conditional.scala 37:30]
    node _T_5 = eq(UInt<3>("h5"), io_num) @[Conditional.scala 37:30]
    node _T_6 = eq(UInt<3>("h6"), io_num) @[Conditional.scala 37:30]
    node _T_7 = eq(UInt<3>("h7"), io_num) @[Conditional.scala 37:30]
    node _T_8 = eq(UInt<4>("h8"), io_num) @[Conditional.scala 37:30]
    node _T_9 = eq(UInt<4>("h9"), io_num) @[Conditional.scala 37:30]
    node _GEN_0 = mux(_T_9, UInt<7>("h7b"), UInt<1>("h0")) @[Conditional.scala 39:67 SevenSeg.scala 25:22 SevenSeg.scala 14:10]
    node _GEN_1 = mux(_T_8, UInt<7>("h7f"), _GEN_0) @[Conditional.scala 39:67 SevenSeg.scala 24:22]
    node _GEN_2 = mux(_T_7, UInt<7>("h70"), _GEN_1) @[Conditional.scala 39:67 SevenSeg.scala 23:22]
    node _GEN_3 = mux(_T_6, UInt<7>("h5f"), _GEN_2) @[Conditional.scala 39:67 SevenSeg.scala 22:22]
    node _GEN_4 = mux(_T_5, UInt<7>("h5b"), _GEN_3) @[Conditional.scala 39:67 SevenSeg.scala 21:22]
    node _GEN_5 = mux(_T_4, UInt<6>("h33"), _GEN_4) @[Conditional.scala 39:67 SevenSeg.scala 20:22]
    node _GEN_6 = mux(_T_3, UInt<7>("h79"), _GEN_5) @[Conditional.scala 39:67 SevenSeg.scala 19:22]
    node _GEN_7 = mux(_T_2, UInt<7>("h6d"), _GEN_6) @[Conditional.scala 39:67 SevenSeg.scala 18:22]
    node _GEN_8 = mux(_T_1, UInt<6>("h30"), _GEN_7) @[Conditional.scala 39:67 SevenSeg.scala 17:22]
    node _GEN_9 = mux(_T, UInt<7>("h7e"), _GEN_8) @[Conditional.scala 40:58 SevenSeg.scala 16:22]
    node segs = _GEN_9 @[SevenSeg.scala 12:20]
    io_display <= segs @[SevenSeg.scala 28:16]

  module TrafficLight :
    input clock : Clock
    input reset : UInt<1>
    output io_H_traffic : UInt<2>
    output io_V_traffic : UInt<2>
    output io_timer : UInt<5>
    output io_display : UInt<7>

    inst ss of SevenSeg @[TrafficLight.scala 95:18]
    reg state : UInt<3>, clock with :
      reset => (UInt<1>("h0"), state) @[TrafficLight.scala 25:22]
    reg cntReg : UInt<4>, clock with :
      reset => (UInt<1>("h0"), cntReg) @[TrafficLight.scala 29:23]
    node _T = eq(cntReg, UInt<1>("h0")) @[TrafficLight.scala 31:21]
    node _T_10 = eq(UInt<3>("h1"), state) @[Conditional.scala 37:30]
    node _T_11 = eq(UInt<3>("h2"), state) @[Conditional.scala 37:30]
    node _T_12 = eq(UInt<3>("h3"), state) @[Conditional.scala 37:30]
    node _T_13 = eq(UInt<3>("h4"), state) @[Conditional.scala 37:30]
    node _GEN_12 = mux(_T_13, UInt<1>("h0"), UInt<1>("h0")) @[Conditional.scala 39:67 TrafficLight.scala 87:15 TrafficLight.scala 66:11]
    node _GEN_15 = mux(_T_12, UInt<1>("h1"), _GEN_12) @[Conditional.scala 39:67 TrafficLight.scala 82:15]
    node _GEN_18 = mux(_T_11, UInt<1>("h0"), _GEN_15) @[Conditional.scala 39:67 TrafficLight.scala 77:15]
    node _GEN_21 = mux(_T_10, UInt<1>("h1"), _GEN_18) @[Conditional.scala 40:58 TrafficLight.scala 72:15]
    node cntMode = _GEN_21
    node _T_1 = eq(cntMode, UInt<1>("h0")) @[TrafficLight.scala 34:18]
    node _T_2 = eq(cntMode, UInt<1>("h1")) @[TrafficLight.scala 36:24]
    node _GEN_0 = mux(_T_2, UInt<2>("h2"), cntReg) @[TrafficLight.scala 36:32 TrafficLight.scala 37:14 TrafficLight.scala 29:23]
    node _GEN_1 = mux(_T_1, UInt<3>("h6"), _GEN_0) @[TrafficLight.scala 34:26 TrafficLight.scala 35:14]
    node _T_3 = sub(cntReg, UInt<1>("h1")) @[TrafficLight.scala 40:22]
    node _T_4 = tail(_T_3, 1) @[TrafficLight.scala 40:22]
    node cntDone = _T @[TrafficLight.scala 30:21 TrafficLight.scala 31:11]
    node _GEN_2 = mux(cntDone, _GEN_1, _T_4) @[TrafficLight.scala 33:16 TrafficLight.scala 40:12]
    node _T_5 = eq(UInt<3>("h0"), state) @[Conditional.scala 37:30]
    node _T_6 = eq(UInt<3>("h1"), state) @[Conditional.scala 37:30]
    node _GEN_3 = mux(cntDone, UInt<3>("h2"), state) @[TrafficLight.scala 51:21 TrafficLight.scala 51:28 TrafficLight.scala 25:22]
    node _T_7 = eq(UInt<3>("h2"), state) @[Conditional.scala 37:30]
    node _GEN_4 = mux(cntDone, UInt<3>("h3"), state) @[TrafficLight.scala 54:21 TrafficLight.scala 54:28 TrafficLight.scala 25:22]
    node _T_8 = eq(UInt<3>("h3"), state) @[Conditional.scala 37:30]
    node _GEN_5 = mux(cntDone, UInt<3>("h4"), state) @[TrafficLight.scala 57:21 TrafficLight.scala 57:28 TrafficLight.scala 25:22]
    node _T_9 = eq(UInt<3>("h4"), state) @[Conditional.scala 37:30]
    node _GEN_6 = mux(cntDone, UInt<3>("h1"), state) @[TrafficLight.scala 60:21 TrafficLight.scala 60:28 TrafficLight.scala 25:22]
    node _GEN_7 = mux(_T_9, _GEN_6, state) @[Conditional.scala 39:67 TrafficLight.scala 25:22]
    node _GEN_8 = mux(_T_8, _GEN_5, _GEN_7) @[Conditional.scala 39:67]
    node _GEN_9 = mux(_T_7, _GEN_4, _GEN_8) @[Conditional.scala 39:67]
    node _GEN_10 = mux(_T_6, _GEN_3, _GEN_9) @[Conditional.scala 39:67]
    node _GEN_11 = mux(_T_5, UInt<3>("h1"), _GEN_10) @[Conditional.scala 40:58 TrafficLight.scala 48:13]
    node _GEN_13 = mux(_T_13, UInt<1>("h1"), UInt<1>("h0")) @[Conditional.scala 39:67 TrafficLight.scala 88:20 TrafficLight.scala 67:16]
    node _GEN_14 = mux(_T_13, UInt<2>("h2"), UInt<1>("h0")) @[Conditional.scala 39:67 TrafficLight.scala 89:20 TrafficLight.scala 68:16]
    node _GEN_16 = mux(_T_12, UInt<1>("h1"), _GEN_13) @[Conditional.scala 39:67 TrafficLight.scala 83:20]
    node _GEN_17 = mux(_T_12, UInt<2>("h3"), _GEN_14) @[Conditional.scala 39:67 TrafficLight.scala 84:20]
    node _GEN_19 = mux(_T_11, UInt<2>("h2"), _GEN_16) @[Conditional.scala 39:67 TrafficLight.scala 78:20]
    node _GEN_20 = mux(_T_11, UInt<1>("h1"), _GEN_17) @[Conditional.scala 39:67 TrafficLight.scala 79:20]
    node _GEN_22 = mux(_T_10, UInt<2>("h3"), _GEN_19) @[Conditional.scala 40:58 TrafficLight.scala 73:20]
    node _GEN_23 = mux(_T_10, UInt<1>("h1"), _GEN_20) @[Conditional.scala 40:58 TrafficLight.scala 74:20]
    io_H_traffic <= _GEN_22
    io_V_traffic <= _GEN_23
    io_timer <= cntReg @[TrafficLight.scala 93:12]
    io_display <= ss.io_display @[TrafficLight.scala 97:14]
    state <= mux(reset, UInt<3>("h0"), _GEN_11) @[TrafficLight.scala 25:22 TrafficLight.scala 25:22]
    cntReg <= mux(reset, UInt<4>("h0"), _GEN_2) @[TrafficLight.scala 29:23 TrafficLight.scala 29:23]
    ss.clock <= clock
    ss.reset <= reset
    ss.io_num <= cntReg @[TrafficLight.scala 96:13]

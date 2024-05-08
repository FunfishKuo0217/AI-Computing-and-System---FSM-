circuit TrafficLight_p :
  module TrafficLight_p :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip P_button : UInt<1>, H_traffic : UInt<2>, V_traffic : UInt<2>, P_traffic : UInt<2>, timer : UInt<5>}

    reg state : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[TrafficLight_p.scala 25:22]
    wire cntMode : UInt<2>
    cntMode <= UInt<2>("h0")
    reg cntReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[TrafficLight_p.scala 29:23]
    wire cntDone : UInt<1> @[TrafficLight_p.scala 30:21]
    node _T = eq(cntReg, UInt<1>("h0")) @[TrafficLight_p.scala 31:21]
    cntDone <= _T @[TrafficLight_p.scala 31:11]
    when cntDone : @[TrafficLight_p.scala 33:16]
      node _T_1 = eq(cntMode, UInt<1>("h0")) @[TrafficLight_p.scala 34:18]
      when _T_1 : @[TrafficLight_p.scala 34:26]
        cntReg <= UInt<3>("h6") @[TrafficLight_p.scala 35:14]
      else :
        node _T_2 = eq(cntMode, UInt<1>("h1")) @[TrafficLight_p.scala 36:24]
        when _T_2 : @[TrafficLight_p.scala 36:32]
          cntReg <= UInt<2>("h2") @[TrafficLight_p.scala 37:14]
        else :
          cntReg <= UInt<3>("h4") @[TrafficLight_p.scala 39:14]
    else :
      node _T_3 = sub(cntReg, UInt<1>("h1")) @[TrafficLight_p.scala 42:22]
      node _T_4 = tail(_T_3, 1) @[TrafficLight_p.scala 42:22]
      cntReg <= _T_4 @[TrafficLight_p.scala 42:12]
    when io.P_button : @[TrafficLight_p.scala 47:20]
      state <= UInt<3>("h5") @[TrafficLight_p.scala 48:11]
    else :
      node _T_5 = eq(UInt<3>("h0"), state) @[Conditional.scala 37:30]
      when _T_5 : @[Conditional.scala 40:58]
        state <= UInt<3>("h1") @[TrafficLight_p.scala 52:15]
      else :
        node _T_6 = eq(UInt<3>("h1"), state) @[Conditional.scala 37:30]
        when _T_6 : @[Conditional.scala 39:67]
          when cntDone : @[TrafficLight_p.scala 55:23]
            state <= UInt<3>("h2") @[TrafficLight_p.scala 55:30]
        else :
          node _T_7 = eq(UInt<3>("h2"), state) @[Conditional.scala 37:30]
          when _T_7 : @[Conditional.scala 39:67]
            when cntDone : @[TrafficLight_p.scala 58:23]
              state <= UInt<3>("h3") @[TrafficLight_p.scala 58:30]
          else :
            node _T_8 = eq(UInt<3>("h3"), state) @[Conditional.scala 37:30]
            when _T_8 : @[Conditional.scala 39:67]
              when cntDone : @[TrafficLight_p.scala 61:23]
                state <= UInt<3>("h4") @[TrafficLight_p.scala 61:30]
            else :
              node _T_9 = eq(UInt<3>("h4"), state) @[Conditional.scala 37:30]
              when _T_9 : @[Conditional.scala 39:67]
                when cntDone : @[TrafficLight_p.scala 64:23]
                  state <= UInt<3>("h1") @[TrafficLight_p.scala 64:30]
              else :
                node _T_10 = eq(UInt<3>("h5"), state) @[Conditional.scala 37:30]
                when _T_10 : @[Conditional.scala 39:67]
                  when cntDone : @[TrafficLight_p.scala 68:23]
                    state <= state @[TrafficLight_p.scala 68:30]
    cntMode <= UInt<1>("h0") @[TrafficLight_p.scala 76:11]
    io.H_traffic <= UInt<1>("h0") @[TrafficLight_p.scala 77:16]
    io.V_traffic <= UInt<1>("h0") @[TrafficLight_p.scala 78:16]
    io.P_traffic <= UInt<1>("h0") @[TrafficLight_p.scala 79:16]
    node _T_11 = eq(UInt<3>("h1"), state) @[Conditional.scala 37:30]
    when _T_11 : @[Conditional.scala 40:58]
      cntMode <= UInt<1>("h1") @[TrafficLight_p.scala 83:15]
      io.H_traffic <= UInt<2>("h3") @[TrafficLight_p.scala 84:20]
      io.V_traffic <= UInt<1>("h1") @[TrafficLight_p.scala 85:20]
      io.P_traffic <= UInt<1>("h1") @[TrafficLight_p.scala 86:20]
    else :
      node _T_12 = eq(UInt<3>("h2"), state) @[Conditional.scala 37:30]
      when _T_12 : @[Conditional.scala 39:67]
        cntMode <= UInt<1>("h0") @[TrafficLight_p.scala 89:15]
        io.H_traffic <= UInt<2>("h2") @[TrafficLight_p.scala 90:20]
        io.V_traffic <= UInt<1>("h1") @[TrafficLight_p.scala 91:20]
        io.P_traffic <= UInt<1>("h1") @[TrafficLight_p.scala 92:20]
      else :
        node _T_13 = eq(UInt<3>("h3"), state) @[Conditional.scala 37:30]
        when _T_13 : @[Conditional.scala 39:67]
          cntMode <= UInt<1>("h1") @[TrafficLight_p.scala 95:15]
          io.H_traffic <= UInt<1>("h1") @[TrafficLight_p.scala 96:20]
          io.V_traffic <= UInt<2>("h3") @[TrafficLight_p.scala 97:20]
          io.P_traffic <= UInt<1>("h1") @[TrafficLight_p.scala 98:20]
        else :
          node _T_14 = eq(UInt<3>("h4"), state) @[Conditional.scala 37:30]
          when _T_14 : @[Conditional.scala 39:67]
            cntMode <= UInt<1>("h0") @[TrafficLight_p.scala 101:15]
            io.H_traffic <= UInt<1>("h1") @[TrafficLight_p.scala 102:20]
            io.V_traffic <= UInt<2>("h2") @[TrafficLight_p.scala 103:20]
            io.P_traffic <= UInt<1>("h1") @[TrafficLight_p.scala 104:20]
          else :
            node _T_15 = eq(UInt<3>("h5"), state) @[Conditional.scala 37:30]
            when _T_15 : @[Conditional.scala 39:67]
              cntMode <= UInt<2>("h2") @[TrafficLight_p.scala 107:15]
              io.H_traffic <= UInt<1>("h1") @[TrafficLight_p.scala 108:20]
              io.V_traffic <= UInt<1>("h1") @[TrafficLight_p.scala 109:20]
              io.P_traffic <= UInt<2>("h3") @[TrafficLight_p.scala 110:20]
    io.timer <= cntReg @[TrafficLight_p.scala 114:12]


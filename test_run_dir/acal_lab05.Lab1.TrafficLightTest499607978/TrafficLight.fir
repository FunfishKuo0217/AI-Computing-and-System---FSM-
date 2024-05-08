circuit TrafficLight :
  module SevenSeg :
    input clock : Clock
    input reset : Reset
    output io : { flip num : UInt<4>, display : UInt<7>}

    wire segs : UInt<7> @[SevenSeg.scala 12:20]
    segs <= UInt<1>("h0") @[SevenSeg.scala 14:10]
    node _T = eq(UInt<1>("h0"), io.num) @[Conditional.scala 37:30]
    when _T : @[Conditional.scala 40:58]
      segs <= UInt<7>("h7e") @[SevenSeg.scala 16:22]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.num) @[Conditional.scala 37:30]
      when _T_1 : @[Conditional.scala 39:67]
        segs <= UInt<6>("h30") @[SevenSeg.scala 17:22]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.num) @[Conditional.scala 37:30]
        when _T_2 : @[Conditional.scala 39:67]
          segs <= UInt<7>("h6d") @[SevenSeg.scala 18:22]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.num) @[Conditional.scala 37:30]
          when _T_3 : @[Conditional.scala 39:67]
            segs <= UInt<7>("h79") @[SevenSeg.scala 19:22]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.num) @[Conditional.scala 37:30]
            when _T_4 : @[Conditional.scala 39:67]
              segs <= UInt<6>("h33") @[SevenSeg.scala 20:22]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.num) @[Conditional.scala 37:30]
              when _T_5 : @[Conditional.scala 39:67]
                segs <= UInt<7>("h5b") @[SevenSeg.scala 21:22]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.num) @[Conditional.scala 37:30]
                when _T_6 : @[Conditional.scala 39:67]
                  segs <= UInt<7>("h5f") @[SevenSeg.scala 22:22]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.num) @[Conditional.scala 37:30]
                  when _T_7 : @[Conditional.scala 39:67]
                    segs <= UInt<7>("h70") @[SevenSeg.scala 23:22]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.num) @[Conditional.scala 37:30]
                    when _T_8 : @[Conditional.scala 39:67]
                      segs <= UInt<7>("h7f") @[SevenSeg.scala 24:22]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.num) @[Conditional.scala 37:30]
                      when _T_9 : @[Conditional.scala 39:67]
                        segs <= UInt<7>("h7b") @[SevenSeg.scala 25:22]
    io.display <= segs @[SevenSeg.scala 28:16]

  module TrafficLight :
    input clock : Clock
    input reset : UInt<1>
    output io : { H_traffic : UInt<2>, V_traffic : UInt<2>, timer : UInt<5>, display : UInt<7>}

    reg state : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[TrafficLight.scala 25:22]
    wire cntMode : UInt<1>
    cntMode <= UInt<1>("h0")
    reg cntReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[TrafficLight.scala 29:23]
    wire cntDone : UInt<1> @[TrafficLight.scala 30:21]
    node _T = eq(cntReg, UInt<1>("h0")) @[TrafficLight.scala 31:21]
    cntDone <= _T @[TrafficLight.scala 31:11]
    when cntDone : @[TrafficLight.scala 33:16]
      node _T_1 = eq(cntMode, UInt<1>("h0")) @[TrafficLight.scala 34:18]
      when _T_1 : @[TrafficLight.scala 34:26]
        cntReg <= UInt<3>("h6") @[TrafficLight.scala 35:14]
      else :
        node _T_2 = eq(cntMode, UInt<1>("h1")) @[TrafficLight.scala 36:24]
        when _T_2 : @[TrafficLight.scala 36:32]
          cntReg <= UInt<2>("h2") @[TrafficLight.scala 37:14]
    else :
      node _T_3 = sub(cntReg, UInt<1>("h1")) @[TrafficLight.scala 40:22]
      node _T_4 = tail(_T_3, 1) @[TrafficLight.scala 40:22]
      cntReg <= _T_4 @[TrafficLight.scala 40:12]
    node _T_5 = eq(UInt<3>("h0"), state) @[Conditional.scala 37:30]
    when _T_5 : @[Conditional.scala 40:58]
      state <= UInt<3>("h1") @[TrafficLight.scala 48:13]
    else :
      node _T_6 = eq(UInt<3>("h1"), state) @[Conditional.scala 37:30]
      when _T_6 : @[Conditional.scala 39:67]
        when cntDone : @[TrafficLight.scala 51:21]
          state <= UInt<3>("h2") @[TrafficLight.scala 51:28]
      else :
        node _T_7 = eq(UInt<3>("h2"), state) @[Conditional.scala 37:30]
        when _T_7 : @[Conditional.scala 39:67]
          when cntDone : @[TrafficLight.scala 54:21]
            state <= UInt<3>("h3") @[TrafficLight.scala 54:28]
        else :
          node _T_8 = eq(UInt<3>("h3"), state) @[Conditional.scala 37:30]
          when _T_8 : @[Conditional.scala 39:67]
            when cntDone : @[TrafficLight.scala 57:21]
              state <= UInt<3>("h4") @[TrafficLight.scala 57:28]
          else :
            node _T_9 = eq(UInt<3>("h4"), state) @[Conditional.scala 37:30]
            when _T_9 : @[Conditional.scala 39:67]
              when cntDone : @[TrafficLight.scala 60:21]
                state <= UInt<3>("h1") @[TrafficLight.scala 60:28]
    cntMode <= UInt<1>("h0") @[TrafficLight.scala 66:11]
    io.H_traffic <= UInt<1>("h0") @[TrafficLight.scala 67:16]
    io.V_traffic <= UInt<1>("h0") @[TrafficLight.scala 68:16]
    node _T_10 = eq(UInt<3>("h1"), state) @[Conditional.scala 37:30]
    when _T_10 : @[Conditional.scala 40:58]
      cntMode <= UInt<1>("h1") @[TrafficLight.scala 72:15]
      io.H_traffic <= UInt<2>("h3") @[TrafficLight.scala 73:20]
      io.V_traffic <= UInt<1>("h1") @[TrafficLight.scala 74:20]
    else :
      node _T_11 = eq(UInt<3>("h2"), state) @[Conditional.scala 37:30]
      when _T_11 : @[Conditional.scala 39:67]
        cntMode <= UInt<1>("h0") @[TrafficLight.scala 77:15]
        io.H_traffic <= UInt<2>("h2") @[TrafficLight.scala 78:20]
        io.V_traffic <= UInt<1>("h1") @[TrafficLight.scala 79:20]
      else :
        node _T_12 = eq(UInt<3>("h3"), state) @[Conditional.scala 37:30]
        when _T_12 : @[Conditional.scala 39:67]
          cntMode <= UInt<1>("h1") @[TrafficLight.scala 82:15]
          io.H_traffic <= UInt<1>("h1") @[TrafficLight.scala 83:20]
          io.V_traffic <= UInt<2>("h3") @[TrafficLight.scala 84:20]
        else :
          node _T_13 = eq(UInt<3>("h4"), state) @[Conditional.scala 37:30]
          when _T_13 : @[Conditional.scala 39:67]
            cntMode <= UInt<1>("h0") @[TrafficLight.scala 87:15]
            io.H_traffic <= UInt<1>("h1") @[TrafficLight.scala 88:20]
            io.V_traffic <= UInt<2>("h2") @[TrafficLight.scala 89:20]
    io.timer <= cntReg @[TrafficLight.scala 93:12]
    inst ss of SevenSeg @[TrafficLight.scala 95:18]
    ss.clock <= clock
    ss.reset <= reset
    ss.io.num <= cntReg @[TrafficLight.scala 96:13]
    io.display <= ss.io.display @[TrafficLight.scala 97:14]


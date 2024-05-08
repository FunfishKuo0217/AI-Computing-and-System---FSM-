circuit LFSR_Fibonacci :
  module LFSR_Fibonacci :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip seed : { valid : UInt<1>, bits : UInt<4>}, rndNum : UInt<4>}

    wire _WIRE : UInt<1>[4] @[LFSR_Fibonacci.scala 25:35]
    _WIRE[0] <= UInt<1>("h0") @[LFSR_Fibonacci.scala 25:35]
    _WIRE[1] <= UInt<1>("h0") @[LFSR_Fibonacci.scala 25:35]
    _WIRE[2] <= UInt<1>("h0") @[LFSR_Fibonacci.scala 25:35]
    _WIRE[3] <= UInt<1>("h0") @[LFSR_Fibonacci.scala 25:35]
    reg shiftReg : UInt<1>[4], clock with :
      reset => (reset, _WIRE) @[LFSR_Fibonacci.scala 25:27]
    when io.seed.valid : @[LFSR_Fibonacci.scala 27:24]
      node _T = bits(io.seed.bits, 0, 0) @[LFSR_Fibonacci.scala 28:33]
      node _T_1 = bits(io.seed.bits, 1, 1) @[LFSR_Fibonacci.scala 28:33]
      node _T_2 = bits(io.seed.bits, 2, 2) @[LFSR_Fibonacci.scala 28:33]
      node _T_3 = bits(io.seed.bits, 3, 3) @[LFSR_Fibonacci.scala 28:33]
      shiftReg[0] <= _T @[LFSR_Fibonacci.scala 28:61]
      shiftReg[1] <= _T_1 @[LFSR_Fibonacci.scala 28:61]
      shiftReg[2] <= _T_2 @[LFSR_Fibonacci.scala 28:61]
      shiftReg[3] <= _T_3 @[LFSR_Fibonacci.scala 28:61]
    else :
      shiftReg[0] <= shiftReg[1] @[LFSR_Fibonacci.scala 33:26]
      shiftReg[1] <= shiftReg[2] @[LFSR_Fibonacci.scala 33:26]
      shiftReg[2] <= shiftReg[3] @[LFSR_Fibonacci.scala 33:26]
      shiftReg[3] <= shiftReg[0] @[LFSR_Fibonacci.scala 33:26]
      node _T_4 = xor(shiftReg[1], shiftReg[0]) @[LFSR_Fibonacci.scala 36:72]
      shiftReg[3] <= _T_4 @[LFSR_Fibonacci.scala 36:21]
    node lo = cat(shiftReg[1], shiftReg[0]) @[LFSR_Fibonacci.scala 41:27]
    node hi = cat(shiftReg[3], shiftReg[2]) @[LFSR_Fibonacci.scala 41:27]
    node _T_5 = cat(hi, lo) @[LFSR_Fibonacci.scala 41:27]
    io.rndNum <= _T_5 @[LFSR_Fibonacci.scala 41:15]


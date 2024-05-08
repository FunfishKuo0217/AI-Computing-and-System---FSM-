circuit LFSR_Fibonacci :
  module LFSR_Fibonacci :
    input clock : Clock
    input reset : UInt<1>
    input io_seed_valid : UInt<1>
    input io_seed_bits : UInt<4>
    output io_rndNum : UInt<4>

    reg shiftReg_0 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), shiftReg_0) @[LFSR_Fibonacci.scala 25:27]
    reg shiftReg_1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), shiftReg_1) @[LFSR_Fibonacci.scala 25:27]
    reg shiftReg_2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), shiftReg_2) @[LFSR_Fibonacci.scala 25:27]
    reg shiftReg_3 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), shiftReg_3) @[LFSR_Fibonacci.scala 25:27]
    node _T = bits(io_seed_bits, 0, 0) @[LFSR_Fibonacci.scala 28:33]
    node _T_1 = bits(io_seed_bits, 1, 1) @[LFSR_Fibonacci.scala 28:33]
    node _T_2 = bits(io_seed_bits, 2, 2) @[LFSR_Fibonacci.scala 28:33]
    node _T_3 = bits(io_seed_bits, 3, 3) @[LFSR_Fibonacci.scala 28:33]
    node _T_4 = xor(shiftReg_1, shiftReg_0) @[LFSR_Fibonacci.scala 36:72]
    node _GEN_0 = mux(io_seed_valid, _T, shiftReg_1) @[LFSR_Fibonacci.scala 27:24 LFSR_Fibonacci.scala 28:61 LFSR_Fibonacci.scala 33:26]
    node _GEN_1 = mux(io_seed_valid, _T_1, shiftReg_2) @[LFSR_Fibonacci.scala 27:24 LFSR_Fibonacci.scala 28:61 LFSR_Fibonacci.scala 33:26]
    node _GEN_2 = mux(io_seed_valid, _T_2, shiftReg_3) @[LFSR_Fibonacci.scala 27:24 LFSR_Fibonacci.scala 28:61 LFSR_Fibonacci.scala 33:26]
    node _GEN_3 = mux(io_seed_valid, _T_3, _T_4) @[LFSR_Fibonacci.scala 27:24 LFSR_Fibonacci.scala 28:61 LFSR_Fibonacci.scala 36:21]
    node lo = cat(shiftReg_1, shiftReg_0) @[LFSR_Fibonacci.scala 41:27]
    node hi = cat(shiftReg_3, shiftReg_2) @[LFSR_Fibonacci.scala 41:27]
    node _T_5 = cat(hi, lo) @[LFSR_Fibonacci.scala 41:27]
    node _WIRE_0 = UInt<1>("h0") @[LFSR_Fibonacci.scala 25:35 LFSR_Fibonacci.scala 25:35]
    node _WIRE_1 = UInt<1>("h0") @[LFSR_Fibonacci.scala 25:35 LFSR_Fibonacci.scala 25:35]
    node _WIRE_2 = UInt<1>("h0") @[LFSR_Fibonacci.scala 25:35 LFSR_Fibonacci.scala 25:35]
    node _WIRE_3 = UInt<1>("h0") @[LFSR_Fibonacci.scala 25:35 LFSR_Fibonacci.scala 25:35]
    io_rndNum <= _T_5 @[LFSR_Fibonacci.scala 41:15]
    shiftReg_0 <= mux(reset, _WIRE_0, _GEN_0) @[LFSR_Fibonacci.scala 25:27 LFSR_Fibonacci.scala 25:27]
    shiftReg_1 <= mux(reset, _WIRE_1, _GEN_1) @[LFSR_Fibonacci.scala 25:27 LFSR_Fibonacci.scala 25:27]
    shiftReg_2 <= mux(reset, _WIRE_2, _GEN_2) @[LFSR_Fibonacci.scala 25:27 LFSR_Fibonacci.scala 25:27]
    shiftReg_3 <= mux(reset, _WIRE_3, _GEN_3) @[LFSR_Fibonacci.scala 25:27 LFSR_Fibonacci.scala 25:27]

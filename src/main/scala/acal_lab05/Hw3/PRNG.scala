package acal_lab05.Hw3

import chisel3._
import chisel3.util._

class PRNG(seed:Int) extends Module{
    val io = IO(new Bundle{
        val gen = Input(Bool())
        val puzzle = Output(Vec(4,UInt(4.W)))
        val ready = Output(Bool())
    })

    // state ============
        /*
        1. sIdle
        2. sLFSR: shift register generate 16 bits
        3. sAns: use 4 bits to generates output number i.e., bits(0-4) = output(0)
        3. sRangeMap: map 10-15 to 0-5
        4. sCheckDup: inspect duplicates of the four number
        5. sValDup: check if the current numbers could be set as output (no duplicates)
        6. sOutput: output the answer / valid bit = 1
        */
    val sIdle :: sLFSR :: sRangeMap :: sCheckDup :: sValDup :: sAns :: sOutput :: Nil = Enum(7)
    val state = RegInit(sIdle)
   
    // Registers ============
    val shiftReg = RegInit(VecInit(Seq.fill(16)(true.B)))
    val regAns = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
    val regDup = RegInit(VecInit(Seq.fill(6)(true.B))) // to inspect the 6 possible duplicate situation
    // registers - control the flow (若成立則往下一個 state)
    val goToRangeMap = RegInit(false.B)
    val goToCheckDup = RegInit(false.B)
    val goToValidateDup = RegInit(false.B)
    val goToOutput = RegInit(false.B)
    val goToReGen = RegInit(false.B)
    
    // state decoder ============
    switch(state){
        is(sIdle){ state := sLFSR}
        is(sLFSR){ state := sAns }
        is(sAns) { when(goToRangeMap === true.B){ state := sRangeMap }}
        is(sRangeMap) { when(goToCheckDup === true.B){ state := sCheckDup }}
        is(sCheckDup){ when(goToValidateDup === true.B){ state := sValDup }}
        is(sValDup){
            when(goToReGen === true.B){ state := sLFSR }
            .elsewhen(goToOutput === true.B){ state := sOutput }
        } 
        is(sOutput){ when(io.gen === true.B){ state := sIdle }}  
    }

    // default setting ============
    io.ready := false.B
    io.puzzle := VecInit(Seq.fill(4)(0.U(4.W)))

    // state operation ============
    when(state === sLFSR){
        goToReGen := false.B
        goToOutput := false.B
        (shiftReg.zipWithIndex).map{case(sr,i) => sr := shiftReg((i+1)%16)}
        // 依照題目指示，SR 的功能是讓第 1 個 bit 用 16, 14, 13, 11 之間以 XOR 結果構成（取 n-1 作為 n 的 index）
        shiftReg(0) := ((shiftReg(15)^shiftReg(13))^shiftReg(12))^shiftReg(10)
    }
    when(state === sAns){
        // put the bit into ans register
        regAns(0) := Cat(shiftReg(3), shiftReg(2), shiftReg(1), shiftReg(0)).asUInt
        regAns(1) := Cat(shiftReg(7), shiftReg(6), shiftReg(5), shiftReg(4)).asUInt
        regAns(2) := Cat(shiftReg(11), shiftReg(10), shiftReg(9), shiftReg(8)).asUInt
        regAns(3) := Cat(shiftReg(15), shiftReg(14), shiftReg(13), shiftReg(12)).asUInt
        goToRangeMap := RegNext(true.B)
    }
    when(state === sRangeMap){
        // mapping the 10-15 to 0-5
        goToRangeMap := false.B
        regAns(0) := Mux(regAns(0) > 9.U, regAns(0) - 10.U, regAns(0))
        regAns(1) := Mux(regAns(1) > 9.U, regAns(1) - 10.U, regAns(1))
        regAns(2) := Mux(regAns(2) > 9.U, regAns(2) - 10.U, regAns(2))
        regAns(3) := Mux(regAns(3) > 9.U, regAns(3) - 10.U, regAns(3))
        goToCheckDup := RegNext(true.B)
    }
    when(state === sCheckDup){
        goToCheckDup := false.B
        // 6 possible duplicate (C4取2=6)
        regDup(0) := Mux(regAns(0) === regAns(1), true.B, false.B)
        regDup(1) := Mux(regAns(0) === regAns(2), true.B, false.B)
        regDup(2) := Mux(regAns(0) === regAns(3), true.B, false.B)
        regDup(3) := Mux(regAns(1) === regAns(2), true.B, false.B)
        regDup(4) := Mux(regAns(1) === regAns(3), true.B, false.B)
        regDup(5) := Mux(regAns(2) === regAns(3), true.B, false.B)
        goToValidateDup := RegNext(true.B)
    }
    when(state === sValDup){
        goToValidateDup := false.B
        // 只要任一重複就重新 generate
        goToReGen := RegNext(Mux((regDup(0)||regDup(1)||regDup(2)||regDup(3)||regDup(4)||regDup(5))===true.B, true.B, false.B))
        // 如果沒有任何重複，就可以準備 output 答案
        goToOutput := RegNext(Mux((regDup(0)||regDup(1)||regDup(2)||regDup(3)||regDup(4)||regDup(5))===false.B, true.B, false.B))
    }
    when(state === sOutput){
        goToOutput := false.B
        goToReGen := false.B
        io.puzzle(0) := regAns(0)
        io.puzzle(1) := regAns(1)
        io.puzzle(2) := regAns(2)
        io.puzzle(3) := regAns(3)
        io.ready := RegNext(true.B)
    }
}


package acal_lab05.Hw2

import chisel3._
import chisel3.util._

class LongCal extends Module{
    val io = IO(new Bundle{
        val key_in = Input(UInt(4.W))
        val value = Output(Valid(UInt(32.W)))
    })

    // Wire Declaration===================================
    // 抓到 key_in 中屬於 operator 的部分
    val operator = WireDefault(false.B)
    val num = WireDefault(false.B)
    val equal = WireDefault(false.B)
    val negStart = WireDefault(false.B)
    val negEnd = WireDefault(false.B)
    operator := io.key_in >= 10.U && io.key_in <= 12.U
    num := io.key_in < 10.U
    equal := io.key_in === 15.U
    negStart := io.key_in === 13.U
    negEnd := io.key_in === 14.U

    // Reg Declaration====================================
    val in_buffer = RegNext(io.key_in) // 紀錄 key in 的內容
    val src1 = RegInit(0.U(32.W))      // 紀錄 src1 此刻的數值
    val op = RegInit(0.U(2.W))         // 紀錄 operator 屬於哪一啦
    val src2 = RegInit(0.U(32.W))      // 紀錄 src2 此刻的數值  
    val regSrc = RegInit(false.B)      // is the first operator occur?
    val regSrc1Neg = RegInit(false.B)  // is src1 negative?
    val regSrc2Neg = RegInit(false.B)  // is src2 negative?

    // State and Constant Declaration =====================
    val sIdle :: sSrc1 :: sOp :: sSrc2 :: sEqual :: sNegStart :: sNegEnd :: Nil = Enum(7)
    val add = 0.U
    val sub = 1.U
    val state = RegInit(sIdle)

    // Next State Decoder =====================
    switch(state){
        is(sIdle){
            // 判別 src1 為負數或是正數
            when(negStart){ state := sNegStart
            }.otherwise{ state := sSrc1 }
        }
        is(sSrc1){
            // src1 之後會遇到 op, = 或 )
            when(negEnd){ state := sNegEnd}
            .elsewhen(equal){state := sEqual}
            .elsewhen(operator) {state := sOp}
        }
        is(sNegStart){
            // 遇到左括號：判斷為負數開始，利用「是否已經遇過第一個 operator」判斷此刻的數字為 src1 or src2
            when(num){ state := Mux(!regSrc, sSrc1, sSrc2)}
            .elsewhen(equal) {state := sEqual}
        }
        is(sNegEnd){
            // 遇到右括號：判斷為負數結束（後面只會接 = 或 op code）
            when(equal){state := sEqual}
            .elsewhen(operator){state:= sOp}
        }
        is(sOp){
            // op 遇到的數字一定是 src2
            when(num) {state := sSrc2}
            // op 遇到 (: 負數開始
            .elsewhen(negStart) {state := sNegStart}
        }
        is(sSrc2){
            // src2 之後會遇到 op, = 或 )
            when(operator) {state := sOp}
            .elsewhen(equal) {state := sEqual}
            .elsewhen(negEnd) {state := sNegEnd}
        }
        is(sEqual){ state := sIdle}
    }    
    
    // state operation ============================================
    when(state === sSrc1){src1 := (src1<<3.U) + (src1<<1.U) + in_buffer}
    when(state === sSrc2){src2 := (src2<<3.U) + (src2<<1.U) + in_buffer}
    when(state === sNegStart){
        // 用「是否遇過第一個 operator」判別此刻的負數是 src1 還是 src2
        when(!regSrc) {regSrc1Neg := true.B}
        .otherwise{regSrc2Neg := true.B}
    }
    when(state === sNegEnd){
        // 負數處理：僅在遇到 ) 時才進行，並用 regSrc1(2)Neg 這個寄存器判斷要對哪一個數字做負數處理
        when(!regSrc){
            src1 := ~src1 + 1.U
            regSrc1Neg := false.B
        }.otherwise{
            src2 := ~src2 + 1.U
            regSrc2Neg := false.B
        }
    }
    when(state === sOp){
        // 遇到 op
        regSrc := true.B // 進到此 block 代表至少遇過一次 op，因此將判別是否為第一個 op 的寄存器設為 true
        op := in_buffer - 10.U
        // 如果已經遇過第一個 op，代表此時至少為第二個 op，可以開始將 src1 和 src2 相加（都是加到 src1 上） 
        when(regSrc){
            src1 := MuxLookup(op, 0.U, Seq(
                add -> (src1 + src2),
                sub -> (src1 - src2)
            ))
            src2 := 0.U // 清空 src2，準備讓下一個 src2 輸入（或是沒有）
        }  
    }

    when(state === sEqual){
        // reset
        src1 := 0.U
        src2 := 0.U
        op := 0.U
        in_buffer := 0.U
        regSrc1Neg := false.B
        regSrc2Neg := false.B
        regSrc := false.B
    }

    io.value.valid := Mux(state === sEqual,true.B,false.B)
    io.value.bits := src1+src2
}
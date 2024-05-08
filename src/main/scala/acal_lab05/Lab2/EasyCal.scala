package acal_lab05.Lab2

import chisel3._
import chisel3.util._

class EasyCal extends Module{
    val io = IO(new Bundle{
        val key_in = Input(UInt(4.W))
        val value = Output(Valid(UInt(32.W)))
    })

    //Wire Declaration===================================
    // 抓到 key_in 中屬於 operator 的部分
    val operator = WireDefault(false.B)
    operator := io.key_in >= 10.U && io.key_in <= 12.U
    // 抓到 key_in 中屬於 number 的部分
    val num = WireDefault(false.B)
    num := io.key_in < 10.U

    // 抓到 equal（一開始設為 false），如果 io.key_in === 15.U 時則表示 equal = true
    // 照著 code 看起來他是一個一個抓輸入ㄉ！
    val equal = WireDefault(false.B)
    equal := io.key_in === 15.U


    //Reg Declaration====================================
    // 總共會有四個 register
    val in_buffer = RegNext(io.key_in) // 紀錄 key in 的內容
    val src1 = RegInit(0.U(32.W))      // 紀錄 src1 此刻的數值
    val op = RegInit(0.U(2.W))         // 紀錄 operator 屬於哪一啦
    val src2 = RegInit(0.U(32.W))      // 紀錄 src1 此刻的數值  

    //State and Constant Declaration=====================
    val sIdle :: sSrc1 :: sOp :: sSrc2 :: sEqual :: Nil = Enum(5)
    val add = 0.U
    val sub = 1.U
    val mul = 2.U

    val state = RegInit(sIdle)

    //Next State Decoder
    // 根據開始 machine 以及輸入的順序：第一個數字、operator、第二個數字、=
    switch(state){
        is(sIdle){
            state := sSrc1
        }
        is(sSrc1){
            when(operator) {state := sOp}
        }
        is(sOp){
            when(num) {state := sSrc2}
        }
        is(sSrc2){
            when(equal) {state := sEqual}
        }
        is(sEqual){
            state := sSrc1
        }
    }
    //==================================================
    // src1 是存在 register 內的值，in_buffer 才是現在輸入的值
    when(state === sSrc1){src1 := (src1<<3.U) + (src1<<1.U) + in_buffer}
    when(state === sSrc2){src2 := (src2<<3.U) + (src2<<1.U) + in_buffer}
    when(state === sOp){op := in_buffer - 10.U}

    when(state === sEqual){
        src1 := 0.U
        src2 := 0.U
        op := 0.U
        in_buffer := 0.U
    }

    // 接下來就是直接輸出計算之後的結果
    io.value.valid := Mux(state === sEqual,true.B,false.B)
    io.value.bits := MuxLookup(op,0.U,Seq(
        add -> (src1 + src2),
        sub -> (src1 - src2),
        mul -> (src1 * src2)
    ))
}
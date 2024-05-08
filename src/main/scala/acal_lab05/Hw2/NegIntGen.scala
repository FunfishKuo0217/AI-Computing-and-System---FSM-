package acal_lab05.Hw2

import chisel3._
import chisel3.util._

class NegIntGen extends Module{
    val io = IO(new Bundle{
        val key_in = Input(UInt(4.W))
        val value = Output(Valid(UInt(32.W)))
    })

    // initialize equal
    val equal = WireDefault(false.B)
    equal := io.key_in === 15.U // 直到判斷輸入 15 才是 equal

    // state 宣告
    val sIdle :: sAccept :: sEqual :: sAcceptNeg :: Nil = Enum(4)
    val state = RegInit(sIdle)
    //Next State Decoder
    switch(state){
        is(sIdle){
            when(io.key_in === 13.U){
                state := sAcceptNeg
            }.otherwise{state := sAccept}
        }
        is(sAccept){when(equal) {state := sEqual}}
        is(sAcceptNeg){when(equal) {state := sEqual}}
        is(sEqual){
            state := sAccept
        }
    }
    
    when(io.key_in === 13.U){
        state := sAcceptNeg
    }
    // 先把 io.key_in 放入 Register 裡面
    val in_buffer = RegNext(io.key_in)
    val number = RegInit(0.U(32.W))
    
    when(state === sAccept){
        number := (number<<3.U) + (number<<1.U) + in_buffer
    }.elsewhen(state === sAcceptNeg){
        //number := 13.U
        when((in_buffer =/= 13.U) && (in_buffer =/= 11.U) && (in_buffer =/= 14.U)){
            number := (number<<3.U) + (number<<1.U) - in_buffer
        }
        
    }.elsewhen(state === sEqual){
        // 如果使用者按下 equal (=)
        // 把 buffer、number 都清空
        in_buffer := 0.U
        number := 0.U
    }

    io.value.valid := Mux(state === sEqual,true.B,false.B)
    io.value.bits := number
}
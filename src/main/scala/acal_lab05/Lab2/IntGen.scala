package acal_lab05.Lab2

import chisel3._
import chisel3.util._

class IntGen extends Module{
    val io = IO(new Bundle{
        val key_in = Input(UInt(4.W))
        val value = Output(Valid(UInt(32.W)))
    })

    val equal = WireDefault(false.B)
    // 在 io.key_in 確認是否等於 15: 對，這是在 key-in 的時候會以 string 傳入的訊息
    // key_in 的 10~15 都是運算符號
    equal := io.key_in === 15.U

    val sIdle :: sAccept :: sEqual :: Nil = Enum(3)
    val state = RegInit(sIdle)
    //Next State Decoder
    switch(state){
        is(sIdle){
        state := sAccept
        }
        is(sAccept){
        when(equal) {state := sEqual}
        }
        is(sEqual){
            state := sAccept
        }
    }

    // 先把 io.key_in 放入 Register 裡面
    val in_buffer = RegNext(io.key_in)

    val number = RegInit(0.U(32.W))
    when(state === sAccept){
        // 如果還可以接受 input
        // 乘以 10 的設計：用 shift 來完成
        number := (number<<3.U) + (number<<1.U) + in_buffer
    }.elsewhen(state === sEqual){
        // 如果使用者按下 equal (=)
        // 把 buffer、number 都清空
        in_buffer := 0.U
        number := 0.U
    }

    io.value.valid := Mux(state === sEqual,true.B,false.B)
    io.value.bits := number
}
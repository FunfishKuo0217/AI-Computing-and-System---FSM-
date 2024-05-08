package acal_lab05.Hw1

import chisel3._
import chisel3.util._

class TrafficLight_p(Ytime:Int, Gtime:Int, Ptime:Int) extends Module{
  val io = IO(new Bundle{
    val P_button = Input(Bool())
    val H_traffic = Output(UInt(2.W))
    val V_traffic = Output(UInt(2.W))
    val P_traffic = Output(UInt(2.W))
    val timer     = Output(UInt(5.W))
  })
  val Off = 0.U
  val Red = 1.U
  val Yellow = 2.U
  val Green = 3.U

  //please implement your code below...

  // state Enum: 加入行人狀態（sPG）
  val sIdle :: sHGVR :: sHYVR :: sHRVG :: sHRVY :: sPG :: Nil = Enum(6)
  
  //State register
  val state = RegInit(sIdle)

  // ==== Counter ==== 
  val cntMode = WireDefault(0.U(2.W)) // 用一個 bit 確認此時的 CntMode = (0, 1)
  val cntReg = RegInit(0.U(4.W))      // 用一個 4-bit register 存取現在的 count down value
  val cntDone = Wire(Bool())          // 用 bool 確認是否數完
  cntDone := cntReg === 0.U           // 必須進行 initialize
  
  when(cntDone){
    when(cntMode === 0.U){
      cntReg := (Gtime-1).U
    }.elsewhen(cntMode === 1.U){
      cntReg := (Ytime-1).U
    }.otherwise{
      cntReg := (Ptime-1).U // 加入 sPG situation
    }
  }.otherwise{
    cntReg := cntReg - 1.U
  }
  // ==== Counter end ====

  // ==== Next State Decoder ==== 
  when(io.P_button){
    state := sPG
  }.otherwise{
    switch(state){
      is(sIdle){
        state := sHGVR
      }
      is(sHGVR){
        when(cntDone) {state := sHYVR}
      } 
      is(sHYVR){
        when(cntDone) {state := sHRVG}
      }
      is(sHRVG){
        when(cntDone) {state := sHRVY}
      }
      is(sHRVY){
        when(cntDone) {state := sHGVR}
      }
      // 結束時接回原本的狀態，並從頭開始倒數（感恩ㄟ，還好不用記倒數幾秒）
      is(sPG){
        when(cntDone) {state := state}
      }
    }
  }
  // ==== Next State Decode end ==== 
  
  //Output Decoder
  //Default statement(最初狀態)
  cntMode := 0.U
  io.H_traffic := Off
  io.V_traffic := Off
  io.P_traffic := Off

  switch(state){
    is(sHGVR){
      cntMode := 1.U
      io.H_traffic := Green
      io.V_traffic := Red
      io.P_traffic := Red
    }
    is(sHYVR){
      cntMode := 0.U
      io.H_traffic := Yellow
      io.V_traffic := Red
      io.P_traffic := Red
    }
    is(sHRVG){
      cntMode := 1.U
      io.H_traffic := Red
      io.V_traffic := Green
      io.P_traffic := Red
    }
    is(sHRVY){
      cntMode := 0.U
      io.H_traffic := Red
      io.V_traffic := Yellow
      io.P_traffic := Red
    }
    is(sPG){
      cntMode := 2.U
      io.H_traffic := Red
      io.V_traffic := Red
      io.P_traffic := Green
    }
  }

  io.timer := cntReg

  // output
  // io.H_traffic := 0.U
  // io.V_traffic := 0.U
  // io.P_traffic := 0.U
  // io.timer := 0.U
}
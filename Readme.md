(NTHU_111065531_郭芳妤)  ACAL 2024 Spring Lab 5 HW Submission
===

[toc]

## Gitlab code link

- Gitlab link - https://course.playlab.tw/git/funfish111065531/lab05

## Hw5-1 TrafficLight with Pedestrian button
### Scala Code
```scala=
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
}
```
### Waveform
| state | sIdle | sHGVR | sHYVR | sHRVG | sHRVY | sPG |
|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:---:|
|  map  |   0   |   1   |   2   |   3   |   4   |  5  |

第一段說明：
* 此為不受行人號誌干擾的前 25 週期，可以看到各 state 對應的 io_timer 都有依照該有的秒數進行（sHGVR + sHYVR = sHRVG + sHRVY）
* 對輸出的 H_traffic 和V_traffic 一一對應，ex. 當 sHGVR（H為綠燈、V為紅燈時）, H_traffic 輸出信號為 11(Green)、V_traffic 輸出信號為 01(Red)
* 此時沒有行人號誌的 input 訊號
![](https://course.playlab.tw/md/uploads/d99b8664-1cb0-4d25-bb92-98cb5c62af0a.png)

第二段說明：
* state = 5 (sPG)，此時 P_traffic 為 11 (Green)
* 當按下行人 button 時，無論是 H_traffic 或 V_traffic 當下是何種狀態，可以看到兩者都立刻調整回 01 (Red)
![](https://course.playlab.tw/md/uploads/f0163f31-7357-4d01-967a-b502b423d667.png)



## Hw5-2-1 Negative Integer Generator
### Scala Code

```scala=
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
    // sAccept: 接受正數輸入
    // sEqual : 進行結果輸出
    // sAcceptNeg: 接受負數輸入
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
        // 負數輸入：將數值處理為負值
        when((in_buffer != 13.U) && (in_buffer != 11.U) && (in_buffer != 14.U)){
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
```
### Test Result
![](https://course.playlab.tw/md/uploads/0e3d20d9-d4ca-4fd1-8d93-9304156d0f35.png)




## Hw5-2-2 N operands N-1 operators(+、-)
### Scala Code
> 請放上你的程式碼並加上註解(中英文不限)，讓 TA明白你是如何完成的。
```scala=
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
```

### Test Result
![](https://course.playlab.tw/md/uploads/3eb8e779-04f2-4fd1-8104-6d77ae92bbcd.png)


## Hw5-2-3 Order of Operation (+、-、*、(、))
### Scala Code
> 請放上你的程式碼並加上註解(中英文不限)，讓 TA明白你是如何完成的。
```scala=
package acal_lab05.Hw2

import chisel3._
import chisel3.util._

class CpxCal extends Module{
    val io = IO(new Bundle{
        val key_in = Input(UInt(4.W))
        val value = Output(Valid(UInt(32.W)))
    })

    // Wire Declaration===================================
    val operator = WireDefault(false.B)
    val num = WireDefault(false.B)
    val equal = WireDefault(false.B)
    val lp = WireDefault(false.B)
    val rp = WireDefault(false.B)
    val negSign = WireDefault(false.B)
    
    // 判別此時的輸入
    operator := io.key_in >= 10.U && io.key_in <= 12.U // +, -, *
    num := io.key_in < 10.U
    equal := io.key_in === 15.U
    lp := io.key_in === 13.U
    rp := io.key_in === 14.U
    negSign := io.key_in === 11.U // -, 用來判斷此為單純的 operator 或者負號

    // Reg Declaration====================================
    val in_buffer = RegNext(io.key_in) // 紀錄 key in 的內容
    val src1 = RegInit(0.U(32.W))      // 紀錄 src1 此刻的數值
    val op = RegInit(0.U(2.W))         // 紀錄 operator 屬於哪一啦
    val src2 = RegInit(0.U(32.W))      // 紀錄 src2 此刻的數值  
    val regSrc = RegInit(false.B)      // is the first operator occur?
    val regSrc1Neg = RegInit(false.B)  // is src1 negative?
    val regSrc2Neg = RegInit(false.B)  // is src2 negative?
    val regInfix = RegInit(VecInit(Seq.fill(50)(0.U(32.W)))) // 存 input list，預設長度為50
    val regPost = RegInit(VecInit(Seq.fill(50)(0.U(32.W)))) // 存 postfix list，預設長度為50
    val regOp = RegInit(VecInit(Seq.fill(50)(0.U(32.W)))) // 確認 infix 哪一項是 operator (solve編碼衝突)，預設長度為50
    val regPostOp = RegInit(VecInit(Seq.fill(50)(0.U(32.W)))) // 用來記錄 postfix 中哪些屬於 operator (solve編碼衝突)，預設長度為50
    
    val regItemCnt = RegInit(0.U(32.W)) // 紀錄輸入進來的 infix 長度 
    val regRP_wait = RegInit(false.B) // 此 register 用來判斷類似（"3)+"）這種狀況：要把括號插在 src2 和 operator 中間
    val regIn2Post_idx = RegInit(0.U(32.W)) // index for infix -> postfix (as for loop 中的 i++)
    val regPost_idx = RegInit(0.U(32.W)) //index for infix -> postfix（as postfix index），並用來記錄轉成 postfix 後有幾個 elements
    
    val regEva_idx = RegInit(0.U(32.W)) // index for evaluation 
    val regIn2Post_done = RegInit(false.B) // 判斷 infix -> postfix 轉製完成
    val regCal_done = RegInit(false.B) // 判斷計算完成


    // State and Constant Declaration =====================
    val sIdle :: sSrc1 :: sOp :: sSrc2 :: sEqual :: sLP :: sRP :: sIn2Post :: sCal :: sCalEnd :: sNegStart :: sNegEnd :: Nil = Enum(12)
    val add = 0.U
    val sub = 1.U
    val mul = 2.U
    val state = RegInit(sIdle)

    // stack allcation
    val stack_mem = Mem(50, UInt(32.W))
    val sp = RegInit(0.U(32.W))
    val stack_eva = Mem(50, UInt(32.W))
    val sp_eva = RegInit(0.U(32.W))

    // Next State Decoder =====================
    switch(state){
        is(sIdle){ 
            when(lp){ state := sLP
            }.otherwise{ state := sSrc1 }
        }
        is(sSrc1){
            when(rp){ state := sNegEnd } //src1 遇到右括號理論上只可能是因為 negative, 故改為 sNegEnd
            .elsewhen(equal){state := sEqual }
            .elsewhen(operator) {state := sOp }
        }
        // parent start -> num or negative
        is(sLP){
            when(num){
                // 遇到數字，表示這個左括號是 op，將 ( 放入 infix 並標示為 op = true
                regInfix(regItemCnt) := 13.U
                regOp(regItemCnt) := 1.U
                regItemCnt := regItemCnt + 1.U
                state := Mux(!regSrc, sSrc1, sSrc2)
            }
            .elsewhen(lp){
                // 再次遇到左括號，表示這個左括號是 op，將 ( 放入 infix 並標示為 op = true
                regInfix(regItemCnt) := 13.U
                regOp(regItemCnt) := 1.U
                regItemCnt := regItemCnt + 1.U
                state := sLP
            }
            .elsewhen(negSign){
                state := sNegStart
            }
        }
        is(sNegStart){
            when(num){ state := Mux(!regSrc, sSrc1, sSrc2)}
        }
        is(sNegEnd){
            when(equal){state := sEqual}
            .elsewhen(operator){state:= sOp}
            .elsewhen(rp){
                regRP_wait := true.B
                state := sRP
            }
        }
        is(sOp){
            when(num) {state := sSrc2}
            .elsewhen(lp) {state := sLP}
        }
        is(sSrc2){
            when(operator) {state := sOp}
            .elsewhen(equal) {state := sEqual}
            .elsewhen(rp) {
                
                when(regSrc2Neg){ state := sNegEnd
                }.otherwise{ 
                    state := sRP
                    regRP_wait := true.B     
                }
            }
        } 
        is(sRP){
            when(operator){ state := sOp }
            .elsewhen(rp){ state := sRP}
            .elsewhen(equal){ state := sEqual}
        }
        is(sEqual){ state := sIn2Post}
        is(sIn2Post){when(regIn2Post_done){state := sCal}}
        is(sCal) {when(regCal_done){state := sCalEnd}}
        is(sCalEnd){state := sIdle}
    }    
    
    // state operation ============================================
    // ======== Block1: Store(infix generations, 包含數字運算) ========
    // 邏輯幾乎等同 LongCal, 唯一的區別是要在遇到 op 時對  "...3)+..." 這種狀況做例外處理
    // 詳情請見 line 152-186
    when(state === sSrc1){src1 := (src1<<3.U) + (src1<<1.U) + in_buffer}
    when(state === sSrc2){src2 := (src2<<3.U) + (src2<<1.U) + in_buffer}
    when(state === sNegStart){
        when(!regSrc) {regSrc1Neg := true.B}
        .otherwise{regSrc2Neg := true.B}
    }
    when(state === sNegEnd){
        when(!regSrc){
            src1 := ~src1 + 1.U
            regSrc1Neg := false.B
        }.otherwise{
            src2 := ~src2 + 1.U
            regSrc2Neg := false.B
        }
    }
    when(state === sOp){
        when(!regSrc){
            regInfix(regItemCnt) := src1
            regOp(regItemCnt) := 0.U
            regInfix(regItemCnt+1.U) := in_buffer
            regOp(regItemCnt+1.U) := 1.U
            regItemCnt := regItemCnt + 2.U
        }
        when(regSrc){
            // regRP_wait = true，代表遇到此 op 時，前面除了要放入 src2 這個數字，中間還要插入 )
            // 總共插入 3 個 element, regItemCnt += 3
            // 同時使用 regOp 紀錄 element 屬於 op(1) 或是 num(0)
            when(regRP_wait){
                regInfix(regItemCnt) := src2
                regInfix(regItemCnt+1.U) := 14.U
                regInfix(regItemCnt+2.U) := in_buffer
                regOp(regItemCnt) := 0.U
                regOp(regItemCnt+1.U) := 1.U
                regOp(regItemCnt+2.U) := 1.U
                regItemCnt := regItemCnt + 3.U
                regRP_wait := false.B
            }.otherwise{
            // regRP_wait = false，表示正常的 src2+op
            // 總共插入 2 個 element, regItemCnt += 2
            // 同時使用 regOp 紀錄 element 屬於 op(1) 或是 num(0)
                regInfix(regItemCnt) := src2
                regInfix(regItemCnt+1.U) := in_buffer
                regOp(regItemCnt) := 0.U
                regOp(regItemCnt+1.U) := 1.U
                regItemCnt := regItemCnt + 2.U
            }
            src2 := 0.U
        }
        regSrc := true.B
    }
    when(state === sEqual){
        // 插入 = 之前的最後一個數字（因為 = 之前不會是 operator）
        when(!regSrc){
            regInfix(regItemCnt) := src1
            regOp(regItemCnt) := 0.U
        }      
        when(regSrc){
            regInfix(regItemCnt) := src2
            regOp(regItemCnt) := 0.U
        } 
        regItemCnt := regItemCnt + 1.U
        state := sIn2Post
    }
    // ======== Block1: Store(infix generations, 包含數字運算) end ========
    
    // ======== Block2: Infix-to-postfix ========
    when(state === sIn2Post){
        // infix to posfix conversion
        when(regIn2Post_idx < regItemCnt){
            // operand
            when(regOp(regIn2Post_idx) === 0.U){
                regPost(regPost_idx) := regInfix(regIn2Post_idx)
                regPostOp(regPost_idx) := 0.U
                regPost_idx := regPost_idx + 1.U
                regIn2Post_idx := regIn2Post_idx + 1.U
            }
            // "(": 用剛剛紀錄的 regOp 解決編碼衝突(13)
            when(regOp(regIn2Post_idx) === 1.U && regInfix(regIn2Post_idx) === 13.U){
                // push it into stack_mem
                stack_mem(sp) := 13.U
                sp := sp + 1.U // 指向下一個放 ( 的地方
                regIn2Post_idx := regIn2Post_idx + 1.U
            }
            // ")": 用剛剛紀錄的 regOp 解決編碼衝突(14)
            when(regOp(regIn2Post_idx) === 1.U && regInfix(regIn2Post_idx) === 14.U){
                when(stack_mem(sp-1.U) =/= 13.U){
                    regPost(regPost_idx) := stack_mem(sp-1.U)
                    regPostOp(regPost_idx) := 1.U
                    regPost_idx := regPost_idx + 1.U
                    sp := sp - 1.U // pop
                }.otherwise{ 
                    regIn2Post_idx := regIn2Post_idx + 1.U
                    sp := sp - 1.U // pop
                }
            }
            // operators: 用剛剛紀錄的 regOp 解決編碼衝突(10, 11, 12)
            when(regOp(regIn2Post_idx) === 1.U && regInfix(regIn2Post_idx) <= 12.U){
                // stack 不為空(while)
                when(sp > 0.U && regInfix(regIn2Post_idx) <= stack_mem(sp-1.U) && stack_mem(sp-1.U) =/= 13.U){
                    regPost(regPost_idx) := stack_mem(sp-1.U)
                    regPostOp(regPost_idx) := 1.U
                    regPost_idx := regPost_idx + 1.U
                    sp := sp - 1.U // pop
                }.otherwise{
                    // stack 為空或 priority 條件不符合
                    stack_mem(sp) := regInfix(regIn2Post_idx)
                    sp := sp + 1.U
                    regIn2Post_idx := regIn2Post_idx + 1.U // index foward
                }
            }
        }.otherwise{
            when(sp > 0.U){
                regPost(regPost_idx) := stack_mem(sp-1.U)
                regPostOp(regPost_idx) := 1.U
                regPost_idx := regPost_idx + 1.U
                sp := sp - 1.U //pop
            }.otherwise{
                regIn2Post_done := true.B
            }
        }
    }
    // ======== Block2: Infix-to-postfix end ========

    // ======== Block3: Calculation ========
    when(state === sCal){
        when(regEva_idx < regPost_idx){
            // num
            when(regPostOp(regEva_idx) === 0.U){
                stack_eva(sp_eva) := regPost(regEva_idx)
                sp_eva := (sp_eva + 1.U)
            }
            .otherwise{
            // operators(10, 11, 12)
                val num1 = stack_eva(sp_eva-2.U) // top 的下面那個數
                val num2 = stack_eva(sp_eva-1.U) // top
                switch(regPost(regEva_idx)){
                    is(10.U){
                        stack_eva(sp_eva-2.U) := (num1 + num2)
                        sp_eva := sp_eva-1.U
                    }
                    is(11.U){
                        stack_eva(sp_eva-2.U) := (num1 - num2)
                        sp_eva := sp_eva-1.U
                    }
                    is(12.U){
                        stack_eva(sp_eva-2.U) := (num1 * num2)
                        sp_eva := sp_eva-1.U
                    }
                }
            }
            regEva_idx := regEva_idx + 1.U
        }.otherwise{
            state := sCalEnd
        }
    }
    // ======== Block3: Calculation end ========
    when(state === sCalEnd){
        src1 := 0.U
        src2 := 0.U
        op := 0.U
        in_buffer := 0.U
        regSrc1Neg := false.B
        regSrc2Neg := false.B
        regSrc := false.B
        regOp := Reg(Vec(50, UInt(32.W)))
        regInfix := Reg(Vec(50, UInt(32.W)))
        regPost := Reg(Vec(50, UInt(32.W)))
        regPostOp := Reg(Vec(50, UInt(32.W)))
        regItemCnt := 0.U
        regRP_wait := false.B
        regIn2Post_done := false.B
        regIn2Post_idx := 0.U
        regPost_idx := 0.U
        regEva_idx := 0.U
        sp := 0.U
        sp_eva := 0.U
    }

    io.value.valid := Mux(state === sCalEnd, true.B, false.B)
    io.value.bits := stack_eva(0) // 回傳存在 stack top 的數字，即為答案
}
```
### Test Result
![](https://course.playlab.tw/md/uploads/de6d4c7d-e221-4650-9b8f-ce67b67bd8ad.png)


## Hw5-3-1 Pseudo Random Number Generator
### Scala Code
```scala=
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
```
### Test Result
:::info
在此僅截下半段 cases 以及 pass information
:::
![](https://course.playlab.tw/md/uploads/96ab3014-a0fe-4b5e-b80a-877ca2d549f2.png)


## Hw5-3-2 1A2B game quiz
### Scala Code
```scala=
package acal_lab05.Hw3

import chisel3._
import chisel3.util._

class NumGuess(seed:Int = 1) extends Module{
    require (seed > 0 , "Seed cannot be 0")
    val io  = IO(new Bundle{
        val gen = Input(Bool())
        val guess = Input(UInt(16.W))
        val puzzle = Output(Vec(4,UInt(4.W)))
        val ready  = Output(Bool())
        val g_valid  = Output(Bool())
        val A      = Output(UInt(3.W))
        val B      = Output(UInt(3.W))

        //don't care at Hw6-3-2 but should be considered at Bonus
        val s_valid = Input(Bool())
    })
    
    // state ============
    val sIdle :: sGen :: sWait :: sInput :: sPuzzleSet :: sVerifierA :: sVerifierB :: sAnswerCal :: sOutput :: sGuessAgain :: Nil = Enum(10)
    val state = RegInit(sIdle)

    // module, reg initialization ============
    val prng = Module(new PRNG(1)) // set seed = 1, our completed module in hw5-3-1
    val guessNums = RegInit(VecInit(Seq.fill(4)(0.U(4.W)))) // what we guess (input)
    val puzzleNums = RegInit(VecInit(Seq.fill(4)(0.U(4.W)))) // answer
    val cntA = RegInit(0.U) // nums correct && pos correct
    val cntB = RegInit(0.U) // only num correct
    val regVerifyA = RegInit(VecInit(Seq.fill(4)(0.U(3.W)))) // A 的檢查器
    val regVerifyB = RegInit(VecInit(Seq.fill(12)(0.U(3.W)))) // B 的檢查器

    // register for control flow ============
    val regGoWait = RegInit(false.B)
    val regGoVerifierA = RegInit(false.B)
    val regGoVerifierB = RegInit(false.B)
    val regGoAnsCal = RegInit(false.B)
    val regGoOutput = RegInit(false.B)
    val regGoReset = RegInit(false.B)

    // default output setting ============
    io.puzzle(0) := 0.U(4.W)
    io.puzzle(1) := 0.U(4.W)
    io.puzzle(2) := 0.U(4.W)
    io.puzzle(3) := 0.U(4.W)
    io.ready  := false.B
    io.g_valid  := false.B
    io.A      := 0.U
    io.B      := 0.U
    prng.io.gen := false.B

    // state Decoder ============
    switch(state){
        is(sIdle){
            when(io.gen){state := sGen}
        }
        is(sGen){
            when(regGoWait){state := sWait}
        }
        is(sWait){
            when(prng.io.ready){state := sPuzzleSet}
        }
        is(sPuzzleSet){
            when(io.ready){state := sInput}
        }
        is(sInput){
            when(regGoVerifierA){state := sVerifierA}
        }
        is(sVerifierA){
            when(regGoVerifierB){state := sVerifierB}
        }
        is(sVerifierB){
            when(regGoAnsCal){state := sAnswerCal}
        }
        is(sAnswerCal){
            when(regGoOutput){state := sOutput}
        }
        is(sOutput){
            state := sGuessAgain
        }
        is(sGuessAgain){
            state := sInput
        }
    }

    // state Operations
    when(state === sGen){
        // 呼叫 prng 進行 generate 一組亂數
        prng.io.gen := true.B
        regGoWait := RegNext(true.B)
    }
    when(state === sWait){
        regGoWait := false.B
    }
    when(state === sPuzzleSet){
        // 將 prng 的答案進行輸出（io.puzzle）-> for output
        io.puzzle(0) := prng.io.puzzle(0)
        io.puzzle(1) := prng.io.puzzle(1)
        io.puzzle(2) := prng.io.puzzle(2)
        io.puzzle(3) := prng.io.puzzle(3)
        // 將 prng 的答案放入 puzzleNums register -> for verification
        puzzleNums(0) := prng.io.puzzle(0)
        puzzleNums(1) := prng.io.puzzle(1)
        puzzleNums(2) := prng.io.puzzle(2)
        puzzleNums(3) := prng.io.puzzle(3)
        io.ready := RegNext(true.B)
    }
    when(state === sInput){
        // 將 input 放入 guessNums register
        guessNums(0) := io.guess(3, 0).asUInt
        guessNums(1) := io.guess(7, 4).asUInt
        guessNums(2) := io.guess(11, 8).asUInt
        guessNums(3) := io.guess(15, 12).asUInt
        regGoVerifierA := RegNext(true.B)
    }
    when(state === sVerifierA){
        regGoVerifierA := false.B
        // 檢查器 A 目的：數字正確且位置正確
        regVerifyA(0) := Mux(puzzleNums(0) === guessNums(0), 1.U, 0.U)
        regVerifyA(1) := Mux(puzzleNums(1) === guessNums(1), 1.U, 0.U)
        regVerifyA(2) := Mux(puzzleNums(2) === guessNums(2), 1.U, 0.U)
        regVerifyA(3) := Mux(puzzleNums(3) === guessNums(3), 1.U, 0.U)
        regGoVerifierB := RegNext(true.B)
    }
    when(state === sVerifierB){
        regGoVerifierB := false.B
        // 檢查器 B 目的：數字正確、位置錯誤
        regVerifyB(0) := Mux(puzzleNums(0) === guessNums(1), 1.U, 0.U)
        regVerifyB(1) := Mux(puzzleNums(0) === guessNums(2), 1.U, 0.U)
        regVerifyB(2) := Mux(puzzleNums(0) === guessNums(3), 1.U, 0.U)
        regVerifyB(3) := Mux(puzzleNums(1) === guessNums(0), 1.U, 0.U)
        regVerifyB(4) := Mux(puzzleNums(1) === guessNums(2), 1.U, 0.U)
        regVerifyB(5) := Mux(puzzleNums(1) === guessNums(3), 1.U, 0.U)
        regVerifyB(6) := Mux(puzzleNums(2) === guessNums(0), 1.U, 0.U)
        regVerifyB(7) := Mux(puzzleNums(2) === guessNums(1), 1.U, 0.U)
        regVerifyB(8) := Mux(puzzleNums(2) === guessNums(3), 1.U, 0.U)
        regVerifyB(9) := Mux(puzzleNums(3) === guessNums(0), 1.U, 0.U)
        regVerifyB(10) := Mux(puzzleNums(3) === guessNums(1), 1.U, 0.U)
        regVerifyB(11) := Mux(puzzleNums(3) === guessNums(2), 1.U, 0.U)
        regGoAnsCal := RegNext(true.B)
    }
    when(state === sAnswerCal){
        // 計算 GuessNum 的正確數量（幾A幾B）
        regGoAnsCal := false.B
        cntA := regVerifyA(0) + regVerifyA(1) + regVerifyA(2) + regVerifyA(3)
        cntB := regVerifyB(0) + regVerifyB(1) + regVerifyB(2) + regVerifyB(3) + regVerifyB(4) + regVerifyB(5) + regVerifyB(6) + regVerifyB(7) + regVerifyB(8) + regVerifyB(9) + regVerifyB(10) + regVerifyB(11)
        regGoOutput := RegNext(true.B)
    }
    when(state === sOutput){
        regGoOutput := false.B
        io.g_valid := true.B
        // 將計算的結果放到 output
        io.A := cntA.asUInt
        io.B := cntB.asUInt
        // input(猜的數字) set to zeros
        guessNums(0) := 0.U
        guessNums(1) := 0.U
        guessNums(2) := 0.U
        guessNums(3) := 0.U
    }
    when(state === sGuessAgain){
        io.g_valid := false.B
        io.A := cntA.asUInt // 讓 A 保持，否則會被判斷 != 4 而繼續進入迴圈
    }
}
```
### Test Result
![](https://course.playlab.tw/md/uploads/f1e94362-6ea1-404f-894e-a845648cb5cc.png)


<!-- ## Bonus : 1A2B hardware solver [Optional]
### Scala Code
> 請放上你的程式碼並加上註解(中英文不限)，讓 TA明白你是如何完成的。
```scala=
## scala code & comment
```
### Test Result
> 請放上你通過test的結果，驗證程式碼的正確性。(螢幕截圖即可) -->


## 文件中的問答題
- Q1:Hw5-2-2(長算式)以及Lab5-2-2(短算式)，需要的暫存器數量是否有差別？如果有，是差在哪裡呢？
    :::success
    有，需要增加兩個 register 給負數（即遇到左括號和右括號）的情況，以利我們判斷目前的輸入數字（src1和src2）是否要進行負數處理。
    :::
- Q2:你是如何處理**Hw5-2-3**有提到的關於**編碼衝突**的問題呢?
    :::success
    我是開一個 vector 寄存器，裡面用 0 和 1 來記錄對應位置的 element 是屬於 number 或 operator，比如 infix vector [1][+][-3] 對應的 regOp vector 就會是 [0][1][0]，利用這個方法，我在轉 infix->postfix 以及後面 calculation 時，都可以透過這個 vector 判別當前遇到的 element 為數值或 operator 以進行相應的處理。
    :::
- Q3:你是如何處理**Hw5-3-1**1A2B題目產生時**數字重複**的問題呢?
    :::success
    我利用一個長度為 6 的 vector，利用 Mux 檢查在 output 的 4 個數字中的兩兩相同情形（之所以取6，是因為 C4取2 的結果 = 6）。如果 vector 中的 6 個值都是 0 則代表可以放心輸出答案（因為沒有任何兩兩相同的情形）；反之，我們將 state 調整回 sLFSR（即重新 generate 一組數字）。
    :::



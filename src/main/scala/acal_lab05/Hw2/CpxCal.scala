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
    // 詳情請見 line 160-186
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
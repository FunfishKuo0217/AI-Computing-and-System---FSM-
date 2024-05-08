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
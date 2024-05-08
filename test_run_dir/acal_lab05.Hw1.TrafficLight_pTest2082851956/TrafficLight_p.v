module TrafficLight_p(
  input        clock,
  input        reset,
  input        io_P_button,
  output [1:0] io_H_traffic,
  output [1:0] io_V_traffic,
  output [1:0] io_P_traffic,
  output [4:0] io_timer
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] state; // @[TrafficLight_p.scala 25:22]
  reg [3:0] cntReg; // @[TrafficLight_p.scala 29:23]
  wire  cntDone = cntReg == 4'h0; // @[TrafficLight_p.scala 31:21]
  wire  _T_11 = 3'h1 == state; // @[Conditional.scala 37:30]
  wire  _T_12 = 3'h2 == state; // @[Conditional.scala 37:30]
  wire  _T_13 = 3'h3 == state; // @[Conditional.scala 37:30]
  wire  _T_14 = 3'h4 == state; // @[Conditional.scala 37:30]
  wire  _T_15 = 3'h5 == state; // @[Conditional.scala 37:30]
  wire [1:0] _GEN_15 = _T_15 ? 2'h2 : 2'h0; // @[Conditional.scala 39:67 TrafficLight_p.scala 107:15 TrafficLight_p.scala 76:11]
  wire [1:0] _GEN_18 = _T_14 ? 2'h0 : _GEN_15; // @[Conditional.scala 39:67 TrafficLight_p.scala 101:15]
  wire [1:0] _GEN_22 = _T_13 ? 2'h1 : _GEN_18; // @[Conditional.scala 39:67 TrafficLight_p.scala 95:15]
  wire [1:0] _GEN_26 = _T_12 ? 2'h0 : _GEN_22; // @[Conditional.scala 39:67 TrafficLight_p.scala 89:15]
  wire [1:0] cntMode = _T_11 ? 2'h1 : _GEN_26; // @[Conditional.scala 40:58 TrafficLight_p.scala 83:15]
  wire [2:0] _GEN_0 = cntMode == 2'h1 ? 3'h2 : 3'h4; // @[TrafficLight_p.scala 36:32 TrafficLight_p.scala 37:14 TrafficLight_p.scala 39:14]
  wire [2:0] _GEN_1 = cntMode == 2'h0 ? 3'h6 : _GEN_0; // @[TrafficLight_p.scala 34:26 TrafficLight_p.scala 35:14]
  wire [3:0] _T_4 = cntReg - 4'h1; // @[TrafficLight_p.scala 42:22]
  wire  _T_5 = 3'h0 == state; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_3 = cntDone ? 3'h2 : state; // @[TrafficLight_p.scala 55:23 TrafficLight_p.scala 55:30 TrafficLight_p.scala 25:22]
  wire [2:0] _GEN_4 = cntDone ? 3'h3 : state; // @[TrafficLight_p.scala 58:23 TrafficLight_p.scala 58:30 TrafficLight_p.scala 25:22]
  wire [2:0] _GEN_5 = cntDone ? 3'h4 : state; // @[TrafficLight_p.scala 61:23 TrafficLight_p.scala 61:30 TrafficLight_p.scala 25:22]
  wire [2:0] _GEN_6 = cntDone ? 3'h1 : state; // @[TrafficLight_p.scala 64:23 TrafficLight_p.scala 64:30 TrafficLight_p.scala 25:22]
  wire [2:0] _GEN_9 = _T_14 ? _GEN_6 : state; // @[Conditional.scala 39:67]
  wire [2:0] _GEN_10 = _T_13 ? _GEN_5 : _GEN_9; // @[Conditional.scala 39:67]
  wire [2:0] _GEN_11 = _T_12 ? _GEN_4 : _GEN_10; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_17 = _T_15 ? 2'h3 : 2'h0; // @[Conditional.scala 39:67 TrafficLight_p.scala 110:20 TrafficLight_p.scala 79:16]
  wire  _GEN_19 = _T_14 | _T_15; // @[Conditional.scala 39:67 TrafficLight_p.scala 102:20]
  wire [1:0] _GEN_20 = _T_14 ? 2'h2 : {{1'd0}, _T_15}; // @[Conditional.scala 39:67 TrafficLight_p.scala 103:20]
  wire [1:0] _GEN_21 = _T_14 ? 2'h1 : _GEN_17; // @[Conditional.scala 39:67 TrafficLight_p.scala 104:20]
  wire  _GEN_23 = _T_13 | _GEN_19; // @[Conditional.scala 39:67 TrafficLight_p.scala 96:20]
  wire [1:0] _GEN_24 = _T_13 ? 2'h3 : _GEN_20; // @[Conditional.scala 39:67 TrafficLight_p.scala 97:20]
  wire [1:0] _GEN_25 = _T_13 ? 2'h1 : _GEN_21; // @[Conditional.scala 39:67 TrafficLight_p.scala 98:20]
  wire [1:0] _GEN_27 = _T_12 ? 2'h2 : {{1'd0}, _GEN_23}; // @[Conditional.scala 39:67 TrafficLight_p.scala 90:20]
  wire [1:0] _GEN_28 = _T_12 ? 2'h1 : _GEN_24; // @[Conditional.scala 39:67 TrafficLight_p.scala 91:20]
  wire [1:0] _GEN_29 = _T_12 ? 2'h1 : _GEN_25; // @[Conditional.scala 39:67 TrafficLight_p.scala 92:20]
  assign io_H_traffic = _T_11 ? 2'h3 : _GEN_27; // @[Conditional.scala 40:58 TrafficLight_p.scala 84:20]
  assign io_V_traffic = _T_11 ? 2'h1 : _GEN_28; // @[Conditional.scala 40:58 TrafficLight_p.scala 85:20]
  assign io_P_traffic = _T_11 ? 2'h1 : _GEN_29; // @[Conditional.scala 40:58 TrafficLight_p.scala 86:20]
  assign io_timer = {{1'd0}, cntReg}; // @[TrafficLight_p.scala 114:12]
  always @(posedge clock) begin
    if (reset) begin // @[TrafficLight_p.scala 25:22]
      state <= 3'h0; // @[TrafficLight_p.scala 25:22]
    end else if (io_P_button) begin // @[TrafficLight_p.scala 47:20]
      state <= 3'h5; // @[TrafficLight_p.scala 48:11]
    end else if (_T_5) begin // @[Conditional.scala 40:58]
      state <= 3'h1; // @[TrafficLight_p.scala 52:15]
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      state <= _GEN_3;
    end else begin
      state <= _GEN_11;
    end
    if (reset) begin // @[TrafficLight_p.scala 29:23]
      cntReg <= 4'h0; // @[TrafficLight_p.scala 29:23]
    end else if (cntDone) begin // @[TrafficLight_p.scala 33:16]
      cntReg <= {{1'd0}, _GEN_1};
    end else begin
      cntReg <= _T_4; // @[TrafficLight_p.scala 42:12]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  cntReg = _RAND_1[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule

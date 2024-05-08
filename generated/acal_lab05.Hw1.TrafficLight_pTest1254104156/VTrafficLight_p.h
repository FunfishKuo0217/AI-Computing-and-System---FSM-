// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary design header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef _VTRAFFICLIGHT_P_H_
#define _VTRAFFICLIGHT_P_H_  // guard

#include "verilated.h"

//==========

class VTrafficLight_p__Syms;
class VTrafficLight_p_VerilatedVcd;


//----------

VL_MODULE(VTrafficLight_p) {
  public:
    
    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    VL_IN8(clock,0,0);
    VL_IN8(reset,0,0);
    VL_IN8(io_P_button,0,0);
    VL_OUT8(io_H_traffic,1,0);
    VL_OUT8(io_V_traffic,1,0);
    VL_OUT8(io_P_traffic,1,0);
    VL_OUT8(io_timer,4,0);
    
    // LOCAL SIGNALS
    // Internals; generally not touched by application code
    CData/*2:0*/ TrafficLight_p__DOT__state;
    CData/*3:0*/ TrafficLight_p__DOT__cntReg;
    CData/*0:0*/ TrafficLight_p__DOT__cntDone;
    CData/*0:0*/ TrafficLight_p__DOT___T_11;
    CData/*1:0*/ TrafficLight_p__DOT__cntMode;
    CData/*3:0*/ TrafficLight_p__DOT___T_4;
    CData/*0:0*/ TrafficLight_p__DOT___T_5;
    CData/*2:0*/ TrafficLight_p__DOT___GEN_3;
    CData/*2:0*/ TrafficLight_p__DOT___GEN_11;
    
    // LOCAL VARIABLES
    // Internals; generally not touched by application code
    CData/*0:0*/ __Vclklast__TOP__clock;
    IData/*31:0*/ __Vm_traceActivity;
    
    // INTERNAL VARIABLES
    // Internals; generally not touched by application code
    VTrafficLight_p__Syms* __VlSymsp;  // Symbol table
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(VTrafficLight_p);  ///< Copying not allowed
  public:
    /// Construct the model; called by application code
    /// The special name  may be used to make a wrapper with a
    /// single model invisible with respect to DPI scope names.
    VTrafficLight_p(const char* name = "TOP");
    /// Destroy the model; called (often implicitly) by application code
    ~VTrafficLight_p();
    /// Trace signals in the model; called by application code
    void trace(VerilatedVcdC* tfp, int levels, int options = 0);
    
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval();
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    
    // INTERNAL METHODS
  private:
    static void _eval_initial_loop(VTrafficLight_p__Syms* __restrict vlSymsp);
  public:
    void __Vconfigure(VTrafficLight_p__Syms* symsp, bool first);
  private:
    static QData _change_request(VTrafficLight_p__Syms* __restrict vlSymsp);
    void _ctor_var_reset() VL_ATTR_COLD;
  public:
    static void _eval(VTrafficLight_p__Syms* __restrict vlSymsp);
  private:
#ifdef VL_DEBUG
    void _eval_debug_assertions();
#endif  // VL_DEBUG
  public:
    static void _eval_initial(VTrafficLight_p__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _eval_settle(VTrafficLight_p__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _sequent__TOP__1(VTrafficLight_p__Syms* __restrict vlSymsp);
    static void _settle__TOP__2(VTrafficLight_p__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void traceChgThis(VTrafficLight_p__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__2(VTrafficLight_p__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__3(VTrafficLight_p__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__4(VTrafficLight_p__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceFullThis(VTrafficLight_p__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) VL_ATTR_COLD;
    static void traceFullThis__1(VTrafficLight_p__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) VL_ATTR_COLD;
    static void traceInitThis(VTrafficLight_p__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) VL_ATTR_COLD;
    static void traceInitThis__1(VTrafficLight_p__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) VL_ATTR_COLD;
    static void traceInit(VerilatedVcd* vcdp, void* userthis, uint32_t code);
    static void traceFull(VerilatedVcd* vcdp, void* userthis, uint32_t code);
    static void traceChg(VerilatedVcd* vcdp, void* userthis, uint32_t code);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard

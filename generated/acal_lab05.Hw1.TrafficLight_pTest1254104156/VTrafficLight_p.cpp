// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VTrafficLight_p.h for the primary calling header

#include "VTrafficLight_p.h"
#include "VTrafficLight_p__Syms.h"

//==========

VL_CTOR_IMP(VTrafficLight_p) {
    VTrafficLight_p__Syms* __restrict vlSymsp = __VlSymsp = new VTrafficLight_p__Syms(this, name());
    VTrafficLight_p* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Reset internal values
    
    // Reset structure values
    _ctor_var_reset();
}

void VTrafficLight_p::__Vconfigure(VTrafficLight_p__Syms* vlSymsp, bool first) {
    if (0 && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
}

VTrafficLight_p::~VTrafficLight_p() {
    delete __VlSymsp; __VlSymsp=NULL;
}

void VTrafficLight_p::eval() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VTrafficLight_p::eval\n"); );
    VTrafficLight_p__Syms* __restrict vlSymsp = this->__VlSymsp;  // Setup global symbol table
    VTrafficLight_p* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
#ifdef VL_DEBUG
    // Debug assertions
    _eval_debug_assertions();
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        vlSymsp->__Vm_activity = true;
        _eval(vlSymsp);
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = _change_request(vlSymsp);
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("TrafficLight_p.v", 1, "",
                "Verilated model didn't converge\n"
                "- See DIDNOTCONVERGE in the Verilator manual");
        } else {
            __Vchange = _change_request(vlSymsp);
        }
    } while (VL_UNLIKELY(__Vchange));
}

void VTrafficLight_p::_eval_initial_loop(VTrafficLight_p__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    _eval_initial(vlSymsp);
    vlSymsp->__Vm_activity = true;
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
        _eval_settle(vlSymsp);
        _eval(vlSymsp);
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = _change_request(vlSymsp);
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("TrafficLight_p.v", 1, "",
                "Verilated model didn't DC converge\n"
                "- See DIDNOTCONVERGE in the Verilator manual");
        } else {
            __Vchange = _change_request(vlSymsp);
        }
    } while (VL_UNLIKELY(__Vchange));
}

VL_INLINE_OPT void VTrafficLight_p::_sequent__TOP__1(VTrafficLight_p__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTrafficLight_p::_sequent__TOP__1\n"); );
    VTrafficLight_p* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->TrafficLight_p__DOT__cntReg = ((IData)(vlTOPp->reset)
                                            ? 0U : 
                                           ((IData)(vlTOPp->TrafficLight_p__DOT__cntDone)
                                             ? ((0U 
                                                 == (IData)(vlTOPp->TrafficLight_p__DOT__cntMode))
                                                 ? 6U
                                                 : 
                                                ((1U 
                                                  == (IData)(vlTOPp->TrafficLight_p__DOT__cntMode))
                                                  ? 2U
                                                  : 4U))
                                             : (IData)(vlTOPp->TrafficLight_p__DOT___T_4)));
    vlTOPp->TrafficLight_p__DOT__state = ((IData)(vlTOPp->reset)
                                           ? 0U : ((IData)(vlTOPp->io_P_button)
                                                    ? 5U
                                                    : 
                                                   ((IData)(vlTOPp->TrafficLight_p__DOT___T_5)
                                                     ? 1U
                                                     : 
                                                    ((IData)(vlTOPp->TrafficLight_p__DOT___T_11)
                                                      ? (IData)(vlTOPp->TrafficLight_p__DOT___GEN_3)
                                                      : (IData)(vlTOPp->TrafficLight_p__DOT___GEN_11)))));
    vlTOPp->TrafficLight_p__DOT__cntDone = (0U == (IData)(vlTOPp->TrafficLight_p__DOT__cntReg));
    vlTOPp->TrafficLight_p__DOT___T_4 = (0xfU & ((IData)(vlTOPp->TrafficLight_p__DOT__cntReg) 
                                                 - (IData)(1U)));
    vlTOPp->io_timer = vlTOPp->TrafficLight_p__DOT__cntReg;
    vlTOPp->TrafficLight_p__DOT___T_11 = (1U == (IData)(vlTOPp->TrafficLight_p__DOT__state));
    vlTOPp->TrafficLight_p__DOT__cntMode = ((1U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                             ? 1U : 
                                            ((2U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                              ? 0U : 
                                             ((3U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                               ? 1U
                                               : ((4U 
                                                   == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                                   ? 0U
                                                   : 
                                                  ((5U 
                                                    == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                                    ? 2U
                                                    : 0U)))));
    vlTOPp->TrafficLight_p__DOT___T_5 = (0U == (IData)(vlTOPp->TrafficLight_p__DOT__state));
    vlTOPp->io_H_traffic = ((1U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                             ? 3U : ((2U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                      ? 2U : ((3U == (IData)(vlTOPp->TrafficLight_p__DOT__state)) 
                                              | ((4U 
                                                  == (IData)(vlTOPp->TrafficLight_p__DOT__state)) 
                                                 | (5U 
                                                    == (IData)(vlTOPp->TrafficLight_p__DOT__state))))));
    vlTOPp->io_V_traffic = ((1U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                             ? 1U : ((2U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                      ? 1U : ((3U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                               ? 3U
                                               : ((4U 
                                                   == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                                   ? 2U
                                                   : 
                                                  (5U 
                                                   == (IData)(vlTOPp->TrafficLight_p__DOT__state))))));
    vlTOPp->io_P_traffic = ((1U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                             ? 1U : ((2U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                      ? 1U : ((3U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                               ? 1U
                                               : ((4U 
                                                   == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                                   ? 1U
                                                   : 
                                                  ((5U 
                                                    == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                                    ? 3U
                                                    : 0U)))));
    vlTOPp->TrafficLight_p__DOT___GEN_3 = ((0U == (IData)(vlTOPp->TrafficLight_p__DOT__cntReg))
                                            ? 2U : (IData)(vlTOPp->TrafficLight_p__DOT__state));
    vlTOPp->TrafficLight_p__DOT___GEN_11 = ((2U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                             ? ((0U 
                                                 == (IData)(vlTOPp->TrafficLight_p__DOT__cntReg))
                                                 ? 3U
                                                 : (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                             : ((3U 
                                                 == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                                 ? 
                                                ((0U 
                                                  == (IData)(vlTOPp->TrafficLight_p__DOT__cntReg))
                                                  ? 4U
                                                  : (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                                 : 
                                                ((4U 
                                                  == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                                  ? 
                                                 ((0U 
                                                   == (IData)(vlTOPp->TrafficLight_p__DOT__cntReg))
                                                   ? 1U
                                                   : (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                                  : (IData)(vlTOPp->TrafficLight_p__DOT__state))));
}

void VTrafficLight_p::_settle__TOP__2(VTrafficLight_p__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTrafficLight_p::_settle__TOP__2\n"); );
    VTrafficLight_p* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->TrafficLight_p__DOT__cntDone = (0U == (IData)(vlTOPp->TrafficLight_p__DOT__cntReg));
    vlTOPp->TrafficLight_p__DOT___T_11 = (1U == (IData)(vlTOPp->TrafficLight_p__DOT__state));
    vlTOPp->TrafficLight_p__DOT__cntMode = ((1U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                             ? 1U : 
                                            ((2U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                              ? 0U : 
                                             ((3U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                               ? 1U
                                               : ((4U 
                                                   == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                                   ? 0U
                                                   : 
                                                  ((5U 
                                                    == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                                    ? 2U
                                                    : 0U)))));
    vlTOPp->TrafficLight_p__DOT___T_4 = (0xfU & ((IData)(vlTOPp->TrafficLight_p__DOT__cntReg) 
                                                 - (IData)(1U)));
    vlTOPp->TrafficLight_p__DOT___T_5 = (0U == (IData)(vlTOPp->TrafficLight_p__DOT__state));
    vlTOPp->io_H_traffic = ((1U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                             ? 3U : ((2U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                      ? 2U : ((3U == (IData)(vlTOPp->TrafficLight_p__DOT__state)) 
                                              | ((4U 
                                                  == (IData)(vlTOPp->TrafficLight_p__DOT__state)) 
                                                 | (5U 
                                                    == (IData)(vlTOPp->TrafficLight_p__DOT__state))))));
    vlTOPp->io_V_traffic = ((1U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                             ? 1U : ((2U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                      ? 1U : ((3U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                               ? 3U
                                               : ((4U 
                                                   == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                                   ? 2U
                                                   : 
                                                  (5U 
                                                   == (IData)(vlTOPp->TrafficLight_p__DOT__state))))));
    vlTOPp->io_P_traffic = ((1U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                             ? 1U : ((2U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                      ? 1U : ((3U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                               ? 1U
                                               : ((4U 
                                                   == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                                   ? 1U
                                                   : 
                                                  ((5U 
                                                    == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                                    ? 3U
                                                    : 0U)))));
    vlTOPp->io_timer = vlTOPp->TrafficLight_p__DOT__cntReg;
    vlTOPp->TrafficLight_p__DOT___GEN_3 = ((0U == (IData)(vlTOPp->TrafficLight_p__DOT__cntReg))
                                            ? 2U : (IData)(vlTOPp->TrafficLight_p__DOT__state));
    vlTOPp->TrafficLight_p__DOT___GEN_11 = ((2U == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                             ? ((0U 
                                                 == (IData)(vlTOPp->TrafficLight_p__DOT__cntReg))
                                                 ? 3U
                                                 : (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                             : ((3U 
                                                 == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                                 ? 
                                                ((0U 
                                                  == (IData)(vlTOPp->TrafficLight_p__DOT__cntReg))
                                                  ? 4U
                                                  : (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                                 : 
                                                ((4U 
                                                  == (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                                  ? 
                                                 ((0U 
                                                   == (IData)(vlTOPp->TrafficLight_p__DOT__cntReg))
                                                   ? 1U
                                                   : (IData)(vlTOPp->TrafficLight_p__DOT__state))
                                                  : (IData)(vlTOPp->TrafficLight_p__DOT__state))));
}

void VTrafficLight_p::_eval(VTrafficLight_p__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTrafficLight_p::_eval\n"); );
    VTrafficLight_p* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    if (((IData)(vlTOPp->clock) & (~ (IData)(vlTOPp->__Vclklast__TOP__clock)))) {
        vlTOPp->_sequent__TOP__1(vlSymsp);
        vlTOPp->__Vm_traceActivity = (2U | vlTOPp->__Vm_traceActivity);
    }
    // Final
    vlTOPp->__Vclklast__TOP__clock = vlTOPp->clock;
}

void VTrafficLight_p::_eval_initial(VTrafficLight_p__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTrafficLight_p::_eval_initial\n"); );
    VTrafficLight_p* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->__Vclklast__TOP__clock = vlTOPp->clock;
}

void VTrafficLight_p::final() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTrafficLight_p::final\n"); );
    // Variables
    VTrafficLight_p__Syms* __restrict vlSymsp = this->__VlSymsp;
    VTrafficLight_p* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void VTrafficLight_p::_eval_settle(VTrafficLight_p__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTrafficLight_p::_eval_settle\n"); );
    VTrafficLight_p* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_settle__TOP__2(vlSymsp);
    vlTOPp->__Vm_traceActivity = (1U | vlTOPp->__Vm_traceActivity);
}

VL_INLINE_OPT QData VTrafficLight_p::_change_request(VTrafficLight_p__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTrafficLight_p::_change_request\n"); );
    VTrafficLight_p* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void VTrafficLight_p::_eval_debug_assertions() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTrafficLight_p::_eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((clock & 0xfeU))) {
        Verilated::overWidthError("clock");}
    if (VL_UNLIKELY((reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
    if (VL_UNLIKELY((io_P_button & 0xfeU))) {
        Verilated::overWidthError("io_P_button");}
}
#endif  // VL_DEBUG

void VTrafficLight_p::_ctor_var_reset() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTrafficLight_p::_ctor_var_reset\n"); );
    // Body
    clock = VL_RAND_RESET_I(1);
    reset = VL_RAND_RESET_I(1);
    io_P_button = VL_RAND_RESET_I(1);
    io_H_traffic = VL_RAND_RESET_I(2);
    io_V_traffic = VL_RAND_RESET_I(2);
    io_P_traffic = VL_RAND_RESET_I(2);
    io_timer = VL_RAND_RESET_I(5);
    TrafficLight_p__DOT__state = VL_RAND_RESET_I(3);
    TrafficLight_p__DOT__cntReg = VL_RAND_RESET_I(4);
    TrafficLight_p__DOT__cntDone = VL_RAND_RESET_I(1);
    TrafficLight_p__DOT___T_11 = VL_RAND_RESET_I(1);
    TrafficLight_p__DOT__cntMode = VL_RAND_RESET_I(2);
    TrafficLight_p__DOT___T_4 = VL_RAND_RESET_I(4);
    TrafficLight_p__DOT___T_5 = VL_RAND_RESET_I(1);
    TrafficLight_p__DOT___GEN_3 = VL_RAND_RESET_I(3);
    TrafficLight_p__DOT___GEN_11 = VL_RAND_RESET_I(3);
    __Vm_traceActivity = 0;
}

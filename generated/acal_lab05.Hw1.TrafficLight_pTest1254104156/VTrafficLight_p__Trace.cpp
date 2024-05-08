// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VTrafficLight_p__Syms.h"


//======================

void VTrafficLight_p::traceChg(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    VTrafficLight_p* t = (VTrafficLight_p*)userthis;
    VTrafficLight_p__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (vlSymsp->getClearActivity()) {
        t->traceChgThis(vlSymsp, vcdp, code);
    }
}

//======================


void VTrafficLight_p::traceChgThis(VTrafficLight_p__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VTrafficLight_p* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c = code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
        if (VL_UNLIKELY((1U & (vlTOPp->__Vm_traceActivity 
                               | (vlTOPp->__Vm_traceActivity 
                                  >> 1U))))) {
            vlTOPp->traceChgThis__2(vlSymsp, vcdp, code);
        }
        if (VL_UNLIKELY((2U & vlTOPp->__Vm_traceActivity))) {
            vlTOPp->traceChgThis__3(vlSymsp, vcdp, code);
        }
        vlTOPp->traceChgThis__4(vlSymsp, vcdp, code);
    }
    // Final
    vlTOPp->__Vm_traceActivity = 0U;
}

void VTrafficLight_p::traceChgThis__2(VTrafficLight_p__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VTrafficLight_p* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c = code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
        vcdp->chgBus(c+1,(vlTOPp->TrafficLight_p__DOT__cntMode),2);
    }
}

void VTrafficLight_p::traceChgThis__3(VTrafficLight_p__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VTrafficLight_p* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c = code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
        vcdp->chgBus(c+9,(vlTOPp->TrafficLight_p__DOT__state),3);
        vcdp->chgBus(c+17,(vlTOPp->TrafficLight_p__DOT__cntReg),4);
        vcdp->chgBit(c+25,((0U == (IData)(vlTOPp->TrafficLight_p__DOT__cntReg))));
    }
}

void VTrafficLight_p::traceChgThis__4(VTrafficLight_p__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VTrafficLight_p* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c = code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
        vcdp->chgBit(c+33,(vlTOPp->clock));
        vcdp->chgBit(c+41,(vlTOPp->reset));
        vcdp->chgBit(c+49,(vlTOPp->io_P_button));
        vcdp->chgBus(c+57,(vlTOPp->io_H_traffic),2);
        vcdp->chgBus(c+65,(vlTOPp->io_V_traffic),2);
        vcdp->chgBus(c+73,(vlTOPp->io_P_traffic),2);
        vcdp->chgBus(c+81,(vlTOPp->io_timer),5);
    }
}

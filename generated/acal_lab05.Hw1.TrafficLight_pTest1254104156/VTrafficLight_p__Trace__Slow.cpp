// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VTrafficLight_p__Syms.h"


//======================

void VTrafficLight_p::trace(VerilatedVcdC* tfp, int, int) {
    tfp->spTrace()->addCallback(&VTrafficLight_p::traceInit, &VTrafficLight_p::traceFull, &VTrafficLight_p::traceChg, this);
}
void VTrafficLight_p::traceInit(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->open()
    VTrafficLight_p* t = (VTrafficLight_p*)userthis;
    VTrafficLight_p__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (!Verilated::calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
                        "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vcdp->scopeEscape(' ');
    t->traceInitThis(vlSymsp, vcdp, code);
    vcdp->scopeEscape('.');
}
void VTrafficLight_p::traceFull(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    VTrafficLight_p* t = (VTrafficLight_p*)userthis;
    VTrafficLight_p__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    t->traceFullThis(vlSymsp, vcdp, code);
}

//======================


void VTrafficLight_p::traceInitThis(VTrafficLight_p__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VTrafficLight_p* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c = code;
    if (0 && vcdp && c) {}  // Prevent unused
    vcdp->module(vlSymsp->name());  // Setup signal names
    // Body
    {
        vlTOPp->traceInitThis__1(vlSymsp, vcdp, code);
    }
}

void VTrafficLight_p::traceFullThis(VTrafficLight_p__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VTrafficLight_p* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c = code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
        vlTOPp->traceFullThis__1(vlSymsp, vcdp, code);
    }
    // Final
    vlTOPp->__Vm_traceActivity = 0U;
}

void VTrafficLight_p::traceInitThis__1(VTrafficLight_p__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VTrafficLight_p* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c = code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
        vcdp->declBit(c+33,"clock", false,-1);
        vcdp->declBit(c+41,"reset", false,-1);
        vcdp->declBit(c+49,"io_P_button", false,-1);
        vcdp->declBus(c+57,"io_H_traffic", false,-1, 1,0);
        vcdp->declBus(c+65,"io_V_traffic", false,-1, 1,0);
        vcdp->declBus(c+73,"io_P_traffic", false,-1, 1,0);
        vcdp->declBus(c+81,"io_timer", false,-1, 4,0);
        vcdp->declBit(c+33,"TrafficLight_p clock", false,-1);
        vcdp->declBit(c+41,"TrafficLight_p reset", false,-1);
        vcdp->declBit(c+49,"TrafficLight_p io_P_button", false,-1);
        vcdp->declBus(c+57,"TrafficLight_p io_H_traffic", false,-1, 1,0);
        vcdp->declBus(c+65,"TrafficLight_p io_V_traffic", false,-1, 1,0);
        vcdp->declBus(c+73,"TrafficLight_p io_P_traffic", false,-1, 1,0);
        vcdp->declBus(c+81,"TrafficLight_p io_timer", false,-1, 4,0);
        vcdp->declBus(c+9,"TrafficLight_p state", false,-1, 2,0);
        vcdp->declBus(c+17,"TrafficLight_p cntReg", false,-1, 3,0);
        vcdp->declBit(c+25,"TrafficLight_p cntDone", false,-1);
        vcdp->declBus(c+1,"TrafficLight_p cntMode", false,-1, 1,0);
    }
}

void VTrafficLight_p::traceFullThis__1(VTrafficLight_p__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VTrafficLight_p* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c = code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
        vcdp->fullBus(c+1,(vlTOPp->TrafficLight_p__DOT__cntMode),2);
        vcdp->fullBus(c+9,(vlTOPp->TrafficLight_p__DOT__state),3);
        vcdp->fullBus(c+17,(vlTOPp->TrafficLight_p__DOT__cntReg),4);
        vcdp->fullBit(c+25,((0U == (IData)(vlTOPp->TrafficLight_p__DOT__cntReg))));
        vcdp->fullBit(c+33,(vlTOPp->clock));
        vcdp->fullBit(c+41,(vlTOPp->reset));
        vcdp->fullBit(c+49,(vlTOPp->io_P_button));
        vcdp->fullBus(c+57,(vlTOPp->io_H_traffic),2);
        vcdp->fullBus(c+65,(vlTOPp->io_V_traffic),2);
        vcdp->fullBus(c+73,(vlTOPp->io_P_traffic),2);
        vcdp->fullBus(c+81,(vlTOPp->io_timer),5);
    }
}

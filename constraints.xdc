## =============================================================================
## constraints.xdc  –  Nexys A7-100T
## Top module: group_controller_top
##
## Port list (must match Verilog exactly — Vivado is case-sensitive):
##   Inputs : clk, reset, sw_hall[4:0], btn_commit, emergency_stop
##   Outputs: move_up_A, move_down_A, motor_stop_A
##            move_up_B, move_down_B, motor_stop_B
##            seg[6:0], dp, an[7:0]
## =============================================================================

## ── Clock (100 MHz onboard oscillator) ───────────────────────────────────────
set_property PACKAGE_PIN E3      [get_ports clk]
set_property IOSTANDARD  LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk -period 10.00 -waveform {0 5} [get_ports clk]

## ── Reset  (CPU_RESET red button — active LOW on Nexys A7) ───────────────────
## Note: invert in Verilog if your reset port is active HIGH (~cpu_resetn)
set_property PACKAGE_PIN C12     [get_ports reset]
set_property IOSTANDARD  LVCMOS33 [get_ports reset]

## ── Hall call switches  SW[4:0]  (sw_hall[0]=floor0 … sw_hall[4]=floor4) ─────
set_property PACKAGE_PIN V17     [get_ports {sw_hall[0]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {sw_hall[0]}]

set_property PACKAGE_PIN V16     [get_ports {sw_hall[1]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {sw_hall[1]}]

set_property PACKAGE_PIN W16     [get_ports {sw_hall[2]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {sw_hall[2]}]

set_property PACKAGE_PIN W17     [get_ports {sw_hall[3]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {sw_hall[3]}]

set_property PACKAGE_PIN W15     [get_ports {sw_hall[4]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {sw_hall[4]}]

## ── Commit button  (BTNC — centre push-button) ───────────────────────────────
set_property PACKAGE_PIN U18     [get_ports btn_commit]
set_property IOSTANDARD  LVCMOS33 [get_ports btn_commit]

## ── Emergency stop  (BTNU — up push-button) ──────────────────────────────────
set_property PACKAGE_PIN T18     [get_ports emergency_stop]
set_property IOSTANDARD  LVCMOS33 [get_ports emergency_stop]

## ── Car A status LEDs ─────────────────────────────────────────────────────────
## LD0 — move_up_A   (lit while Car A is rising)
set_property PACKAGE_PIN U16     [get_ports move_up_A]
set_property IOSTANDARD  LVCMOS33 [get_ports move_up_A]

## LD1 — move_down_A (lit while Car A is descending)
set_property PACKAGE_PIN E19     [get_ports move_down_A]
set_property IOSTANDARD  LVCMOS33 [get_ports move_down_A]

## LD2 — motor_stop_A (lit while Car A is stopped / idle)
set_property PACKAGE_PIN U19     [get_ports motor_stop_A]
set_property IOSTANDARD  LVCMOS33 [get_ports motor_stop_A]

## ── Car B status LEDs ─────────────────────────────────────────────────────────
## LD3 — move_up_B   (lit while Car B is rising)
set_property PACKAGE_PIN V19     [get_ports move_up_B]
set_property IOSTANDARD  LVCMOS33 [get_ports move_up_B]

## LD4 — move_down_B (lit while Car B is descending)
set_property PACKAGE_PIN W18     [get_ports move_down_B]
set_property IOSTANDARD  LVCMOS33 [get_ports move_down_B]

## LD5 — motor_stop_B (lit while Car B is stopped / idle)
set_property PACKAGE_PIN U15     [get_ports motor_stop_B]
set_property IOSTANDARD  LVCMOS33 [get_ports motor_stop_B]

## ── 7-Segment Display — Cathodes (active LOW) ────────────────────────────────
## seg = {CA, CB, CC, CD, CE, CF, CG} = {a, b, c, d, e, f, g}
set_property PACKAGE_PIN W7      [get_ports {seg[0]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {seg[0]}]

set_property PACKAGE_PIN W6      [get_ports {seg[1]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {seg[1]}]

set_property PACKAGE_PIN U8      [get_ports {seg[2]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {seg[2]}]

set_property PACKAGE_PIN V8      [get_ports {seg[3]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {seg[3]}]

set_property PACKAGE_PIN U5      [get_ports {seg[4]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {seg[4]}]

set_property PACKAGE_PIN V5      [get_ports {seg[5]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {seg[5]}]

set_property PACKAGE_PIN U7      [get_ports {seg[6]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {seg[6]}]

## ── 7-Segment Display — Decimal point (kept OFF) ─────────────────────────────
set_property PACKAGE_PIN V7      [get_ports dp]
set_property IOSTANDARD  LVCMOS33 [get_ports dp]

## ── 7-Segment Display — Anodes / digit select (active LOW) ───────────────────
## The display cycles through 4 slots:
##   slot 00 → AN[7] shows "A"          (Car A label)
##   slot 01 → AN[4] shows Car A floor
##   slot 10 → AN[3] shows "b"          (Car B label)
##   slot 11 → AN[0] shows Car B floor
## All 8 anodes are driven — constrain all of them.
set_property PACKAGE_PIN U2      [get_ports {an[0]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {an[0]}]

set_property PACKAGE_PIN U4      [get_ports {an[1]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {an[1]}]

set_property PACKAGE_PIN V4      [get_ports {an[2]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {an[2]}]

set_property PACKAGE_PIN W4      [get_ports {an[3]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {an[3]}]

set_property PACKAGE_PIN Y4      [get_ports {an[4]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {an[4]}]

set_property PACKAGE_PIN AA4     [get_ports {an[5]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {an[5]}]

set_property PACKAGE_PIN AB4     [get_ports {an[6]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {an[6]}]

set_property PACKAGE_PIN AB3     [get_ports {an[7]}]
set_property IOSTANDARD  LVCMOS33 [get_ports {an[7]}]

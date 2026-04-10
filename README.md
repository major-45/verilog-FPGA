What This Project Does
This project implements a group elevator controller in Verilog HDL, targeting the Digilent Nexys A7-100T FPGA board. It coordinates two independent elevator cars across five floors (0–4), automatically deciding which car should respond to each floor call in the most efficient way.
Instead of a simple "nearest car" rule, the system uses a cost-based dispatch algorithm that considers three factors for every decision:

Distance — how many floors away is the car from the requested floor
Direction — is the car already heading toward that floor, or would it have to reverse
Load — how many calls has that car already been assigned (to avoid overloading one car)

The result is a system that minimises waiting time and unnecessary travel, similar to how real commercial elevator group controllers work.

System Architecture
The design is split into three Verilog modules:
Module 1 — lift_controller
This is the brain of a single elevator car. Each car runs its own independent instance of this module.

Implements a 4-state Moore FSM: IDLE, MOVE_UP, MOVE_DOWN, EMERGENCY
Uses the LOOK scheduling algorithm — the car continues in its current direction serving all pending floors before reversing, just like a real elevator
A registered, frozen target floor prevents the car from skipping intermediate stops when multiple floors are requested
An already_served register prevents oscillation (re-visiting floors that were just cleared)
A MOVE_DELAY parameter controls how fast the car moves — useful for slowing down to human-visible speed on the FPGA without slowing down the whole FSM logic
Exposes last_dir_out so the dispatcher knows which way the car was last heading

Module 2 — group_dispatcher
This is the decision-maker. It receives all floor calls and assigns each one to the better car.

Calculates a cost score for each car against each pending floor call:

cost = distance + direction_penalty
Direction penalty: 0 if already at the floor, 0 if moving toward it, 1 if idle facing that way, 3 if idle facing away, 4 if actively moving away


Adds a load penalty of +10 to any car that already has assignments, which naturally spreads calls between the two cars
When costs are equal, picks the car with fewer current assignments
Dispatches multiple simultaneous calls efficiently in a single clock cycle by processing the most unequal-cost call first

Module 3 — group_controller_top
The top-level integration module that connects everything together.

Takes floor call inputs from slide switches on the board
A push button commits the current switch state as a new hall call (edge-detected rising trigger)
Drives a multiplexed 7-segment display showing both cars' current floors simultaneously:

Displays A then Car A's floor number, then b then Car B's floor number, cycling fast enough to look static
Uses a 16-bit refresh counter for the multiplexing


Includes an emergency stop input that immediately halts both cars
Slow clock derived from the main 100 MHz clock makes LED state changes visible to the naked eye


LOOK Algorithm — How the Scheduling Works
When a car becomes idle, it picks its next target floor using these rules:

Continue in the same direction first — if last travelling up, look for the nearest pending floor above; if last going down, look for the nearest pending floor below
If nothing in that direction, reverse — switch direction and pick the nearest floor the other way
If nothing at all — stay idle

This guarantees the car stops at every requested floor along the route rather than jumping past intermediate floors.
Example: Car at floor 3, requests for floors 1 and 0 pending, last direction UP

No floors above 3 → reverse to DOWN
Nearest below = floor 1 → travel to floor 1, stop
Now at floor 1, still going DOWN, floor 0 pending below → travel to floor 0, stop
Done ✓

Limitations

Only two elevator cars and five floors — adding more requires more FPGA I/O resources
No passenger load sensing — the system assumes one passenger per call
No directional hall call separation — there is no distinction between an up-call and a down-call at the same floor
No real-time sensors — floor detection is purely counter-based, not physical


Possible Future Improvements

Scale to more floors and more than two cars
Add directional hall buttons (separate up and down calls per floor)
Implement a cabin call panel (calls from inside the elevator, not just from floors)
Add passenger weight/load sensing
Explore more advanced scheduling algorithms such as fuzzy logic or metaheuristic approaches for large-scale deployments




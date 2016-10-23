
module gasPumpContronller_Moore (
  input clk,
  input reset,
  input nozzleSwitch, pressureSensor,
  output reg fuel_out,
  output [2:0] State_out
  );

  // State Variable Declaration
  reg [2:0] present_state = 3'b000;
  reg [2:0] next_state = 3'b000;

  // Binary assignment
  parameter[2:0]
    State_0 = 3'b000,
    State_1 = 3'b001,
    State_2 = 3'b010,
    State_3 = 3'b011,
    State_4 = 3'b100;

// Output present state binary
assign State_out = present_state;

// Register generation (D flip flops)
always @(posedge clk or posedge reset)
  begin : register_generation
    if (reset)
    present_state <= State_0;
    else
    present_state <= next_state;
  end

// Next State Logic
always @(present_state or nozzleSwitch or pressureSensor)
  begin : next_state_logic
    // Default state assignment; use don't cares
    next_state <= 2'bx;
    // Default output assignment
    fuel_out <= 0;

    case (present_state)
      State_0:
        begin
          // List all input conditions
          if (!pressureSensor & !nozzleSwitch)
            next_state <= State_0;
          else if (!pressureSensor & nozzleSwitch)
            next_state <= State_1;
          else if (pressureSensor & !nozzleSwitch)
            next_state <= State_0;
          else next_state <= State_2;
          // Assign output
          fuel_out <= 0;
        end
      State_1:
        begin
          // List all input conditions
          if (!pressureSensor & !nozzleSwitch)
            next_state <= State_0;
          else if (!pressureSensor & nozzleSwitch)
            next_state <= State_1;
          else if (pressureSensor & !nozzleSwitch)
            next_state <= State_0;
          else next_state <= State_2;
          // Assign output
          fuel_out <= 1;
        end
      State_2:
        begin
          // List all input conditions
          if (!pressureSensor & !nozzleSwitch)
            next_state <= State_2;
          else if (!pressureSensor & nozzleSwitch)
            next_state <= State_3;
          else if (pressureSensor & !nozzleSwitch)
            next_state <= State_2;
          else next_state <= State_4;
          // Assign output
          fuel_out <= 0;
        end
      State_3:
        begin
          // List all input conditions
          if (!pressureSensor & !nozzleSwitch)
            next_state <= State_2;
          else if (!pressureSensor & nozzleSwitch)
            next_state <= State_3;  // this is different than state diagram
          else if (pressureSensor & !nozzleSwitch)      // this is different than state diagram
            next_state <= State_2;
          else next_state <= State_4;
          // Assign output
          fuel_out <= 1;
        end
      State_4:
        begin
          // List all input conditions
          if (!pressureSensor & !nozzleSwitch)
            next_state <= State_4;
          else if (!pressureSensor & nozzleSwitch)
            next_state <= State_4;
          else if (pressureSensor & !nozzleSwitch)
            next_state <= State_4;
          else next_state <= State_4;
            // Assign output
            fuel_out <= 0;
        end

      default:
        next_state <= State_0; // necessary to prevent warnings about uncovered states
    endcase

  end

endmodule

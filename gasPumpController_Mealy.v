
module gasPumpContronller_Mealy (
  input clk,
  input reset,
  input nozzleSwitch, pressureSensor,
  output reg fuel_out,
  output [1:0] State_out
  );

  // State Variable Declaration
  reg [1:0] present_state = 2'b00;
  reg [1:0] next_state = 2'b00;

  // Binary assignment
  parameter[1:0]
    State_0 = 2'b00,
    State_1 = 2'b01,
    State_2 = 2'b10;

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
          if (!pressureSensor & !nozzleSwitch) begin
            next_state <= State_0;
            fuel_out <= 0;
            end
          else if (!pressureSensor & nozzleSwitch) begin
            next_state <= State_0;
            fuel_out <= 1;
            end
          else if (pressureSensor & !nozzleSwitch) begin
            next_state <= State_0;
            fuel_out <= 0;
            end
          else begin
            next_state <= State_1;
            fuel_out <= 0;
            end
        end
      State_1:
        begin
          // List all input conditions
          if (!pressureSensor & !nozzleSwitch) begin
            next_state <= State_1;
            fuel_out <= 0;
            end
          else if (!pressureSensor & nozzleSwitch) begin
            next_state <= State_1;
            fuel_out <= 1;
            end
          else if (pressureSensor & !nozzleSwitch) begin
            next_state <= State_1;
            fuel_out <= 0;
            end
          else begin
            next_state <= State_2;
            fuel_out <= 0;
            end
        end
      State_2:
        begin
          // List all input conditions
          if (!pressureSensor & !nozzleSwitch) begin
            next_state <= State_2;
            fuel_out <= 0;
            end
          else if (!pressureSensor & nozzleSwitch) begin
            next_state <= State_2;
            fuel_out <= 0;
            end
          else if (pressureSensor & !nozzleSwitch) begin
            next_state <= State_2;
            fuel_out <= 0;
            end
          else begin
            next_state <= State_2;
            fuel_out <= 0;
            end
        end

      default:
        next_state <= State_0; // necessary to prevent warnings about uncovered states
    endcase

  end

endmodule

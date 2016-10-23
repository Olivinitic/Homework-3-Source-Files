
module Twos_Complementer_Moore (
  input clk,
  input reset,
  input data_In, sync,
  output reg data_Out,
  output [1:0] State_out
  );

  // State Variable Declaration
  reg [1:0] present_state = 2'b00;
  reg [1:0] next_state = 2'b00;

  // Binary assignment
  parameter[2:0]
    State_0 = 2'b00,
    State_1 = 2'b01,
    State_2 = 2'b10,
    State_3 = 2'b11;

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
always @(present_state or data_In or sync)
  begin : next_state_logic
    // Default state assignment; use don't cares
    next_state <= 2'bx;
    // Default output assignment
    data_Out <= 0;

    case (present_state)
      State_0:
        begin
          // List all input conditions
          if (!sync & !data_In)
            next_state <= State_0;
          else if (!sync & data_In)
            next_state <= State_1;
          else if (sync & !data_In)
            next_state <= State_0;
          else next_state <= State_1;
          // Assign output
          data_Out <= 0;
        end
      State_1:
        begin
          // List all input conditions
          if (!sync & !data_In)
            next_state <= State_2;
          else if (!sync & data_In)
            next_state <= State_3;
          else if (sync & !data_In)
            next_state <= State_0;
          else next_state <= State_1;
          // Assign output
          data_Out <= 1;
        end
      State_2:
        begin
          // List all input conditions
          if (!sync & !data_In)
            next_state <= State_2;
          else if (!sync & data_In)
            next_state <= State_3;
          else if (sync & !data_In)
            next_state <= State_0;
          else next_state <= State_1;
          // Assign output
          data_Out <= 1;
        end
      State_3:
        begin
          // List all input conditions
          if (!sync & !data_In)
            next_state <= State_2;
          else if (!sync & data_In)
            next_state <= State_3;  // this is different than state diagram
          else if (sync & !data_In)      // this is different than state diagram
            next_state <= State_0;
          else next_state <= State_1;
          // Assign output
          data_Out <= 0;
        end

      default:
        next_state <= State_0; // necessary to prevent warnings about uncovered states
    endcase

  end

endmodule

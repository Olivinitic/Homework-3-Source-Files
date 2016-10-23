module Twos_Complementer_Mealy (
  input clk, reset,
  input sync, data_In,
  output reg data_Out,
  output [1:0] State_out
  );

  // State the variable declarations for the flip flop states
  reg [1:0] present_state = 0;
  reg [1:0] next_state = 0;

  // Binary Assignment of states
  parameter [1:0]
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
    always @(present_state or data_In or sync)
      begin : next_state_logic
        // Default state assignment; use don't cares
        next_state <= 2'b00;
        // Default output assignment
        data_Out <= 0;

        case (present_state)
          State_0:
            begin
              // List all input conditions
              if (!sync & !data_In) begin
                next_state <= State_0;
                data_Out <= 0;
                end
              else if (!sync & data_In) begin
                next_state <= State_1;
                data_Out <= 1;
                end
              else if (sync & !data_In) begin
                next_state <= State_0;
                data_Out <= 0;
                end
              else begin
                next_state <= State_1;
                data_Out <= 1;
                end
            end
          State_1:
            begin
              // List all input conditions
              if (!sync & !data_In) begin
                next_state <= State_2;
                data_Out <= 1;
                end
              else if (!sync & data_In) begin
                next_state <= State_1;
                data_Out <= 0;
                end
              else if (sync & !data_In) begin
                next_state <= State_0;
                data_Out <= 0;
                end
              else begin
                next_state <= State_1;
                data_Out <= 1;
                end
            end
          State_2:
            begin
              // List all input conditions
              if (!sync & !data_In) begin
                next_state <= State_2;
                data_Out <= 1;
                end
              else if (!sync & data_In) begin
                next_state <= State_1;
                data_Out <= 0;
                end
              else if (sync & !data_In) begin
                next_state <= State_0;
                data_Out <= 0;
                end
              else begin
                next_state <= State_1;
                data_Out <= 1;
                end
            end

          default:
            next_state <= State_0; // necessary to prevent warnings about uncovered states
        endcase

      end

endmodule

`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////

module Twos_Complementer_Moore_tb;

	// Inputs
	reg clk;
	reg reset;
	reg data_In;
	reg sync;

	// Outputs
	wire data_Out;
	wire [1:0] State_out;

	// Reference Output
	reg data_Out_compare_async, data_Out_compare_sync;// checking the synchronization of your data_Out output

	// Instantiate the Unit Under Test (UUT)
	Twos_Complementer_Moore uut (
		.clk(clk),
		.reset(reset),
		.data_In(data_In),
		.sync(sync),
		.data_Out(data_Out),
		.State_out(State_out)
	);

	task toggle_clk;
		begin
			#10 clk = ~clk;
			data_Out_compare_sync = data_Out_compare_async;
			#10 clk = ~clk;
		end
	endtask

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		data_In = 0;
		sync = 0;
		data_Out_compare_sync = 0;
		data_Out_compare_async = 0;

		// Wait 100 ns for global reset to finish
		#100;
 		//reset state machine
		reset = 1;
		#10;
		reset = 0;
		#10;
		// toggle_clk;

		sync = 0;
		data_In = 0;
		toggle_clk;

		sync = 0;
		data_In = 1;
		data_Out_compare_async = 1;
		toggle_clk;

		sync = 1;
		data_In = 0;
		data_Out_compare_async = 0;
		toggle_clk;

		sync = 1;
		data_In = 1;
		data_Out_compare_async = 0;
		toggle_clk;

		sync = 0;
		data_In = 0;
		data_Out_compare_async = 0;
		toggle_clk;

		sync = 0;
		data_In = 1;
		data_Out_compare_async = 1;
		toggle_clk;

		sync = 1;
		data_In = 0;
		data_Out_compare_async = 0;
		toggle_clk;

		sync = 1;
		data_In = 1;
		data_Out_compare_async = 0;
		toggle_clk;

		sync = 0;
		data_In = 0;
		data_Out_compare_async = 1;
		toggle_clk;

		sync = 0;
		data_In = 1;
		data_Out_compare_async = 0;
		toggle_clk;

		sync = 1;
		data_In = 0;
		data_Out_compare_async = 0;
		toggle_clk;

		sync = 1;
		data_In = 1;
		data_Out_compare_async = 1;
		toggle_clk;

		reset = 1;
		#10
		reset = 0;
		#10;

		sync = 0;
        data_In = 0;
        data_Out_compare_async = 1;
        toggle_clk;

        sync = 0;
        data_In = 1;
        data_Out_compare_async = 0;
        toggle_clk;

        sync = 1;
        data_In = 0;
        data_Out_compare_async = 0;
        toggle_clk;

        sync = 1;
        data_In = 1;
        data_Out_compare_async = 1;
        toggle_clk;

    $finish;
	end

endmodule

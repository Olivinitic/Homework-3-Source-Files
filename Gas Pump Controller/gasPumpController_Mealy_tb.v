`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////

module gasPumpContronller_Mealy_tb;

	// Inputs
	reg clk;
	reg reset;
	reg nozzleSwitch;
	reg pressureSensor;

	// Outputs
	wire fuel_out;
	wire [1:0] State_out;

	// Reference Output
	reg fuel_out_compare_async, fuel_out_compare_sync;// checking the synchronization of your fuel_out output

	// Instantiate the Unit Under Test (UUT)
	gasPumpContronller_Mealy uut (
		.clk(clk),
		.reset(reset),
		.nozzleSwitch(nozzleSwitch),
		.pressureSensor(pressureSensor),
		.fuel_out(fuel_out),
		.State_out(State_out)
	);

	task toggle_clk;
		begin
			#10 clk = ~clk;
			fuel_out_compare_sync = fuel_out_compare_async;
			#10 clk = ~clk;
		end
	endtask

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		nozzleSwitch = 0;
		pressureSensor = 0;
		fuel_out_compare_sync = 0;
		fuel_out_compare_async = 0;

		// Wait 100 ns for global reset to finish
		#100;
 		//reset state machine
		reset = 1;
		#10;
		reset = 0;
		#10;
		// toggle_clk;

		pressureSensor = 0;
		nozzleSwitch = 0;
		toggle_clk;

		pressureSensor = 0;
		nozzleSwitch = 1;
		fuel_out_compare_async = 1;
		toggle_clk;

		pressureSensor = 1;
		nozzleSwitch = 0;
		fuel_out_compare_async = 0;
		toggle_clk;

		pressureSensor = 1;
		nozzleSwitch = 1;
		fuel_out_compare_async = 0;
		toggle_clk;

		pressureSensor = 0;
		nozzleSwitch = 0;
		fuel_out_compare_async = 0;
		toggle_clk;

		pressureSensor = 0;
		nozzleSwitch = 1;
		fuel_out_compare_async = 1;
		toggle_clk;

		pressureSensor = 1;
		nozzleSwitch = 0;
		fuel_out_compare_async = 0;
		toggle_clk;

		pressureSensor = 1;
		nozzleSwitch = 1;
		fuel_out_compare_async = 0;
		toggle_clk;

		pressureSensor = 0;
		nozzleSwitch = 0;
		fuel_out_compare_async = 0;
		toggle_clk;

		pressureSensor = 0;
		nozzleSwitch = 1;
		fuel_out_compare_async = 0;
		toggle_clk;

		pressureSensor = 1;
		nozzleSwitch = 0;
		fuel_out_compare_async = 0;
		toggle_clk;

		pressureSensor = 1;
		nozzleSwitch = 1;
		fuel_out_compare_async = 0;
		toggle_clk;

		reset = 1;
		#10
		reset = 0;
		#10;

		pressureSensor = 0;
        nozzleSwitch = 0;
        fuel_out_compare_async = 0;
        toggle_clk;

        pressureSensor = 0;
        nozzleSwitch = 1;
        fuel_out_compare_async = 1;
        toggle_clk;

        pressureSensor = 1;
        nozzleSwitch = 0;
        fuel_out_compare_async = 0;
        toggle_clk;

        pressureSensor = 1;
        nozzleSwitch = 1;
        fuel_out_compare_async = 0;
        toggle_clk;

    $finish;
	end

endmodule

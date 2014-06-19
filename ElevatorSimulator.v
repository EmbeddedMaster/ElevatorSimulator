module ElevatorSimulator(clk,push_btns,motor_out,dot_col,dot_row);
	input clk;
	input [8:0] push_btns;
	output [3:0] motor_out;
	output [11:0] dot_col, dot_row;
	
	reg [3:0] motor_out;
	reg motor_count;
	reg motor_dir;
	reg motor_power;
	
	// Stop Floors
	reg [8:0] ele_a_floors, ele_b_floors;
	
	// Initialize variables
	initial
	begin
		// Motor
		motor_count = 0;
		motor_dir = 0;
		motor_power = 0;
		motor_out = 0;
	end
	
	// Push buttons
	always@(posedge push_btns[0])
	begin
	
	end
	
	// Motor Control
	always@(posedge clk)
	begin
		if(motor_power == 0)
		begin
			if(motor_count == 30'd960000)
			begin
				case(motor_dir)
				1'b0: begin motor_out = 4'b1001; end
				1'b1: begin motor_out = 4'b0101; end
				endcase
				motor_count = 0;
			end
			else if(motor_count == 30'd240000)
			begin
				case(motor_dir)
				1'b0: begin motor_out = 4'b1010; end
				1'b1: begin motor_out = 4'b0110; end
				endcase
				motor_count = motor_count + 1;
			end
			else if(motor_count == 30'd480000)
			begin
				case(motor_dir)
				1'b0: begin motor_out = 4'b0110; end
				1'b1: begin motor_out = 4'b1010; end
				endcase
				motor_count = motor_count + 1;
			end
			else if(motor_count == 30'd720000)
			begin
				case(motor_dir)
				1'b0: begin motor_out = 4'b0101; end
				1'b1: begin motor_out = 4'b1001; end
				endcase
				motor_count = motor_count + 1;
			end
			else
			begin
				motor_count = motor_count + 1;
			end
		end
	end
endmodule
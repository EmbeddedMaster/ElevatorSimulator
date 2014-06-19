/**
 * Embedded System in Soongsil University
 * Author	: Namyun Kim, Hanter Jung
 * Date		: 19. June. 2014
 **/
module ElevatorSimulator(clk,push_btns,motor_out,dot_col,dot_row);
	input clk;
	input [8:0] push_btns;
	output [3:0] motor_out;
	output [11:0] dot_col, dot_row;
	
	reg [3:0] motor_out;
	reg motor_count;
	reg motor_dir;
	reg motor_power;
	
	// About elevator control
	reg [8:0] ready_queue [2:0];
	reg [1:0] current;
	reg [1:0] direction;
	
	reg input_status;
	
	// Initialize variables
	initial
	begin
		// Motor
		motor_count = 0;
		motor_dir = 0;
		motor_power = 0;
		motor_out = 0;
		
		ready_queue[0] = 8'd1; // Located at 1st floor at first time
		ready_queue[1] = 8'd1; // Located at 1st floor at first time
		current = 0;
		direction = 0;
		
		input_status = 0;
	end
	
	// Push buttons
	always@(posedge push_btns[0])
	begin
		if(input_status == 0)
		begin
			input_status = 1;
		end
		else if(input_status == 1)
		begin
			input_status = 0;
		end
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
	
	// Elevator Schduling Algorithm
	function schedule;
		input current;
		input destination;
	begin
		reg min = minimum((destination-current[0]),(destination-current[1]));
		// Check same direction
		
		// Check ready queue
		
	end
	endfunction
	
	// Get Ready Queue Status
	function get_ready_status;
		input elevator;
	begin
		reg ready_count = 0, i;
		for(i = 0; i < 10; i = i+1)
		begin
			if(ready_queue[elevator][i] == 1)
			begin
				ready_count = ready_count + 1;
			end
		end
	end
	endfunction
	
	// Get minimum
	function minimum;
		input a,b;
	begin
		minimum = (a<=b)?0:1;
	end
	endfunction
	
endmodule
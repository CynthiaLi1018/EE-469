// A full memory hierarchy. 
//
// Parameter:
// MODEL_NUMBER: A number used to specify a specific instance of the memory.  Different numbers give different hierarchies and settings.
//   This should be set to your student ID number.
// DMEM_ADDRESS_WIDTH: The number of bits of address for the memory.  Sets the total capacity of main memory.
//
// Accesses: To do an access, set address, data_in, byte_access, and write to a desired value, and set start_access to 1.
//   All these signals must be held constant until access_done, at which point the operation is completed.  On a read,
//   data_out will be set to the correct data for the single cycle when access_done is true.  Note that you can do
//   back-to-back accesses - when access_done is true, if you keep start_access true the memory will start the next access.
// 
//   When start_access = 0, the other input values do not matter.
//   bytemask controls which bytes are actually written (ignored on a read).
//     If bytemask[i] == 1, we do write the byte from data_in[8*i+7 : 8*i] to memory at the corresponding position.  If == 0, that byte not written.
//   To do a read: write = 0,  data_in does not matter.  data_out will have the proper data for the single cycle where access_done==1.
//   On a write, write = 1 and data_in must have the data to write.
//
//   Addresses must be aligned.  Since this is a 64-bit memory (8 bytes), the bottom 3 bits of each address must be 0.
//
//   It is an error to set start_access to 1 and then either set start_access to 0 or change any other input before access_done = 1.
//
//   Accessor tasks (essentially subroutines for testbenches) are provided below to help do most kinds of accesses.

// Line to set up the timing of simulation: says units to use are ns, and smallest resolution is 10ps.
`timescale 1ns/10ps

module lab5 #(parameter [22:0] MODEL_NUMBER = 1863768, parameter DMEM_ADDRESS_WIDTH = 20) (
	// Commands:
	//   (Comes from processor).
	input		logic [DMEM_ADDRESS_WIDTH-1:0]	address,			// The byte address.  Must be word-aligned if byte_access != 1.
	input		logic [63:0]							data_in,			// The data to write.  Ignored on a read.
	input		logic [7:0]								bytemask,		// Only those bytes whose bit is set are written.  Ignored on a read.
	input		logic										write,			// 1 = write, 0 = read.
	input		logic										start_access,	// Starts a memory access.  Once this is true, all command inputs must be stable until access_done becomes 1. 
	output	logic										access_done,	// Set to true on the clock edge that the access is completed.
	output	logic	[63:0]							data_out,		// Valid when access_done == 1 and access is a read.
	// Control signals:
	input		logic										clk,
	input		logic										reset				// A reset will invalidate all cache entries, and return main memory to the default initial values.
); 
	
	DataMemory #(.MODEL_NUMBER(MODEL_NUMBER), .DMEM_ADDRESS_WIDTH(DMEM_ADDRESS_WIDTH)) dmem
		(.address, .data_in, .bytemask, .write, .start_access, .access_done, .data_out, .clk, .reset);
	
	always @(posedge clk)
		assert(reset !== 0 || start_access == 0 || address[2:0] == 0); // All accesses must be aligned.
	
endmodule

// Test the data memory, and figure out the settings.

module lab5_testbench ();
	localparam USERID = 1863768;  // Set to your student ID #
	localparam ADDRESS_WIDTH = 20;
	localparam DATA_WIDTH = 8;
	
	logic [ADDRESS_WIDTH-1:0]			address;		   // The byte address.  Must be word-aligned if byte_access != 1.
	logic [63:0]							data_in;			// The data to write.  Ignored on a read.
	logic [7:0]								bytemask;		// Only those bytes whose bit is set are written.  Ignored on a read.
	logic										write;			// 1 = write, 0 = read.
	logic										start_access;	// Starts a memory access.  Once this is true, all command inputs must be stable until access_done becomes 1. 
	logic										access_done;	// Set to true on the clock edge that the access is completed.
	logic	[63:0]							data_out;		// Valid when access_done == 1 and access is a read.
	// Control signals:
	logic										clk;
	logic										reset;				// A reset will invalidate all cache entries, and return main memory to the default initial values.

	lab5 #(.MODEL_NUMBER(USERID), .DMEM_ADDRESS_WIDTH(ADDRESS_WIDTH)) dut
		(.address, .data_in, .bytemask, .write, .start_access, .access_done, .data_out, .clk, .reset); 

	// Set up the clock.
	parameter CLOCK_PERIOD=10;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 5, " ns", 10);

	// --- Keep track of number of clock cycles, for statistics.
	integer cycles;
	always @(posedge clk) begin
		if (reset)
			cycles <= 0;
		else
			cycles <= cycles + 1;
	end
		
	// --- Tasks are subroutines for doing various operations.  These provide read and write actions.
	
	// Set memory controls to an idle state, no accesses going.
	task mem_idle;
		address			<= 'x;
		data_in			<= 'x;
		bytemask			<= 'x;
		write				<= 'x;
		start_access	<= 0;
		#1;
	endtask
	
	// Perform a read, and return the resulting data in the read_data output.
	// Note: waits for complete cycle of "access_done", so spends 1 cycle more than the access time.
	task readMem;
		input		[ADDRESS_WIDTH-1:0]		read_addr;
		output	[DATA_WIDTH-1:0][7:0]	read_data;
		output	int							delay;		// Access time actually seen.
		
		int startTime, endTime;
		
		startTime = cycles;
		address			<= read_addr;
		data_in			<= 'x;
		bytemask			<= 'x;
		write				<= 0;
		start_access	<= 1;
		@(posedge clk);
		while (~access_done) begin
			@(posedge clk);
		end
		mem_idle(); #1;
		read_data = data_out;
		endTime = cycles;
		delay = endTime - startTime - 1;
	endtask
	
	function int min;
		input int x;
		input int y;
		
		min = ((x<y) ? x : y);
	endfunction
	function int max;
		input int x;
		input int y;
		
		max = ((x>y) ? x : y);
	endfunction
	
	// Perform a series of reads, and returns the min and max access times seen.
	// Accesses are at read_addr, read_addr+stride, read_addr+2*stride, ... read_addr+(num_reads-1)*stride.
	task readStride;
		input		[ADDRESS_WIDTH-1:0]		read_addr;
		input		int							stride;
		input		int							num_reads;
		output	int							min_delay;	// Fastest access time actually seen.
		output	int							max_delay;	// Slowest access time actually seen.
		
		int i, delay;
		logic [DATA_WIDTH-1:0][7:0]		read_data;
		
		//$display("%t readStride(%d, %d, %d)", $time, read_addr, stride, num_reads);
		readMem(read_addr, read_data, delay);
		min_delay = delay;
		max_delay = delay;
		//$display("1  delay: %d", delay);
		
		for(i=1; i<num_reads; i++) begin
			readMem(read_addr+stride*i, read_data, delay);
			min_delay = min(min_delay, delay);
			max_delay = max(max_delay, delay);
			//$display("2  delay: %d", delay);
		end
		//$display("%t min_delay: %d max_delay: %d", $time, min_delay, max_delay);

		mem_idle(); #1;
	endtask
	
	// Perform a write.
	// Note: waits for complete cycle of "access_done", so spends 1 cycle more than the access time.
	task writeMem;
		input [ADDRESS_WIDTH-1:0]			write_address;
		input [DATA_WIDTH-1:0][7:0]		write_data;
		input [DATA_WIDTH-1:0]				write_bytemask;
		output	int							delay;		// Access time actually seen.
		
		int	startTime, endTime;
		
		startTime = cycles;
		address			<= write_address;
		data_in			<= write_data;
		bytemask			<= write_bytemask;
		write				<= 1;
		start_access	<= 1;
		@(posedge clk);
		while (~access_done) begin
			@(posedge clk);
		end
		mem_idle(); #1;
		endTime = cycles;
		delay = endTime - startTime - 1;
	endtask
	
	// Perform a series of writes, and returns the min and max access times seen.
	// Accesses are at write_addr, write_addr+stride, write_addr+2*stride, ... write_addr+(num_writes-1)*stride.
	task writeStride;
		input		[ADDRESS_WIDTH-1:0]		write_addr;
		input		int							stride;
		input		int							num_writes;
		output	int							min_delay;	// Fastest access time actually seen.
		output	int							max_delay;	// Slowest access time actually seen.
		
		int i, delay;
		logic [DATA_WIDTH-1:0][7:0]		write_data;
		
		//$display("%t writeStride(%d, %d, %d)", $time, write_addr, stride, num_writes);
		writeMem(write_addr, write_data, 8'hFF, delay);
		min_delay = delay;
		max_delay = delay;
		//$display("1  delay: %d", delay);
		
		for(i=1; i<num_writes; i++) begin
			writeMem(write_addr+stride*i, write_data, 8'hFF, delay);
			min_delay = min(min_delay, delay);
			max_delay = max(max_delay, delay);
			//$display("2  delay: %d", delay);
		end
		//$display("%t min_delay: %d max_delay: %d", $time, min_delay, max_delay);

		mem_idle(); #1;
	endtask
	
	// Skip doing an access for a cycle.
	task noopMem;
		mem_idle();
		@(posedge clk); #1;
	endtask
	
	// Reset the memory.
	task resetMem;
		mem_idle();
		reset <= 1;
		@(posedge clk);
		reset <= 0;
		#1;
	endtask
	
	logic	[DATA_WIDTH-1:0][7:0]	dummy_data, newData;
	logic [ADDRESS_WIDTH-1:0]		addr;
	int	i, delay, minval, maxval;
	
	//testing int
	int blocksizeL1, blocksizeL2, blocksizeL3, count, N, j, temp;
	int L1_hit_time, L2_hit_time, L3_hit_time;
	int block_num_L1, block_num_L2, block_num_L3;
	int Assoc_L1, Assoc_L2, Assoc_L3;
	int L2_Access, L3_Access;
	
	initial begin
		dummy_data <= '0;
		resetMem();				// Initialize the memory.
		
		 // pre-written tests provided by instructors
			//Do 20 random reads
//		for (i=0;i<20;i++) begin
//			addr = $random() * 8; // *8 to doubleword-align the access.
//			readMem(addr, dummy_data, delay);
//			$display("%t Read took %d cycles", $time, delay);
//		end
//		for (i=0;i<1;i++) begin
//			resetMem();
//			for (j=0; j<8192; j++) begin
//				addr = j * 8; // *8 to doubleword-align the access.
//				readMem(addr, dummy_data, delay);
//				//$display("%t Read took %d cycles for addr %d", $time, delay, addr);
//				if (delay>3 && delay <103) begin
//					$display("%t Read took %d cycles for addr %d", $time, delay, addr);
//				end
//			end
//		end
		
		
		/*
		// Do 5 random double-word writes of random data.
		for (i=0; i<5; i++) begin
			addr = $random()*8; // *8 to doubleword-align the access.
			dummy_data = $random();
			writeMem(addr, dummy_data, 8'hFF, delay);
			$display("%t Write took %d cycles", $time, delay);
			
		end 
		
		
		// Reset the memory.
		resetMem();
		
		// Read all of the first KB
		readStride(0, 8, 1024/8, minval, maxval);
		$display("%t Reading the first KB took between %d and %d cycles each", $time, minval, maxval); */
		

		
		L1_hit_time = 3;
		L2_hit_time = 8;
		L3_hit_time = 26;
		blocksizeL1 = 16;
		blocksizeL2 = 16;
		blocksizeL3 = 16;
		block_num_L1 = 8;
		block_num_L2 = 32;
		block_num_L3 = 64;
		
		// Write test L1
//		addr = 0;
//		readMem(addr, dummy_data, delay);
//		addr = 8;
//		newData = 64'hFEDCBA9876543210;
//		writeMem(addr, newData, 8'hFF, delay);
//		$display("write took %d cycles", delay);

		// Write test L2
//		addr = 0;
//		readMem(addr, dummy_data, delay);
//		addr = 32;
//		for (i=0; i<7; i++) begin
//			newData = $random();
//			writeMem(addr, newData, 8'hFF, delay);
//			$display("write took %d cycles", delay);
//			if (i == 6) begin
//				readMem(addr, dummy_data, delay);
//				$display("read took %d cycles", delay);
//			end
//		end
		
//		addr = 0;
//		readMem(addr, dummy_data, delay);
//		addr = 32;
//		newData = $random();
//		writeMem(addr, newData, 8'hFF, delay);
//		$display("write took %d cycles", delay);
//		for (i=0; i<14; i++) begin
//			noopMem();
//		end
//		readMem(addr, dummy_data, delay);
//		$display("read took %d cycles", delay);

		// Write test L3
//		addr = 0;
//		readMem(addr, dummy_data, delay);
//		addr = 8;
//		newData = 64'hFEDCBA9876543210;
//		writeMem(addr, newData, 8'hFF, delay);
//		$display("write took %d cycles", delay);

//		resetMem();
//		for (j=0; j<128; j++) begin
//			addr = j * 8; // *8 to doubleword-align the access.
//			readMem(addr, dummy_data, delay);
//		end

//		addr = 112*8+8; //L1 write
		for (j = 135; j>=128; j--) begin
			resetMem();
			for (i=0; i<128; i++) begin
				addr = i * 8; // *8 to doubleword-align the access.
				readMem(addr, dummy_data, delay);
			end
			
			addr = j*8;  //L2 write
			$display("%t addr: %d", $time, j);
			readMem(addr, dummy_data, delay);
			$display("read took %d cycles", delay);
			
			resetMem();
			for (i=0; i<128; i++) begin
				addr = i * 8; // *8 to doubleword-align the access.
				readMem(addr, dummy_data, delay);
			end
			
			addr = j*8;  //L2 write
			for (i=0; i<7; i++) begin
				newData = $random();
				writeMem(addr, newData, 8'hFF, delay);
				$display("write took %d cycles", delay);
				if (i == 6) begin
					readMem(addr, dummy_data, delay);
					$display("read took %d cycles", delay);
				end
			end
		end

//		L1

//		L1_hit_time = 3;
//		L2_hit_time = 8;
//		L3_hit_time = 26;
//		blocksizeL1 = 16;
//		blocksizeL2 = 16;
//		blocksizeL3 = 16;
//		block_num_L1 = 8;
//		block_num_L2 = 32;
//		block_num_L3 = 64;
		
//		// Check blocksizeL1
//		// Enter data to Cache L1
//		// access higher aligned addresses until a miss occurs
//		addr = 0;
//		blocksizeL1 = 0;
//		readMem(addr, dummy_data, delay);
//		$display("%t cold start read took %d cycles", $time, delay);
//		readMem(addr, dummy_data, delay);
//		//L1_hit_time = delay;
//		
//		i=0;
//		while(delay <= 3) begin
//			addr = i*8; // *8 to doubleword-align the access.
//			readMem(addr, dummy_data, delay);
//			$display("%t Read took %d cycles for addr  %d", $time, delay, addr);
//			i++;
//		end
//		
//		blocksizeL1 = (i-1) * 8;
//		$display("%t Block Size: %d", $time, blocksizeL1);
		
		// Check Number of Blocks L1
//		// Access higher index of blocks until replace occurs
//		resetMem();
//		addr = 0;
//		count = 0;
//		readMem(addr, dummy_data, delay);//initial fetch
//		readMem(addr, dummy_data, delay);//access fetched data
//		L1_hit_time = delay;//record access time for hit L1
//		delay = 3;
//		while(delay <= 3) begin
//			count++;
//			resetMem();
//			for (i=0;i<=count;i++) begin  // read blocks up to count
//				addr = i*16;
//				readMem(addr, dummy_data, delay);
//				$display("%t Read took %d cycles for block %d", $time, delay, i);
//			end
//		
//			addr = 0;
//			readMem(addr, dummy_data, delay);
//			$display("%t Read took %d cycles for block 0", $time, delay); // get the delay for revisiting address 0 to check if block is replaced.
//		end
//		
//		block_num_L1 = count;
//		$display("Number of Blocks: %d", block_num_L1);
//		$display("L1 Hit Time: %d", L1_hit_time);
//		L2_hit_time = delay-L1_hit_time;
//		$display("L2 Hit Time: %d", L2_hit_time);

//		//Check Number of Blocks L1
//		// Access higher index of blocks until replace occurs
//		resetMem();
//		addr = 0;
//		count = 0;
//		temp = 0;
//		delay = L1_hit_time;
//		while(temp == 0) begin
//			count++;
//			$display("%t count: %d", $time, count);
//			resetMem();
//			
//			for (i=0;i<=count;i++) begin  // read blocks up to count
//				addr = i*blocksizeL1;
//				readMem(addr, dummy_data, delay);
//					if (i == count) begin
//						$display("%t Read took %d cycles for block %d", $time, delay, i);
//					end
//			end
//			
//			for (j=0; j<= 10; j++) begin
//				for (i=0;i<=count;i++) begin  // read blocks up to count
//					addr = i*blocksizeL1;
//					readMem(addr, dummy_data, delay);
//					if (i == count) begin
//						$display("%t Read took %d cycles for block %d", $time, delay, i);
//					end
//					if (delay > L1_hit_time) begin
//						temp = 1;
//						$display("%t Read took %d cycles for block %d, count: %d", $time, delay, i, count);
//					end
//				end
//			end
//		
//			addr = 0;
//			readMem(addr, dummy_data, delay);
//			$display("%t Read took %d cycles for block 0", $time, delay); // get the delay for revisiting address 0 to check if block is replaced.
//		end
//		
//		block_num_L1 = count;
//		$display("Number of Blocks of L2: %d", block_num_L1);


	   // Check associativity
//		// Check Replacement Policy - if check associativity for multiple times and addr 0 always get evicted, LRU, otherwise random)
//		resetMem();
//		addr = 0;
//		N = 0;
//		readMem(addr, dummy_data, delay);//initial fetch
//		readMem(addr, dummy_data, delay);//access fetched data
//		//L1_hit_time = delay;//record access time for hit L1
//		
//		for (j=0; j<10; j++) begin
//			while(delay <= 3) begin
////				if (N == 0) begin
////				  N = 1;
////				end else begin
////				  N = N*2;
////				end
//    			N++;
//				resetMem();
//				for (i=0;i<=N;i++) begin  // read blocks up to N
//					addr = i*blocksizeL1*block_num_L1;
//					readMem(addr, dummy_data, delay);
//					//$display("%t Read took %d cycles for addr %d", $time, delay, addr);
//				end
//			
//				addr = 0;
//				readMem(addr, dummy_data, delay);
//				$display("%t Read took %d cycles for addr 0", $time, delay); // get the delay for revisiting address 0 to check if block is replaced.
//			end
//			
//			Assoc_L1 = N;
//			$display("Associativity of L1: %d", Assoc_L1);
//		end

//		// Check Replacement Policy - Random
//		resetMem();
//		addr = 0;
//		N = 0;
//		
//		for (j=0; j<10; j++) begin
//		   resetMem();
//			addr = 0;
//			N = 0;
//			delay = 3;
//			temp = 0;
//			while(temp == 0) begin
////				if (N == 0) begin
////				  N = 1;
////				end else begin
////				  N = N*2;
////				end
//				N++;
//				resetMem();
//				for (i=0;i<=N;i++) begin  // read blocks up to N
//					addr = i*16*8;
//					readMem(addr, dummy_data, delay);
//					$display("%t Read took %d cycles for addr %d", $time, delay, addr);
//				end
//			
//
//				for (i=0;i<=N;i++) begin  // read blocks up to N
//					addr =  i*16*8;
//					readMem(addr, dummy_data, delay);
//					if (delay > 3) begin
//						temp = 1;
//						$display("%t Read took %d cycles for block %d", $time, delay, i);
//					end
//				end
//			end
//			
//			Assoc_L3 = N;
//			$display("Associativity of L2: %d", Assoc_L3);
//		end
		
		
      // L2
//		L1_hit_time = 3;
//		L2_hit_time = 8;
////		L3_hit_time = 26;
//		blocksizeL1 = 16;
//		blocksizeL2 = 16;
////		blocksizeL3 = 128;
//		block_num_L1 = 8;
//		block_num_L2 = 32;
////		block_num_L3 = 64;

//		// Check blocksizeL2
//		// access higher aligned addresses until a miss occurs
//		resetMem();
//		addr = 0;
//		readMem(addr, dummy_data, delay);
//		$display("%t cold start read took %d cycles", $time, delay);
////		addr = blocksizeL1;
////		readMem(addr, dummy_data, delay);
////		$display("%t read took %d cycles for L1 block 1", $time, delay);
////		for (i=0; i<block_num_L1*2; i++) begin
////			addr = i*blocksizeL1;
////			readMem(addr, dummy_data, delay);
////			$display("%t read took %d delay", $time, delay);
////		end
//		L2_Access = L1_hit_time + L2_hit_time;
//		delay = L2_Access;
//		i=0;
//		while(delay <= L2_Access) begin
//			addr = i*blocksizeL1; // *8 to doubleword-align the access.
//			readMem(addr, dummy_data, delay);
//			$display("%t Read took %d cycles for %d * blocksize L1", $time, delay, i);
//			i++;
//		end
//		
//		blocksizeL2 = (i-1) * blocksizeL1;
//		$display("%t Block Size of L2: %d", $time, blocksizeL2);

//		//Check Number of Blocks L2
//		// Access higher index of blocks until replace occurs
//		resetMem();
//		addr = 0;
//		count = 0;
//		temp = 0;
//		L2_Access = L1_hit_time + L2_hit_time;
//		delay = L2_Access;
//		while(temp == 0) begin
//			count++;
//			$display("%t count: %d", $time, count);
//			resetMem();
//			
//			for (i=0;i<=count;i++) begin  // read blocks up to count
//				addr = i*blocksizeL2;
//				readMem(addr, dummy_data, delay);
////					if (i == count) begin
////						$display("%t Read took %d cycles for block %d", $time, delay, i);
////					end
//			end
//			
//			for (j=0; j<= 10; j++) begin
//				for (i=0;i<=count;i++) begin  // read blocks up to count
//					addr = i*blocksizeL2;
//					readMem(addr, dummy_data, delay);
////					if (i == count) begin
////						$display("%t Read took %d cycles for block %d", $time, delay, i);
////					end
//					if (delay > L2_Access) begin
//						temp = 1;
//						$display("%t Read took %d cycles for block %d, count: %d", $time, delay, i, count);
//					end
//				end
//			end
////		
////			addr = 0;
////			readMem(addr, dummy_data, delay);
////			$display("%t Read took %d cycles for block 0", $time, delay); // get the delay for revisiting address 0 to check if block is replaced.
//		end
//		
//		block_num_L2 = count;
//		$display("Number of Blocks of L2: %d", block_num_L2);

//	   // Check associativity
//		// Check Replacement Policy - if check associativity for multiple times and addr 0 always get evicted, LRU, otherwise random)
//		resetMem();
//		addr = 0;
//		N = 0;
//		
//		for (j=0; j<10; j++) begin
//		   resetMem();
//			addr = 0;
//			N = 0;
//			delay = 17;
//			while(delay <= 17) begin
////				if (N == 0) begin
////				  N = 1;
////				end else begin
////				  N = N*2;
////				end
//				N++;
//				resetMem();
//				for (i=0;i<=N;i++) begin  // read blocks up to N
//					addr = i*blocksizeL2*block_num_L2;
//					readMem(addr, dummy_data, delay);
//					//$display("%t Read took %d cycles for addr %d", $time, delay, addr);
//				end
//			
//				addr = 0;
//				readMem(addr, dummy_data, delay);
//				$display("%t Read took %d cycles for addr 0", $time, delay); // get the delay for revisiting address 0 to check if block is replaced.
//			end
//			
//			Assoc_L2 = N;
//			$display("Associativity of L2: %d", Assoc_L2);
//		end

//		// Check Replacement Policy - Random
//		resetMem();
//		addr = 0;
//		N = 0;
//		
//		for (j=0; j<10; j++) begin
//		   resetMem();
//			addr = 0;
//			N = 0;
//			L2_Access = L1_hit_time + L2_hit_time;
//			delay = L2_Access;
//			temp = 0;
//			while(temp == 0) begin
////				if (N == 0) begin
////				  N = 1;
////				end else begin
////				  N = N*2;
////				end
//				N++;
//				resetMem();
//				for (i=0;i<=N;i++) begin  // read blocks up to N
//					addr = i*blocksizeL2*block_num_L2;
//					readMem(addr, dummy_data, delay);
//					//$display("%t Read took %d cycles for addr %d", $time, delay, addr);
//				end
//			
//
//				for (i=N;i>=0;i--) begin  // read blocks up to N
//					addr =  i*blocksizeL2*block_num_L2;
//					readMem(addr, dummy_data, delay);
//					if (delay > L2_Access) begin
//						temp = 1;
//						$display("%t Read took %d cycles for block %d", $time, delay, i);
//					end
//				end
//			end
//			
//			Assoc_L2 = N;
//			$display("Associativity of L2: %d", Assoc_L2);
//		end


//		// L3
//		L1_hit_time = 3;
//		L2_hit_time = 8;
//		L3_hit_time = 26;
//		blocksizeL1 = 16;
//		blocksizeL2 = 16;
//		blocksizeL3 = 16;
//		block_num_L1 = 8;
//		block_num_L2 = 32;
//		block_num_L3 = 64;
		
//		// Check blocksizeL3
//		// access higher aligned addresses until a miss occur
//		resetMem();
//		addr = 0;
//		readMem(addr, dummy_data, delay);
//		$display("%t cold start read took %d cycles", $time, delay);
////		addr = blocksizeL1;
////		readMem(addr, dummy_data, delay);
////		$display("%t read took %d cycles for L1 block 1", $time, delay);
////		for (i=0; i<block_num_L1*2; i++) begin
////			addr = i*blocksizeL1;
////			readMem(addr, dummy_data, delay);
////			$display("%t read took %d delay", $time, delay);
////		end
//		L3_Access = L1_hit_time + L2_hit_time + L3_hit_time;
//		delay = L3_Access;
//		i=0;
//		while(delay <= L3_Access) begin
//			addr = i*blocksizeL2; // *8 to doubleword-align the access.
//			readMem(addr, dummy_data, delay);
//			$display("%t Read took %d cycles for %d * blocksize L2", $time, delay, i);
//			i++;
//		end
//		
//		blocksizeL3 = (i-1) * blocksizeL2;
//		$display("%t Block Size of L3: %d", $time, blocksizeL3);

		//Check Number of Blocks L3
//		// Access higher index of blocks until replace occurs
//		for (j=0; j<10; j++) begin
//			resetMem();
//			addr = 0;
//			count = 0;
//			delay = 43;
//			while(delay <= 43) begin
//				count++;
//				resetMem();
//				for (i=0;i<=count;i++) begin  // read blocks up to count
//					addr = i*blocksizeL3;
//					readMem(addr, dummy_data, delay);
//	//				if (i == count) begin
//	//				   $display("%t Read took %d cycles for block %d", $time, delay, i);
//	//				end
//				end
//			
//				addr = 0;
//				readMem(addr, dummy_data, delay);
//				//$display("%t Read took %d cycles for block 0", $time, delay); // get the delay for revisiting address 0 to check if block is replaced.
//			end
//			
//			block_num_L3 = count;
//			$display("Number of Blocks of L3: %d", block_num_L3);
//		end

//		// Access higher index of blocks until replace occurs
//		for (j=0; j<10; j++) begin
//			resetMem();
//			addr = 0;
//			count = 0;
//			delay = 43;
//			temp = 0;
//			while(temp == 0) begin
//				count++;
//				resetMem();
//				for (i=0;i<=count;i++) begin  // read blocks up to count
//					addr = i*blocksizeL3;
//					readMem(addr, dummy_data, delay);
////					if (i == count) begin
////					   $display("%t Read took %d cycles for block %d", $time, delay, i);
////					end
//				end
//			
//				for (i=0;i<=count;i++) begin  // read blocks up to count
//					addr = i*blocksizeL3;
//					readMem(addr, dummy_data, delay);
//					if (delay >43) begin
//						temp = 1;
//						$display("%t Read took %d cycles for block %d", $time, delay, i);
//					end
//				end
//			end
//			
//			block_num_L3 = count;
//			$display("Number of Blocks of L3: %d", block_num_L3);
//		end

//		resetMem();
//		addr = 0;
//		count = 0;
//		temp = 0;
//		L3_Access = L1_hit_time + L2_hit_time + L3_hit_time;
//		delay = L3_Access;
//		while(temp == 0) begin
//			count++;
//			$display("%t count: %d", $time, count);
//			resetMem();
//			
//			for (i=0;i<=count;i++) begin  // read blocks up to count
//				addr = i*blocksizeL3;
//				readMem(addr, dummy_data, delay);
//					if (i == count) begin
//						$display("%t Read took %d cycles for block %d", $time, delay, i);
//					end
//			end
//			
//			for (j=0; j<= 10; j++) begin
//				for (i=0;i<=count;i++) begin  // read blocks up to count
//					addr = i*blocksizeL3;
//					readMem(addr, dummy_data, delay);
//					if (i == count) begin
//						$display("%t Read took %d cycles for block %d", $time, delay, i);
//					end
//					if (delay > L3_Access) begin
//						temp = 1;
//						$display("%t Read took %d cycles for block %d, count: %d", $time, delay, i, count);
//					end
//				end
//			end
//		
//			addr = 0;
//			readMem(addr, dummy_data, delay);
//			$display("%t Read took %d cycles for block 0", $time, delay); // get the delay for revisiting address 0 to check if block is replaced.
//		end
//		
//		block_num_L3 = count;
//		$display("Number of Blocks of L3: %d", block_num_L3);

//	   // Check associativity
//		// Check Replacement Policy - Random
//		resetMem();
//		addr = 0;
//		N = 0;
//		
//		for (j=0; j<10; j++) begin
//		   resetMem();
//			addr = 0;
//			N = 0;
//			delay = 43;
//			while(delay <= 43) begin
////				if (N == 0) begin
////				  N = 1;
////				end else begin
////				  N = N*2;
////				end
//				N++;
//				resetMem();
//				for (i=0;i<=N;i++) begin  // read blocks up to N
//					addr = i*blocksizeL3*block_num_L3;
//					readMem(addr, dummy_data, delay);
//					//$display("%t Read took %d cycles for addr %d", $time, delay, addr);
//				end
//			
//				addr = 0;
//				readMem(addr, dummy_data, delay);
//				$display("%t Read took %d cycles for addr 0", $time, delay); // get the delay for revisiting address 0 to check if block is replaced.
//			end
//			
//			Assoc_L3 = N;
//			$display("Associativity of L2: %d", Assoc_L3);
//		end

		
//		// Check Replacement Policy - Random
//		resetMem();
//		addr = 0;
//		N = 0;
//		
//		for (j=0; j<10; j++) begin
//		   resetMem();
//			addr = 0;
//			N = 16;
//			L3_Access = L1_hit_time + L2_hit_time + L3_hit_time;
//			delay = L3_Access;
//			temp = 0;
//			while(temp == 0) begin
//				if (N == 0) begin
//				  N = 1;
//				end else begin
//				  N = N*2;
//				end
////				N++;
//				resetMem();
//				for (i=0;i<=N;i++) begin  // read blocks up to N
//					addr = i*blocksizeL3*block_num_L3;
//					readMem(addr, dummy_data, delay);
//					//$display("%t Read took %d cycles for addr %d", $time, delay, addr);
//				end
//			
//
//				for (i=N;i>=0;i--) begin  // read blocks up to N
//					addr =  i*blocksizeL3*block_num_L3;
//					readMem(addr, dummy_data, delay);
//					if (delay > L3_Access) begin
//						temp = 1;
//						$display("%t Read took %d cycles for block %d", $time, delay, i);
//					end
//				end
//			end
//			
//			Assoc_L3 = N;
//			$display("Associativity of L3: %d", Assoc_L3);
//		end

		$stop();
		
		
	end
	
endmodule

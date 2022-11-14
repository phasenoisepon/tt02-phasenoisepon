`default_nettype none

module phasenoisepon_seven_segment_seconds #( parameter MAX_COUNT = 1000 ) (
  input [7:0] io_in,
  output [7:0] io_out
);
    
    // setup registers
    reg [3:0] nibble_low;
    reg [3:0] nibble_high;
    reg [7:0] output_reg;

    // declare wires
    wire clk = io_in[0];
    wire reset = io_in[1];
    wire [1:0] ctl = io_in[3:2];
    wire [3:0] data_in = io_in[7:4]
    wire [7:0] data_out;
    assign io_out[7:0] = output_reg;

    // define useful FSM states
    localparam CTL_LOW_NIBBLE  = 2'b00;
    localparam CTL_HIGH_NIBBLE = 2'b01;
    localparam CALC_OUTPUT     = 2'b1x; //allow don't care

    always @(posedge clk) begin
        // if reset, then reset all reg's to 0
        if (reset) begin
            nibble_low <= 0;
            nibble_high <= 0;
            output_reg <= 0;
        end else begin
            // read control lines
            if (ctl == CTL_LOW_NIBBLE) begin
                output_reg <= 8'h0F;
                nibble_low <= data_in;
            end else if (ctl == CTL_HIGH_NIBBLE) begin
                output_reg <= 8'hF0;
                nibble_high <= data_in;
            end else if (ctl == CALC_OUTPUT) begin
                output_reg <= 8'hFF; // stub
            end
        end
    end

endmodule

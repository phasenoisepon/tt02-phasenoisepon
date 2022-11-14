`default_nettype none
`timescale 1ns/1ps

/*
this testbench just instantiates the module and makes some convenient wires
that can be driven / tested by the cocotb test.py
*/

module tb (
    // testbench is controlled by test.py
    input clk,
    input rst,
    input [1:0] ctl,
    input [3:0] data_in,
    output [7:0] data_out
   );

    // this part dumps the trace to a vcd file that can be viewed with GTKWave
    initial begin
        $dumpfile ("tb.vcd");
        $dumpvars (0, tb);
        #1;
    end

    // wire up the inputs and outputs
    wire [7:0] inputs = {data_in, ctl, rst, clk};
    wire [7:0] outputs;
    assign data_out = outputs[7:0];

    // instantiate the DUT
    phasenoisepon_seven_segment_seconds #(.MAX_COUNT(100)) seven_segment_seconds(
        .io_in  (inputs),
        .io_out (outputs)
        );

endmodule

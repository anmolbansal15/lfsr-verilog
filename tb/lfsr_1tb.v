`timescale 1ns/1ps

module lfsr_1tb;

    reg clk;
    reg rst;
    wire [2:0] q;
    wire [2:0] inv_lfsr;

    lfsr_1 dut (
        .clk(clk),
        .rst(rst),
        .q(q),
        .inv_lfsr(inv_lfsr)
    );

    // 10 ns clock period
    initial clk = 1'b0;
    always #5 clk = ~clk;

    // Save signals for GTKWave
    initial begin
        $dumpfile("lfsr.vcd");
        $dumpvars(0, lfsr_1tb);
    end

    initial begin
        rst = 1'b1;
        #12 rst = 1'b0;

        $display("Time(ns)  Forward  Inverse");
        $monitor("%0t        %b       %b", $time, q, inv_lfsr);

        repeat (9) @(posedge clk);
        #1;
        $finish;
    end

endmodule

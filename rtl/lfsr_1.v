module lfsr_1 (
    input wire clk,
    input wire rst,
    output reg [2:0] q,
    output reg [2:0] inv_lfsr
);

    // Forward LFSR for polynomial x^3 + x + 1.
    // Feedback enters the least significant bit.
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 3'b001;
        else
            q <= {q[1:0], q[2] ^ q[0]};
    end

    // Inverse recurrence: traverses the same nonzero states
    // in the opposite direction.
    always @(posedge clk or posedge rst) begin
        if (rst)
            inv_lfsr <= 3'b001;
        else
            inv_lfsr <= {inv_lfsr[0] ^ inv_lfsr[1],
                         inv_lfsr[2:1]};
    end

endmodule

`default_nettype none

module glyphs_rom(
    input  wire [5:0] c, // Character selector
    input  wire [3:0] y, // Row selector (0-15)
    input  wire [2:0] x, // Column selector (0-7)
    output reg pixel
);
    reg [7:0] rb; 

    always @(*) begin
        case (c) 
            0:  case(y) 2:rb=8'h3C; 3,4,5:rb=8'h66; 6,7:rb=8'hFF; 8,9,10:rb=8'hC3; default:rb=0; endcase // A
            3:  case(y) 2,10:rb=8'hF8; 3,4,5,6,7,8,9:rb=8'hC6; default:rb=0; endcase // D
            4:  case(y) 2,6,10:rb=8'hFE; 3,4,5,7,8,9:rb=8'hC0; default:rb=0; endcase // E
            6:  case(y) 2,10:rb=8'h7E; 3,4,5:rb=8'hC0; 6:rb=8'hCE; 7,8,9:rb=8'hC6; default:rb=0; endcase // G
            12: case(y) 2:rb=8'hC3; 3:rb=8'hE7; 4:rb=8'hFF; 5:rb=8'hDB; 6,7,8,9,10:rb=8'hC3; default:rb=0; endcase // M
            13: case(y) 2,3:rb=8'hC6; 4:rb=8'hE6; 5:rb=8'hF6; 6:rb=8'hD6; 7:rb=8'hC6; 8:rb=8'hCE; 9,10:rb=8'hC6; default:rb=0; endcase // N
            17: case(y) 2,6:rb=8'hFC; 3,4,5:rb=8'hC6; 7,8,9:rb=8'hD8; 10:rb=8'hC6; default:rb=0; endcase // R
            20: case(y) 2,3,4,5,6,7,8,9:rb=8'hC6; 10:rb=8'h7E; default:rb=0; endcase // U
            25: case(y) 2,10:rb=8'hFF; 3:rb=8'h0E; 4:rb=8'h0C; 5:rb=8'h18; 6:rb=8'h30; 7:rb=8'h60; 8:rb=8'hC0; 9:rb=8'hE0; default:rb=0; endcase // Z
            26: rb = 8'h00; // SPACE
            
            // ... (keep other numbers/letters if needed)
            default: rb = 8'h00; 
        endcase
        
        // Output the bit at the current X position
        pixel = rb[7-x];
    end
endmodule
// ENG: IBRAHIM METE BINGOL
// COMPANY: MPTECH
module regMem 
#(
    parameter                                       REGISTER_MEMORY_DATA_WIDTH                  =   16,
    parameter                                       REGISTER_MEMORY_READ_ONLY_MEMORY_DEPTH      =   128,                
    parameter                                       REGISTER_MEMORY_RANDOM_ACCESS_MEMORY_DEPTH  =   128,
    localparam                                      REGISTER_MEMORY_DEPTH                       =   REGISTER_MEMORY_READ_ONLY_MEMORY_DEPTH + REGISTER_MEMORY_RANDOM_ACCESS_MEMORY_DEPTH,
    localparam                                      RMP_BIT_LENGTH                              =   $clog2(REGISTER_MEMORY_DEPTH)       
) 
(
    // CLOCK AND RESTE 
    // ---
    input                                           clk,
    input                                           rst,
    // ---
    // MEMORY INTERFACE
    // ---
    input   [RMP_BIT_LENGTH-1:0]                    mem_addr,
    input   [REGISTER_MEMORY_DATA_WIDTH-1:0]        mem_data_in,
    input                                           mem_we,
    output  [REGISTER_MEMORY_DATA_WIDTH-1:0]        mem_data_out,
    // ---                             
    // READONLY INPUT 
    // ---
    input   [REGISTER_MEMORY_DATA_WIDTH-1:0]        readOnly00,
    // ---
    // DATAPATH
    // ---
    output  [REGISTER_MEMORY_DATA_WIDTH-1:0]        dataOut00
    // ---

);
// INCLUDES
// ---
// ---


// LOCAL PARAMETER 
// ---
localparam                                          HIGH                                        = 1'b1;
localparam                                          LOW                                         = 1'b0;
localparam                                          DRST                                        = 32'd0;
// ---


// LOCAL VARIABLE 
// ---
// MEM
integer                                             i;
reg     [REGISTER_MEMORY_DATA_WIDTH-1:0]            RandomAccessMemory  [0:REGISTER_MEMORY_RANDOM_ACCESS_MEMORY_DEPTH-1];
wire    [REGISTER_MEMORY_DATA_WIDTH-1:0]            ReadOnlyMemory      [0:REGISTER_MEMORY_READ_ONLY_MEMORY_DEPTH-1];
wire    [REGISTER_MEMORY_DATA_WIDTH-1:0]            memory;
wire                                                isAddrRandomAccessMemory;
// ---


// MEMORY GENERATION
// ---
genvar j;
genvar k;
generate
    for (j = 0; j < REGISTER_MEMORY_READ_ONLY_MEMORY_DEPTH; j = j + 1)
    begin
        assign                                      memory[j]                                   = ReadOnlyMemory[j];
    end
    for (k = REGISTER_MEMORY_READ_ONLY_MEMORY_DEPTH; k < REGISTER_MEMORY_DEPTH; k = k + 1)
    begin
        assign                                      memory[k]                                   = RandomAccessMemory[k - REGISTER_MEMORY_READ_ONLY_MEMORY_DEPTH];
    end
endgenerate
// ---


// WRITE BLOCK READ ONLY MEMORY 
// ---
assign                                              ReadOnlyMemory[0]                           = readOnly00;   
// ---


// WRITE BLOCK RANDOM ACCESS MEMORY
assign                                              isAddrRandomAccessMemory                    =  (mem_addr > (REGISTER_MEMORY_READ_ONLY_MEMORY_DEPTH - 1)) && (mem_addr < REGISTER_MEMORY_DEPTH)
// ---
always @(posedge clk)
begin
    if (rst)
    begin
        `include "regMemInit.vh"
    end 
    else
    begin
        if (mem_we && isAddrRandomAccessMemory)
        begin
            RandomAccessMemory[mem_addr-REGISTER_MEMORY_READ_ONLY_MEMORY_DEPTH]                 <= mem_data_in;
        end
    end   
end
// ---


// READ BLOCK 
// ---
assign                                              mem_data_out                                = memory[mem_addr];
// ---
// DATAPATH BLCOK
// ---
assign                                              dataOut00                                   = memory[0];
// ---
// END OF MODULE 
endmodule
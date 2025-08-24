module uartPackageHandler 
#(
    parameter                                       UARTBAUDRATE                                =   9600,
    parameter                                       UARTCLKFREQUENCY                            =   10_000_000,
    parameter                                       UARTPACKAGEWIDTH                            =   8,         
    parameter                                       UARTPARITY                                  =   "NO",
    parameter                                       UARTSHIFT                                   =   "MSBFIRST",    
    parameter                                       UARTFIFOSIZE                                =   1024,
    parameter                                       UARTFIFOWIDTH                               =   8,
    parameter                                       REGISTER_MEMORY_DATA_WIDTH                  =   16,
    parameter                                       REGISTER_MEMORY_READ_ONLY_MEMORY_DEPTH      =   128,
    parameter                                       REGISTER_MEMORY_RANDOM_ACCESS_MEMORY_DEPTH  =   128, 
    localparam                                      REGISTER_MEMORY_DEPTH                       =   REGISTER_MEMORY_READ_ONLY_MEMORY_DEPTH + REGISTER_MEMORY_RANDOM_ACCESS_MEMORY_DEPTH,
    localparam                                      RMP_BIT_LENGTH                              =   $clog2(REGISTER_MEMORY_DEPTH)             
) 
(
    // CLOCK AND RESET 
    // ---
    input                                           clkUart,
    input                                           rstUart,
    input                                           clk,
    input                                           rst,
    // ---
    // UART 
    // ---
    input                                           uartRx,
    output                                          uartTx,
    // ---
    // SETTINGS CONTROL AND DATA PATH
    // ---
    output  reg [RMP_BIT_LENGTH-1:0]                mem_addr,
    output  reg [REGISTER_MEMORY_DATA_WIDTH-1:0]    mem_data_in,
    output  reg                                     mem_we,
    input       [REGISTER_MEMORY_DATA_WIDTH-1:0]    mem_data_out,
    output  reg                                     mem_reset
    // ---
);


// INCLUDEs
// ---
`include "uartPackageHandlerTaks.vh"
`include "uartPackageHandlerOpcode.vh"

// ---


// LOCAL PARAMETER 
// ---
localparam                                          HIGH                                            = 1'b1;
localparam                                          LOW                                             = 1'b0;
localparam                                          DRST                                            = 32'd0;
localparam                                          FIFORESETWAITCYCLE                              = 4'hA;
localparam                                          ADDRESSPACKAGECOUNT                             = ((RMP_BIT_LENGTH - 1)/UARTFIFOWIDTH) + 1;
localparam                                          DATAPACKAGECOUNT                                = ((REGISTER_MEMORY_DATA_WIDTH - 1)/REGISTER_MEMORY_DATA_WIDTH) + 1;
// ---


// STATES
// ---
localparam                                          IDLE                                            = 0;
localparam                                          FETCH                                           = 1;
localparam                                          CHECK                                           = 2;
localparam                                          EXECUTE                                         = 3;
localparam                                          COMMANDIDLE                                     = 0;
localparam                                          COMMANDPROC0                                    = 1;
localparam                                          COMMANDPROC1                                    = 2;
localparam                                          COMMANDPROC2                                    = 3;
localparam                                          COMMANDPROC3                                    = 4;
localparam                                          COMMANDPROC4                                    = 5;
localparam                                          COMMANDPROC5                                    = 6;
localparam                                          COMMANDPROC6                                    = 7;
localparam                                          COMMANDPROC7                                    = 8;
localparam                                          COMMANDPROC8                                    = 9;
localparam                                          COMMANDPROC9                                    = 10;
localparam                                          COMMANDPROC10                                   = 11;
localparam                                          COMMANDPROC11                                   = 12;
localparam                                          COMMANDPROC12                                   = 13;
localparam                                          COMMANDPROC13                                   = 14;
localparam                                          COMMANDPROC14                                   = 15;
// ---



// LOCAL VARIABLE 
// ---
reg     [1:0]                                       state;
reg     [3:0]                                       commandState;
reg     [UARTPACKAGEWIDTH-1:0]                      command;
reg     [UARTPACKAGEWIDTH-1:0]                      fifoWriteData;
reg                                                 fifoReadDataEn;
reg                                                 fifoWriteDataEn;
reg                                                 fifoRst;
reg     [3:0]                                       count;
reg     [REGISTER_MEMORY_DATA_WIDTH-1:0]            regTempReg;
wire                                                fifoEmpty;
wire                                                fifoRxRstDone;
wire                                                fifoTxRstDone;
wire                                                fifoReadDataVld;
wire    [UARTFIFOWIDTH-1:0]                         fifoReadData;
wire    [1:0]                                       uartError;
// ---


// LOGICAL DESIGN
// ---
always @(posedge clk) 
begin
    if(rst)
    begin
       state                                        <=  IDLE;
       fifoReadDataEn                               <=  LOW;
       command                                      <=  DRST;
       commandState                                 <=  COMMANDIDLE;
       fifoRst                                      <=  HIGH;
       fifoWriteData                                <=  DRST;
       fifoWriteDataEn                              <=  LOW;
       count                                        <=  DRST;
       mem_addr                                     <=  DRST;
       regTempReg                                   <=  DRST;
       mem_data_in                                  <=  DRST;
       mem_we                                       <=  LOW;
    end
    else
    begin
        fifoReadDataEn                              <=  LOW;
        fifoWriteDataEn                             <=  LOW;   
        mem_we                                      <=  LOW;   
        case (state)
            IDLE:
            begin
                if (fifoRxRstDone && fifoTxRstDone)
                begin
                    state                           <= FETCH; 
                end 
            end 
            FETCH:
            begin
                if (!fifoEmpty)
                begin
                    fifoReadDataEn                  <= HIGH;
                    state                           <= DECODE;
                end
                else
                begin
                    state                           <= FETCH:
                end 
            end
            DECODE:
            begin
                if (fifoReadDataVld)
                begin
                    state                           <= EXECUTE;
                    command                         <= fifoReadData;
                    commandState                    <= COMMANDIDLE;
                    count                           <= DRST;
                end
                else
                begin
                    state                           <= DECODE;
                end
            end
            EXECUTE:
            begin
                case (command)
                `include "COMMAND/getUartError.vh"
                `include "COMMAND/resetFifo.vh"
                `include "COMMAND/readSettings.vh"
                `include "COMMAND/writeSettings.vh"
                `include "COMMAND/default.vh"  
                endcase
            end
            default:
            begin
                state                               <= IDLE;
            end
        endcase
    end
end
// ---



// UART
// ---
uart #(
    .UARTBAUDRATE                                   (UARTBAUDRATE),
    .UARTCLKFREQUENCY                               (UARTCLKFREQUENCY),
    .UARTPACKAGEWIDTH                               (UARTPACKAGEWIDTH),
    .UARTPARITY                                     (UARTPARITY),
    .UARTSHIFT                                      (UARTSHIFT),
    .UARTFIFOSIZE                                   (UARTFIFOSIZE),
    .UARTFIFOWIDTH                                  (UARTFIFOWIDTH)
)
UARTINST 
(
    .clkUart                                        (clkUart),
    .rstUart                                        (rstUart),
    .clkFifo                                        (clk),
    .rstFifo                                        (fifoRst),
    .rx                                             (uartRx),
    .tx                                             (uartTx),
    .fifoRxReadData                                 (fifoReadData),
    .fifoRxEmpty                                    (fifoEmpty),
    .fifoRxReadDataEn                               (fifoReadDataEn),
    .fifoRxReadDataVld                              (fifoReadDataVld),
    .fifoRxRstDone                                  (fifoRxRstDone),
    .uartRxError                                    (uartError),
    .fifoTxWriteData                                (fifoWriteData),
    .fifoTxWriteDataEn                              (fifoWriteDataEn),
    .fifoTxFull                                     (fifoFull),
    .fifoTxRstDone                                  (fifoTxRstDone)
);
// ---
// END OF MODULE
endmodule
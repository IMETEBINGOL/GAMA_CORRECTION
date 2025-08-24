// ENG: IBRAHIM METE BINGOL
// COMPANY: MPTECH
module uartRx 
#(
    parameter                                   BAUDRATE                = 9600,
    parameter                                   CLKFREQUENCY            = 100_000_000,
    parameter                                   PACKAGESIZE             = 8,
    parameter                                   PARITYEXISTENCE         = "NO",                 // "NO", "ODD", "EVEN"
    parameter                                   SHIFT                   = "MSBFIRST",
    localparam                                  STATEBIT                = $clog2(NUMOFSTATE),
    localparam                                  PACKAGECOUNTBIT         = $clog2(PACKAGESIZE),
    localparam                                  BAUDRATECYCLE           = CLKFREQUENCY / BAUDRATE,
    localparam                                  BAUDRATEHALFCYCLE       = BAUDRATECYCLE / 2,
    localparam                                  BAUDRATECYCLEBIT        = $clog2(BAUDRATECYCLE)
) 
(
    // CLOCK AND RESET 
    // ---
    input                                       clk,
    input                                       rst,
    // ---
    // DATAPATH SIGNAL 
    // ---
    input                                       rx,
    output  reg     [PACKAGESIZE-1:0]           fifoData,
    input                                       fifoFull,
    output  reg                                 fifoWrite,
    output  reg     [1:0]                       error
    // ---
);

// INCLUDEs
// ---
`include "rxErrorOpcode.vh"
// ---


// LOCAL PARAMETER 
// ---
localparam                                      HIGH                    = 1'b1;
localparam                                      LOW                     = 1'b0;
localparam                                      DRST                    = 32'd0;
localparam                                      IDLE                    = 0;
localparam                                      START                   = 1;
localparam                                      TRMIT                   = 2;
localparam                                      PARITY                  = 3;
localparam                                      STOP                    = 4;
localparam                                      DATA                    = 5;
localparam                                      NUMOFSTATE              = 6;

// ---


// LOCAL VARIABLE 
// ---
reg                                             [BAUDRATECYCLEBIT-1:0]  count;
reg                                             [STATEBIT-1:0]          state;    
reg                                                                     counterEnable;
reg                                                                     parity;
reg                                             [BAUDRATECYCLEBIT-1:0]  countStop;
reg                                             [PACKAGECOUNTBIT-1:0]   packCount;
// ---



// LOGICAL DESIGN 
// ---
always @(posedge clk) 
begin
    if (rst)
    begin
        count                                   <= DRST;
    end
    else
    begin
        count                                   <= (counterEnable && (count != countStop)) ? (count + 1): DRST;
    end
end

always @(posedge clk) 
begin
    if (rst)
    begin
        counterEnable                           <= LOW;
        state                                   <= IDLE;
        countStop                               <= DRST;
        error                                   <= `NOERROR;
        fifoWrite                               <= LOW; 
        packCount                               <= DRST;
        fifoData                                <= DRST;
        parity                                  <= LOW;
    end
    else
    begin
        fifoWrite                               <= LOW; 
        case (state)
            IDLE:
            begin
                if (!rx && !fifoFull)
                begin
                    state                       <= START;
                    counterEnable               <= HIGH;
                    countStop                   <= BAUDRATEHALFCYCLE - 1;
                    fifoData                    <= DRST;
                end
            end
            START 
            begin
                if ((count == BAUDRATEHALFCYCLE - 1))
                begin
                    if (rx)
                    begin
                        state                   <= IDLE;
                        error                   <= `RXSTARTERROR;
                        countStop               <= BAUDRATECYCLE - 1; 
                    end
                    else
                    begin
                        state                   <= TRMIT;
                    end
                end
            end
            TRMIT:
            begin
                if (count == BAUDRATECYCLE - 1)
                begin
                    if (SHIFT == "MSBFIRST")
                    begin
                        fifoData                <= {rx, fifoData[PACKAGESIZE-1:1]};
                    end
                    else
                    begin
                        fifoData                <= {fifoData[PACKAGESIZE-2:0]};
                    end
                    packCount                   <= packCount + 1;
                    if (packCount == packCount - 1)
                    begin
                        state                   <= (PARITYEXISTENCE == "NO") ? STOP : PARITY;

                    end
                end
            end
            PARITY:
            begin
                if (count == BAUDRATECYCLE - 1)
                begin
                    state                       <= STOP;
                    if (parity != rx)
                    begin
                        error                   <= `RXPARITYERROR
                    end
                end
                parity                          <= (PARITYEXISTENCE == "ODD") ? ^fifoData : ~^fifoData;
            end
            STOP:
            begin
                if (count == BAUDRATECYCLE - 1)
                begin
                    state                   <= IDLE;
                    if (!rx)
                    begin
                        error               <= `RXSTOPERROR
                    end
                end
            end
            default:
            begin
                state                       <= IDLE;
            end
        endcase
    end
end
// ---
// END OF MODULE
endmodule
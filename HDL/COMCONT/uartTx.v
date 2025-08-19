// ENG: IBRAHIM METE BINGOL
// COMPANY: MPTECH
module uartTx 
#(
    parameter                                   BAUDRATE                = 9600,
    parameter                                   CLKFREQUENCY            = 100_000_000,
    parameter                                   PACKAGESIZE             = 8,
    parameter                                   PARITYEXISTENCE         = "NO",                 // "NO", "ODD", "EVEN"
    parameter                                   SHIFT                   = "MSBFIRST",
    localparam                                  BAUDRATECYCLE           = CLKFREQUENCY / BAUDRATE,
    localparam                                  BAUDRATECYCLEBIT        = $clog2(BAUDRATECYCLE),
    localparam                                  STATEBIT                = $clog2(NUMOFSTATE),
    localparam                                  PACKAGECOUNTBIT         = $clog2(PACKAGESIZE)
) 
(
    // CLOCK AND RESET 
    // ---
    input                                       clk,
    input                                       rst,
    // ---
    // DATAPATH SIGNAL 
    // ---
    output  reg                                 tx,
    input           [PACKAGESIZE-1:0]           fifoData,
    input                                       fifoEmpty,
    output  reg                                 fifoRead
    // ---
);


// INCLUDEs
// ---
// ---


// LOCAL PARAMETER 
// ---
localparam                                      HIGH                    = 1'b1;
localparam                                      LOW                     = 1'b0;
localparam                                      DRST                    = 32'd0;
localparam                                      IDLE                    = 0;
localparam                                      DATA                    = 1;
localparam                                      START                   = 2;
localparam                                      TRMIT                   = 3;
localparam                                      PARITY                  = 4;
localparam                                      STOP                    = 5;
localparam                                      NUMOFSTATE              = 6;
// ---


// LOCAL VARIABLE 
// ---
reg         [BAUDRATECYCLEBIT-1:0]              count;
reg         [PACKAGECOUNTBIT-1:0]               packCount;
reg                                             countEnable;
reg         [STATEBIT-1:0]                      state;
reg         [PACKAGESIZE-1:0]                   data;
reg                                             parityBit;
// ---

// LOGICAL DESIGN 
// ---
always @(posedge clk)
begin
    if (rst)
    begin
        count                                   <=  DRST;
    end
    else
    begin
        count                                   <= (countEnable && (count != BAUDRATECYCLE - 1)) ? (count + 1) : DRST;
    end
end


always @(posedge clk) 
begin
    if (rst)
    begin
        countEnable                             <=  LOW;
        state                                   <=  IDLE;
        fifoRead                                <=  LOW;
        tx                                      <=  HIGH;
        packCount                               <=  DRST;
        data                                    <=  DRST;
        parityBit                               <=  LOW;
    end
    else
    begin
        fifoRead                               <=  LOW;
        case (state)
            IDLE:
            begin
                if (!fifoEmpty)
                begin
                    state                       <= DATA; 
                end
                fifoRead                        <= !fifoEmpty;
                countEnable                     <= LOW;
            end
            DATA:
            begin
                data                            <= fifoData;
                parityBit                       <= (PARITYEXISTENCE == "ODD") ? ^data : ~^data;
                packCount                       <= DRST;
                state                           <= START;
                countEnable                     <= HIGH;
            end
            START:
            begin
                tx                              <= LOW;
                if(count == BAUDRATECYCLE - 1)
                begin
                    state                       <= TRMIT; 
                end 
            end
            TRMIT:
            begin
                if (~|count)
                begin
                    if (SHIFT == "MSBFIRST")
                    begin
                        tx                      <= data[PACKAGESIZE-1];
                        data                    <= {data[PACKAGESIZE-2:0], LOW};
                    end
                    else
                    begin
                        tx                      <= data[0];
                        data                    <= {LOW, data[PACKAGESIZE-1:1]};
                    end
                end
                if (count == BAUDRATECYCLE - 1)
                begin
                    packCount                   <= packCount + 1;
                    if (packCount == PACKAGESIZE - 1)
                    begin
                        state                   <= (PARITYEXISTENCE == "NO") ? STOP : PARITY; 
                    end
                end
            end
            PARITY:
            begin
                tx                              <= parityBit;
                if (count == BAUDRATECYCLE - 1)
                begin
                    state                       <= STOP;
                end
            end
            STOP:
            begin
                if (count == BAUDRATECYCLE - 1)
                begin
                    state                       <= IDLE;
                end
            end
            default:
            begin
                state                           <= IDLE;
            end
        endcase
    end
end
// ---
// END OF MODULE     
endmodule
module uart 
#(
    parameter                       UARTBAUDRATE                = 9600,
    parameter                       UARTCLKFREQUENCY            = 10_000_000,
    parameter                       UARTPACKAGEWIDTH            = 8,         
    parameter                       UARTPARITY                  = "NO",
    parameter                       UARTSHIFT                   = "MSBFIRST",    
    parameter                       UARTFIFOSIZE                = 1024,
    parameter                       UARTFIFOWIDTH               = 8 
) 
(
    // CLOCK AND RESET 
    // ---
    input                           clkUart,
    input                           rstUart,
    input                           clkFifo,
    input                           rstFifo,
    // ---
    // UART 
    // ---
    input                           rx,
    output                          tx,
    // ---
    // RX FIFO CONTROL AND DATAPATH
    // ---
    output  [UARTFIFOWIDTH-1:0]     fifoRxReadData,
    output                          fifoRxEmpty,
    input                           fifoRxReadDataEn,
    output                          fifoRxReadDataVld,
    output                          fifoRxRstDone,
    output  [1:0]                   uartRxError,
    // --
    // TX FIFO CONTROL AND DATAPATH
    // ---
    input   [UARTFIFOWIDTH-1:0]     fifoTxWriteData,
    input                           fifoTxWriteDataEn,
    output                          fifoTxFull,
    output                          fifoTxRstDone
    // ---
);



// RX
wire                                fifoRxWriteEn;
wire    [UARTPACKAGEWIDTH-1:0]      fifoRxWriteData;
wire                                fifoRxFull;
// ---
asyncFifo  #(
    .DATAINWIDTH                    (UARTPACKAGEWIDTH),
    .DATAOUTWIDTH                   (UARTFIFOWIDTH),
    .MEMORYSIZE                     (UARTFIFOSIZE)
)
ASYNC_FIFO_RX_INST 
(
    .clkIn                          (clkUart),
    .rstIn                          (rstFifo),
    .clkOut                         (clkFifo),
    .fifoRstDone                    (fifoRxRstDone),
    .fifoEmpty                      (fifoRxEmpty),
    .fifoFull                       (fifoRxFull),
    .fifoOverflow                   (),                     // NO NEED BECAUSE UART RX WRITE OPERATION IS INHIBITED IF FIFO IS FULL
    .fifoDataOutValid               (fifoRxReadDataVld),
    .fifoDataIn                     (fifoRxWriteData),
    .fifoWriteEn                    (fifoRxWriteEn),
    .fifoDataOut                    (fifoRxReadData),
    .fifoReadEn                     (fifoRxReadDataEn)
);

uartRx #(
    .BAUDRATE                       (UARTBAUDRATE),
    .CLKFREQUENCY                   (UARTCLKFREQUENCY),
    .PACKAGESIZE                    (UARTPACKAGEWIDTH),
    .PARITYEXISTENCE                (UARTPARITY),
    .SHIFT                          (UARTSHIFT)
)
UART_RX_INST 
(
    .clk                            (clkUart),
    .rst                            (rstUart),
    .rx                             (rx),
    .fifoData                       (fifoRxWriteData),
    .fifoFull                       (fifoRxFull),
    .fifoWrite                      (fifoRxWriteEn),
    .error                          (uartRxError)
);
// ---




// TX
wire    [UARTPACKAGEWIDTH-1:0]      fifoTxReadData;
wire    [UARTPACKAGEWIDTH-1:0]      fifoTxReadDataEn;
wire                                fifoTxEmpty;
// ---
asyncFifo #(
    .DATAINWIDTH                    (UARTFIFOWIDTH),
    .DATAOUTWIDTH                   (UARTPACKAGEWIDTH),
    .MEMORYSIZE                     (UARTFIFOSIZE)
)
ASYNC_FIFO_TX_INST 
(
    .clkIn                          (clkFifo),
    .rstIn                          (rstFifo),
    .clkOut                         (clkUart),
    .fifoRstDone                    (fifoTxRstDone),
    .fifoEmpty                      (fifoTxEmpty),
    .fifoFull                       (fifoTxFull),
    .fifoOverflow                   (),                     // NO NEED BECAUSE ONE FULL IS CHECKED
    .fifoDataOutValid               (),                     // NO NEED BECAUSE ONE CLOCK IS ASSUMED
    .fifoDataIn                     (fifoTxWriteData),
    .fifoWriteEn                    (fifoTxWriteDataEn),
    .fifoDataOut                    (fifoTxReadData),
    .fifoReadEn                     (fifoTxReadDataEn)
);
  
uartTx #(
    .BAUDRATE                       (UARTBAUDRATE),
    .CLKFREQUENCY                   (UARTCLKFREQUENCY),
    .PACKAGESIZE                    (UARTPACKAGEWIDTH),
    .PARITYEXISTENCE                (UARTPARITY),
    .SHIFT                          (UARTSHIFT)
)
UART_TX_INST 
(
    .clk                            (clkUart),
    .rst                            (rstUart),
    .tx                             (tx),
    .fifoData                       (fifoTxReadData),
    .fifoEmpty                      (fifoTxEmpty),
    .fifoRead                       (fifoTxReadDataEn)
);
// ---
// END OF MODULE
endmodule
module uart 
#(
    parameter                       UARTBAUDRATE                = 9600,
    parameter                       UARTCLKFREQUENCY            = 10_000_000,
    parameter                       UARTPACKAGEWIDTH            = 8,         
    parameter                       UARTPARITY                  = "NO",
    parameter                       UARTSHIFT                   = "MSBFIRST",    
    parameter                       UARTFIFOSIZE                = 1024,
    parameter                       UARTFIFOOUTWIDTH            = 8 
) 
(
    ports
);



// RX 
// ---
async_fifo  #(
    .DATAINWIDTH                    (UARTPACKAGEWIDTH),
    .DATAOUTWIDTH                   (UARTFIFOOUTWIDTH),
    .MEMORYSIZE                     (UARTFIFOSIZE)
)
ASYNC_FIFO_RX_INST 
(
    .clkIn                          (clkIn),
    .rstIn                          (rstIn),
    .clkOut                         (clkOut),
    .fifoRstDone                    (fifoRstDone),
    .fifoEmpty                      (fifoEmpty),
    .fifoFull                       (fifoFull),
    .fifoOverflow                   (fifoOverflow),
    .fifoDataOutValid               (fifoDataOutValid),
    .fifoDataIn                     (fifoDataIn),
    .fifoWriteEn                    (fifoWriteEn),
    .fifoDataOut                    (fifoDataOut),
    .fifoReadEn                     (fifoReadEn)
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
    .clk                            (clk),
    .rst                            (rst),
    .rx                             (rx),
    .fifoData                       (fifoData),
    .fifoFull                       (fifoFull),
    .fifoWrite                      (fifoWrite)
);
// ---




// TX
// ---
async_fifo #(
    .DATAINWIDTH                    (UARTFIFOOUTWIDTH),
    .DATAOUTWIDTH                   (UARTPACKAGEWIDTH),
    .MEMORYSIZE                     (UARTFIFOSIZE)
)
ASYNC_FIFO_TX_INST 
(
    .clkIn                          (clkIn),
    .rstIn                          (rstIn),
    .clkOut                         (clkOut),
    .fifoRstDone                    (fifoRstDone),
    .fifoEmpty                      (fifoEmpty),
    .fifoFull                       (fifoFull),
    .fifoOverflow                   (fifoOverflow),
    .fifoDataOutValid               (fifoDataOutValid),
    .fifoDataIn                     (fifoDataIn),
    .fifoWriteEn                    (fifoWriteEn),
    .fifoDataOut                    (fifoDataOut),
    .fifoReadEn                     (fifoReadEn)
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
    .clk                            (clk),
    .rst                            (rst),
    .tx                             (tx),
    .fifoData                       (fifoData),
    .fifoEmpty                      (fifoEmpty),
    .fifoRead                       (fifoRead)
);
// ---
// END OF MODULE
endmodule
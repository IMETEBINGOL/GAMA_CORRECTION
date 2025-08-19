// ENG: IBRAHIM METE BINGOL
// COMPANY: MPTECH
module async_fifo 
#(
    parameter                             DATAINWIDTH                 = 8,
    parameter                             DATAOUTWIDTH                = 8,
    parameter                             MEMORYSIZE                  = 1024,
    localparam                            DATAINDEPTH                 = MEMORYSIZE / DATAINWIDTH,
    localparam                            DATAOUTDEPTH                = MEMORYSIZE / DATAOUTWIDTH
) 
(
   // CLK AND RESET PORT
   // ---
   input                                  clkIn,
   input                                  rstIn,
   input                                  clkOut,
   // ---
   // STATUS PORTS 
   // ---
   output                                 fifoRstDone,
   output                                 fifoEmpty,
   output                                 fifoFull,
   output                                 fifoOverflow,  
   output                                 fifoDataOutValid, 
   // ---
   // FIFO PORTS
   // ---
   input       [DATAINWIDTH-1:0]          fifoDataIn,
   input                                  fifoWriteEn,
   output      [DATAOUTWIDTH-1:0]         fifoDataOut,
   input                                  fifoReadEn,          
    // ---
);

wire                                      fifoReadRstDone;
wire                                      fifoWriteRstDone;
xpm_fifo_async #(
   .CASCADE_HEIGHT                           (0),
   .CDC_SYNC_STAGES                          (2),                    
   .DOUT_RESET_VALUE                         ("0"),    
   .ECC_MODE                                 ("no_ecc"),      
   .FIFO_MEMORY_TYPE                         ("auto"),
   .FIFO_READ_LATENCY                        (2),    
   .FIFO_WRITE_DEPTH                         (DATAINDEPTH),
   .FULL_RESET_VALUE                         (0), 
   .PROG_EMPTY_THRESH                        (10), 
   .PROG_FULL_THRESH                         (DATAINDEPTH - 10),     
   .RD_DATA_COUNT_WIDTH                      ($clog2(DATAOUTDEPTH)+1),
   .READ_DATA_WIDTH                          (DATAOUTWIDTH),   
   .READ_MODE                                ("std"),   
   .RELATED_CLOCKS                           (0),        
   .SIM_ASSERT_CHK                           (0),       
   .USE_ADV_FEATURES                         ("0001"), 
   .WAKEUP_TIME                              (0),     
   .WRITE_DATA_WIDTH                         (DATAINWIDTH), 
   .WR_DATA_COUNT_WIDTH                      ($clog2(DATAINDEPTH)+1)    
)
XPM_ASYNC_FIFO_INST 
(
   // CLOCK AND RESET
   // ---
   .rst                                      (rstIn),
   .wr_clk                                   (clkIn),
   .rd_clk                                   (clkOut),
   .rd_rst_busy                              (fifoReadRstDone),
   .wr_rst_busy                              (fifoWriteRstDone),  
   // ---
   // STATUS PORT
   // ---
   .data_valid                               (fifoDataOutValid),
   .empty                                    (fifoEmpty),
   .full                                     (fifoFull),                   
   .overflow                                 (fifoOverflow),
   // ---
   // READ PORT 
   // ---
   .dout                                     (fifoDataOut),
   .rd_en                                    (fifoReadEn),
   // ---
   // WRTIE PORT
   // ---
   .din                                      (fifoDataIn),
   .wr_en                                    (fifoWriteEn)
   // ---
);
assign                                       fifoRstDone       = !(fifoWriteRstDone || fifoReadRstDone);       // DONE IF BOTH RST CONDITON IS RESET 
// END OF MODULE
endmodule
task goto;
    input   [3:0]                       nextState;
    begin
        commandState                    <= nextState;
    end
endtask

task resetState;
    begin
       state                            <= FETCH; 
    end
endtask

task    setResetFifo;
    begin
        rstFifo                         <= HIGH;        
    end
endtask


task    clearResetFifo;
    begin
        rstFifo                         <= LOW;
    end
endtask

task sendPackage;
    input   [UARTFIFOWIDTH-1:0]         dataPackage;
    begin
        fifoWriteData                   <= dataPackage;
        fifoWriteDataEn                 <= HIGH;
    end
endtask

task readPackage;
    input   [3:0]                       nextState;
    begin
        if (!fifoEmpty)
        begin
            fifoReadDataEn              <= HIGH;
            goto(nextState);
        end
    end
endtask



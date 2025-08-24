`getUartErrorOpcode:
case (commandState)
    COMMANDIDLE:
    begin
        sendPackage(uartError);
        goto(COMMANDPROC0);
    end
    COMMANDPROC0:
    begin
        resetState;
    end 
    default:
    begin
        resetState;
    end 
endcase
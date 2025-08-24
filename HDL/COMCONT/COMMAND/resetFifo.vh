`resetFifoOpcode:
begin
    case (commandState)
        COMMANDIDLE:
        begin
            setResetFifo;
            goto(COMMANDPROC0);
        end
        COMMANDPROC0:
        begin
            count                   <= count + 1;
            if (count == FIFORESETWAITCYCLE)
            begin
                count               <= DRST;
                goto(COMMANDPROC1);
            end
        end
        COMMANDPROC1:
        begin
            clearResetFifo;
            goto(COMMANDPROC2);
        end
        COMMANDPROC2:
        begin
            if(fifoRxRstDone && fifoTxRstDone)
            begin
                resetState;
            end
        end
        default:
        begin
            resetState;
        end
    endcase
end
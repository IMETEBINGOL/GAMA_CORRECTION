`readSettingsOpcode:
begin
    case (commandState)
        COMMANDIDLE:
        begin
            readPackage(COMMANDPROC0);
            count                   <= count + 1;
        end
        COMMANDPROC0:
        begin
            mem_addr                <= {mem_addr[RMP_BIT_LENGTH - 1:0], fifoReadData};
            if (count == ADDRESSPACKAGECOUNT)
            begin
                goto(COMMANDPROC1);
                count               <= DRST;
            end
            else
            begin
                goto(COMMANDIDLE);
            end
        end
        COMMANDPROC1:
        begin
            regTempReg              <= mem_data_out;
            goto(COMMANDPROC2);
        end
        COMMANDPROC3:
        begin
            sendPackage(regTempReg[UARTFIFOWIDTH-1:0]);
            regTempReg              <= regTempReg >> UARTFIFOWIDTH;
            count                   <= count + 1;
            if (count == DATAPACKAGECOUNT - 1)
            begin
                goto(COMMANDPROC4);
            end
        end
        COMMANDPROC4:
        begin
            resetState;
        end
        default: 
        begin
            resetState;
        end
    endcase
end
`writeSettings:
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
            readPackage(COMMANDPROC2);
            count                   <= count + 1;
        end
        COMMANDPROC2:
        begin
            mem_data_in             <= {mem_data_in[REGISTER_MEMORY_DATA_WIDTH - 1:0], fifoReadData};
            if (count == DATAPACKAGECOUNT)
            begin
                goto(COMMANDPROC3);
                count               <= DRST;
            end
            else
            begin
                goto(COMMANDPROC1);
            end
        end 
        COMMANDPROC3:
        begin
            mem_we                  <=  HIGH;
            goto(COMMANDPROC4);         
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
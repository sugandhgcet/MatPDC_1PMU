
clc
clear all
close all force
instrreset
format shortG
global c t1 PMU DATA1;
%% Main Programme/ PMUs Details

IP="172.24.134.6";
Port=4713;
ID=2;
DATA1=[];
PMU=table(IP,Port,ID)
i=[1;2;3;4;5;6;7];
Defination=["Turn off transmission of data frame" ; "Turn on transmission of data frame" ; "Send HDR frame" ; "Send CFG-1 frame" ;...
    "Send CFG-2 frame" ; "Send CFG-3 frame" ; "Extended frame"];
Command=table(i,Defination);

%% 1 PMU
t1 = tcpclient(PMU.IP(1),PMU.Port(1))
Device_ID=PMU.ID(1)
c=5;        %Send_CFG_2=uint8([0 5]);
Send_CMD=CMD(Device_ID,c);
write(t1,Send_CMD)
% tic
while t1.BytesAvailable == 0
    tic
    c=5;
    write(t1,Send_CMD)
    toc
end
% toc
CFG2=table(read(t1));
% tic
[PHNMR, ANNMR, DGNMR,Phasor1,Analog1,Digital1,Freq_nominal,DATA_RATE,time_base]=PMUinfo(CFG2);
Signal_Name = [cellstr(cat(1,Phasor1,Analog1,"Frequency", "DFREQ",Digital1))]';
% toc
PMU_read(PHNMR, ANNMR,DGNMR,time_base);

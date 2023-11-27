
function CMD=CMD(Device_ID,c)
turn_off=uint8([0 1]);
turn_on=uint8([0 2]);
Send_HDR=uint8([0 3]);
Send_CFG_1=uint8([0 4]);
Send_CFG_2=uint8([0 5]);
Send_CFG_3=uint8([0 6]);
Send_CFG_ext=uint8([0 7]);
SYNC1=170;
SYNC2=65;
SYNC= uint8([SYNC1 SYNC2]);
FRAMESIZE=uint8( 9*[0,length(Send_CFG_2)]);
ID_CODE=uint8(Device_ID);
T = datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss.SSSSSS');
SOC1=uint32(posixtime(T));
b1 = de2bi(SOC1,'left-msb');
l=length(b1);
SOC=uint8([bi2de(b1(1,1:l-24),'left-msb') bi2de(b1(1,l-23:l-16),'left-msb') bi2de(b1(1,l-15:l-8),'left-msb') bi2de(b1(1,l-7:l),'left-msb')]);
Time_Quality=0;
T = datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss.SSSSSS');
FRACSEC=second(T)-floor(second(T));
Timebase=10000000;
FRACSEC1=uint32(floor(Timebase*FRACSEC));
b2 = de2bi(FRACSEC1,'left-msb');
l1=length(b2);
FRACSEC=uint8([bi2de(b2(1,1:l1-16),'left-msb') bi2de(b2(1,l1-15:l1-8),'left-msb') bi2de(b2(1,l1-7:l1),'left-msb')]);
switch c
%% turn data off frame
case 1
CMD_Frame=[SYNC,FRAMESIZE,0,ID_CODE,SOC , Time_Quality, FRACSEC, turn_off];
CRC=CRC_CCK(CMD_Frame);
CMD_Frame=[CMD_Frame, CRC];
CMD=CMD_Frame;
%% turn data on frame
case 2
CMD_Frame=[SYNC,FRAMESIZE,0,ID_CODE,SOC , Time_Quality, FRACSEC, turn_on];
CRC=CRC_CCK(CMD_Frame);
CMD_Frame=[CMD_Frame, CRC];
CMD=CMD_Frame;
%% send hader frame
case 3
CMD_Frame=[SYNC,FRAMESIZE,0,ID_CODE,SOC , Time_Quality, FRACSEC, Send_HDR];
CRC=CRC_CCK(CMD_Frame);
CMD_Frame=[CMD_Frame, CRC];
CMD=CMD_Frame;
%% send configuration 1 frame
case 4
CMD_Frame=[SYNC,FRAMESIZE,0,ID_CODE,SOC , Time_Quality, FRACSEC, Send_CFG_1];
CRC=CRC_CCK(CMD_Frame);
CMD_Frame=[CMD_Frame, CRC];
CMD=CMD_Frame;
%%  send configuration 2 frame
case 5
CMD_Frame=[SYNC,FRAMESIZE,0,ID_CODE,SOC , Time_Quality, FRACSEC, Send_CFG_2];
CRC=CRC_CCK(CMD_Frame);
CMD_Frame=[CMD_Frame, CRC];
CMD=CMD_Frame;
%% send configuration 3 frame
case 6
CMD_Frame=[SYNC,FRAMESIZE,0,ID_CODE,SOC , Time_Quality, FRACSEC, Send_CFG_3];
CRC=CRC_CCK(CMD_Frame);
CMD_Frame=[CMD_Frame, CRC];
CMD=CMD_Frame;
%%  send Extended configuration frame
case 7
CMD_Frame=[SYNC,FRAMESIZE,0,ID_CODE,SOC , Time_Quality, FRACSEC, Send_CFG_ext];
CRC=CRC_CCK(CMD_Frame);
CMD_Frame=[CMD_Frame, CRC];
CMD=CMD_Frame;
end
end
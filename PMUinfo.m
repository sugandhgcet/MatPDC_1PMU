function [PHNMR, ANNMR, DGNMR,Phasor1,Analog1,Digital1,Freq_nominal,DATA_RATE, time_base]=PMUinfo(CFG1)
NUM_PMU=bi2de([de2bi(CFG1.Var1(19)) de2bi(CFG1.Var1(20))]);
Bt=20;%Start from 20 Bytes of CONFIG FRAME
for i=1:NUM_PMU
    STN=char(CFG1.Var1(20+1:20+16));
%     IDCODE=uint16(bi2de([de2bi(CFG1.Var1(37)) de2bi(CFG1.Var1(38))]));
%     FORMAT=uint16(bi2de([de2bi(CFG1.Var1(20+19)) de2bi(CFG1.Var1(20+20))]));
%     PHNMR=uint16(bi2de([de2bi(CFG1.Var1(20+21)) de2bi(CFG1.Var1(20+22))]));
%     ANNMR=uint16(bi2de([de2bi(CFG1.Var1(20+23)) de2bi(CFG1.Var1(20+24))]));
%     DGNMR=uint16(bi2de([de2bi(CFG1.Var1(20+25)) de2bi(CFG1.Var1(20+26))]));
  IDCODE=uint16(bi2de([de2bi(CFG1.Var1(37),'left-msb') de2bi(CFG1.Var1(38),'left-msb')],'left-msb'));
  FORMAT=uint16(bi2de([de2bi(CFG1.Var1(39),'left-msb') de2bi(CFG1.Var1(40),'left-msb')],'left-msb'));
  PHNMR=uint16(bi2de([de2bi(CFG1.Var1(41),'left-msb') de2bi(CFG1.Var1(42),'left-msb')],'left-msb'));
  ANNMR=uint16(bi2de([de2bi(CFG1.Var1(43),'left-msb') de2bi(CFG1.Var1(44),'left-msb')],'left-msb'));
  DGNMR=uint16(bi2de([de2bi(CFG1.Var1(45),'left-msb') de2bi(CFG1.Var1(46),'left-msb')],'left-msb'));
    CHNAM=uint16(16*(PHNMR+ANNMR+16*DGNMR));
    PHUNIT=uint16(4*(PHNMR+ANNMR+DGNMR));
    DATA_FRAME_SIZE=20+16+10+CHNAM+PHUNIT+4+4;      %4=FNOM+CFG1.Var1CNT, 4=DATA_RATE+CHK;
time_base=swapbytes(typecast(CFG1.Var1(1,15:18),'uint32'));
if bitand(FORMAT,1)==1
    out1=1;
else
    out1=0;
end
PH_MAG_ANG=out1;
if bitand(FORMAT,2)==2
    out2=1;
else
    out2=0;
end
PH_FLOATING=out2;
if bitand(FORMAT,4)==4
    out3=1;
else
    out3=0;
end
AN_FLOATING=out3;
if bitand(FORMAT,8)==8
    out4=1;
else
    out4=0;
end
FREQ_DFREQ_FLOATING=out4;
slash=' /';
Phasor1=[];
% for j=20+27:16:(20+26+PHNMR*16)
%     %Phasors
%         Phasor=[char(CFG1.Var1(20+1:20+16)),slash,char(CFG1.Var1(j:j+15))];
%         Phasor1= cat(1,Phasor1,Phasor);
% end

for j=20+27:16:(20+26+PHNMR*16)
    %Phasors
        Phasor=strcat(char(CFG1.Var1(20+1:20+16)),slash,char(CFG1.Var1(j:j+15)));
        Phasor=repmat(Phasor,2,1);
        Phasor1= (cat(1,Phasor1,Phasor));
end
Phasor1;
% size(CFG1.Var1(16*(j+2)-1:16*(j+3)-3))
Analog1=[];
for j=(20+26+PHNMR*16)+1:16:(16*ANNMR+(PHNMR*16+20+26))
    %Analogs
        Analog=(strcat(char(CFG1.Var1(20+1:20+16)),slash,char(CFG1.Var1(j:j+15))));
        Analog1=cellstr(cat(1,Analog1,Analog));
       
end
Analog1;

 Digital1=[];
for j=(16*ANNMR+(PHNMR*16+20+26))+1:16:16*DGNMR*16+(16*ANNMR+(PHNMR*16+20+26))
    %Digitals
        Digital=strcat(char(CFG1.Var1(20+1:20+16)),slash,char(CFG1.Var1(j:j+15)));
        Digital1=cellstr(cat(1,Digital1,Digital));
end
Digital1;
for j=16*DGNMR*16+(16*ANNMR+(PHNMR*16+20+26))+1:4:16*DGNMR*16+(16*ANNMR+(PHNMR*16+20+26))+4*PHNMR
        PHUNIT=CFG1.Var1(j:j+3);
end

for j=16*DGNMR*16+(16*ANNMR+(PHNMR*16+20+26))+4*PHNMR+1:4:16*DGNMR*16+(16*ANNMR+(PHNMR*16+20+26))+4*PHNMR+4*ANNMR
        ANUNIT=CFG1.Var1(j:j+3);
end
for j=16*DGNMR*16+(16*ANNMR+(PHNMR*16+20+26))+4*PHNMR+4*ANNMR+1:4:16*DGNMR*16+(16*ANNMR+(PHNMR*16+20+26))+4*PHNMR+4*ANNMR+4*DGNMR
        DGUNIT=CFG1.Var1(j:j+3);
end
        FNOM=uint16(bi2de([de2bi(CFG1.Var1(16*DGNMR*16+(16*ANNMR+(PHNMR*16+20+26))+4*PHNMR+4*ANNMR+4*DGNMR+1),'left-msb') de2bi(CFG1.Var1(16*DGNMR*16+(16*ANNMR+(PHNMR*16+20+26))+4*PHNMR+4*ANNMR+4*DGNMR+2),'left-msb')],'left-msb'));
if FNOM==1
        Freq_nominal = 50;
elseif FNOM==0
        Freq_nominal = 60;
else
        error('Nominal Frequency not found') 
end
        CFG1.Var1GCNT=uint16(bi2de([de2bi(CFG1.Var1(16*DGNMR*16+(16*ANNMR+(PHNMR*16+20+26))+4*PHNMR+4*ANNMR+4*DGNMR+3),'left-msb') de2bi(CFG1.Var1(16*DGNMR*16+(16*ANNMR+(PHNMR*16+20+26))+4*PHNMR+4*ANNMR+4*DGNMR+4),'left-msb')],'left-msb'));
% 20=16*DGNMR*16+(16*ANNMR+(PHNMR*16+20+26))+4*PHNMR+4*ANNMR+4*DGNMR+4
end
DATA_RATE=uint16(bi2de([de2bi(CFG1.Var1(16*DGNMR*16+(16*ANNMR+(PHNMR*16+20+26))+4*PHNMR+4*ANNMR+4*DGNMR+1+2+2),'left-msb') de2bi(CFG1.Var1(16*DGNMR*16+(16*ANNMR+(PHNMR*16+20+26))+4*PHNMR+4*ANNMR+4*DGNMR+2+2+2),'left-msb')],'left-msb'));
CHK=uint16(bi2de([de2bi(CFG1.Var1(16*DGNMR*16+(16*ANNMR+(PHNMR*16+20+26))+4*PHNMR+4*ANNMR+4*DGNMR+1+2+2+2),'left-msb') de2bi(CFG1.Var1(16*DGNMR*16+(16*ANNMR+(PHNMR*16+20+26))+4*PHNMR+4*ANNMR+4*DGNMR+2+2+2+2),'left-msb')],'left-msb'));

end
function CRC=CRC_CCK(CMD_Frame)
%%%% CRC Byte
a=65535;
for i=1:length(CMD_Frame)
   
    am8=(bitshift(a,-8,'uint16'));
    %am8=a(1,1:8);
    %c1=(uint16(CMD_Frame(1,1)))
    if (length(de2bi(uint16(am8))))> (length(de2bi(CMD_Frame(1,i))))
        x1=xor(de2bi(uint16(am8),'left-msb'),logical([zeros(1,abs(-length(de2bi(CMD_Frame(1,i),'left-msb'))+length(de2bi(uint16(am8),'left-msb')))),de2bi(CMD_Frame(1,i),'left-msb')]));
    else
        x1=xor(logical([zeros(1,abs(-length(de2bi(CMD_Frame(1,i),'left-msb'))+length(de2bi(uint16(am8),'left-msb')))),de2bi(uint16(am8),'left-msb')]),de2bi(CMD_Frame(1,i),'left-msb'));
    end
    
    %x1=bi2de(x1,'left-msb')
    am4=(bitshift(bi2de(x1,'left-msb'), -4,'uint16'));
    if length(x1) > length(de2bi(am4,'left-msb'))
        x2=xor(logical([zeros(1,abs(length(x1)-length(de2bi(am4,'left-msb')))),de2bi(am4,'left-msb')]),x1);
    else
        x2=xor(de2bi(am4,'left-msb'),logical([zeros(1,abs(length(x1)-length(de2bi(am4,'left-msb')))),x1]));
    end
    
    ap5=bitshift(bi2de(x2,'left-msb'),5,'uint16');
    ap7=bitshift(ap5,7,'uint16');
    ap8=(bitshift(a,8,'uint16'));
    if length(de2bi(ap8,'left-msb')) > length(x2)
        x3=xor(de2bi(ap8,'left-msb'),logical([zeros(1,abs(-length(x2)+(length(de2bi(ap8,'left-msb'))))),x2]));
    else
        x3=xor(logical([zeros(1,abs(-length(x2)+(length(de2bi(ap8,'left-msb'))))),de2bi(ap8,'left-msb')]),x2);
    end
    if length(x3) > length(de2bi(ap5,'left-msb'))
        x4=xor(x3,logical([zeros(1,abs(-length(de2bi(ap5,'left-msb'))+(length(x3)))),de2bi(ap5,'left-msb')]));
    else
        x4=xor(logical([zeros(1,abs(-length(de2bi(ap5,'left-msb'))+(length(x3)))),x3]),de2bi(ap5,'left-msb'));
    end
    
    if length(x4)> length(de2bi(ap7,'left-msb'))
        x5=xor(x4,logical([zeros(1,abs(-length(de2bi(ap7,'left-msb'))+(length(x4)))),de2bi(ap7,'left-msb')]));
    else
        x5=xor(logical([zeros(1,abs(-length(de2bi(ap7,'left-msb'))+(length(x4)))),x4]),de2bi(ap7,'left-msb'));
    end
    L3=length(x5);
    x6=uint8([bi2de(x5(1,1:L3-8),'left-msb'), bi2de(x5(1,L3-7:L3),'left-msb')]);
    
    a=bi2de(x5,'left-msb');
end
a=de2bi(a,'left-msb');
CRC=x6;
end

function DATAF()
global t1 DATAF1 DATA_size1;
while t1.NumBytesAvailable == 0
end

DATAF1=read(t1);
flush(t1);
DATAF1=read(t1);
flush(t1);
while t1.NumBytesAvailable == 0
end
DATAF1=read(t1);
DATA_size1=double(DATAF1(1,4));
end
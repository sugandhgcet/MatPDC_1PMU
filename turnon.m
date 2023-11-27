function turnon=turnon()
global  t1 PMU;

c=2;

Device_ID=PMU.ID(1);
data=CMD(Device_ID,c);
write(t1,data);
end
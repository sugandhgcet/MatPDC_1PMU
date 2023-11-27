function turnoff = turnoff()
%% stop data transmission
global t1 PMU;
c=1;
Device_ID=PMU.ID(1);
data=CMD(Device_ID,c);
write(t1,data);
end


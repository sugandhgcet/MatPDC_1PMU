function PMU_read(PHNMR, ANNMR,DGNMR,time_base)

global t1;
%% stop data transmission
turnoff();

%% Start data transmission
turnon();

%% Read DATA Frames
DATAF();
%%
        while t1.BytesAvailable == 0

        end
        configureCallback(t1,"terminator",@(varargin)pmu1(PHNMR, ANNMR,DGNMR,time_base))
end

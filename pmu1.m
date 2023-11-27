function DATA1= pmu1(PHNMR, ANNMR,DGNMR,time_base)
global DATA_size1 t1 DATA1;

DATAF1=read(t1);
DATA_size1
length(DATAF1)
newValue = cell( numel(DATAF1) / DATA_size1 ,1);

if numel(DATAF1)/ DATA_size1 >=1
    S1 = STATf(typecast([(DATAF1(1,15)) (DATAF1(1,16))], 'uint16'));
end
for i = 1:numel(newValue)
    startIndex = double(1 + DATA_size1 * (i - 1));
    endIndex = double(double(startIndex) + double(DATA_size1) - double(1));

    dataSubset = DATAF1(double(startIndex):double(endIndex));

    posixBytes = typecast(uint8(dataSubset(1,7:10)), 'uint32');
    posix = swapbytes(posixBytes);

    fracSec = round(double(bit2int(int2bit([dataSubset(12); dataSubset(13); dataSubset(14)], 8), 24, true)) / double(time_base), 3);

    soc = double(posix) + fracSec;

    PMU_time = datetime(soc, 'ConvertFrom', 'posixtime', 'TimeZone', 'UTC', 'Format', 'd-MMM-y HH:mm:ss.SSS')

    STAT = (typecast([(dataSubset(15)) (dataSubset(16))], 'uint16'));
    STAT = double(STAT);
    size(dataSubset)
    if PHNMR ~= 0
        PHASOR = swapbytes(typecast(uint8(dataSubset(16 + 1:16 + 8 * PHNMR)), 'single'));
    else
        PHASOR = NaN(0);
    end

    if ANNMR ~= 0
        ANALOG = swapbytes(typecast(uint8(dataSubset(16 + 8 * PHNMR + 8 + 1:16 + 8 * PHNMR + 4 * ANNMR + 8)), 'single'));
    else
        ANALOG = NaN(0);
    end

    if DGNMR ~= 0
        Di = 16 + 8 * PHNMR + 4 * ANNMR + 8;
        DIGITAL = de2bi(uint16(dataSubset(Di + 1:Di + 2 * DGNMR)), 8, 'left-msb');
        DIGITAL_a = reshape(DIGITAL', 1, numel(DIGITAL));
    else
        DIGITAL_a = NaN(0);
    end

    FREQ = double(swapbytes(typecast(uint8(dataSubset(16 + 8 * PHNMR + 1:16 + 8 * PHNMR + 4)), 'single')));
    DFREQ = double(swapbytes(typecast(uint8(dataSubset(16 + 8 * PHNMR + 5:16 + 8 * PHNMR + 8)), 'single')));

    newValue{i} = timetable(PMU_time, STAT, PHASOR, ANALOG, double(DIGITAL_a), FREQ, DFREQ);
end

%% 
% Value = vertcat(newValue{:})
% Value=timetable(PMU_time,STAT,PHASOR,ANALOG,DIGITAL_a,FREQ,DFREQ);
DATA=newValue;
% DATA1=vertcat(DATA1,DATA);
% height(DATA1);
% 
% if height(DATA1)>=3
%     rawDATA1=DATA1;
%     DATA1=timetable();
% end
end


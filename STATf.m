function S=STATf(STAT)
    STATb = int2bit(0, 16)';

    % Lookup table for DATA_error
    DATA_error_map = {
        'Good Measurement Data, No error'
        'PMU error, No information about data'
        'PMU in test mode'
        'PMU error'
        'PMU Error (Do not use values)'
        };
    DATA_error = DATA_error_map{bit2int([STATb(1); STATb(2)], 2) + 1};

    % Lookup table for PMU_SYNC
    PMU_SYNC_map = {
        'PMU SYNC with UTC traceable time source'
        'PMU SYNC problem'
        };
    PMU_SYNC = PMU_SYNC_map{STATb(3) + 1};

    % Lookup table for Data_Sorting
    Data_Sorting_map = {
        'Data Sorting by Timestamp'
        'Data Sorting by Arrival'
        };
    Data_Sorting = Data_Sorting_map{STATb(4) + 1};

    % Lookup table for PMU_Trigger
    PMU_Trigger_map = {
        'No Trigger Detected'
        'PMU Trigger Detected'
        };
    PMU_Trigger = PMU_Trigger_map{STATb(5) + 1};

    % Lookup table for Configuration_Change
    Configuration_Change_map = {
        'Configuration change'
        'Configuration change affected'
        };
    Configuration_Change = Configuration_Change_map{STATb(6) + 1};

    % Lookup table for Data_Modified
    Data_Modified_map = {
        'Data Modified by post processing'
        'No Data Modified'
        };
    Data_Modified = Data_Modified_map{STATb(7) + 1};

    % Lookup table for PMUtq
    PMUtq_map = {
        'Normal operation, clock locked to UTC traceable source'
        'Estimated maximum time error less than 100ns'
        'Estimated maximum time error less than 1us'
        'Estimated maximum time error less than 10us'
        'Estimated maximum time error less than 100us'
        'Estimated maximum time error less than 1ms'
        'Estimated maximum time error less than 10ms'
        'Estimated maximum time error greater than 10ms or unknown error'
        };
    PMUtq = PMUtq_map{bit2int([STATb(8); STATb(9); STATb(10)], 3) + 1};

    % Lookup table for PMU_Unlock_time
    PMU_Unlock_time_map = {
        'Locked or unlocked less than 10s (Best Quality)'
        'Unlocked greater than 10s but less than 100s'
        'Unlocked greater than 100s but less than 1000s'
        'Unlocked 1000s or more'
        };
    PMU_Unlock_time = PMU_Unlock_time_map{bit2int([STATb(11); STATb(12)], 2) + 1};

    % Lookup table for Trigger_reason
    Trigger_reason_map = {
        'Normal operation, clock locked to UTC traceable source'
        'Manual'
        'Magnitude low'
        'Magnitude High'
        'Phase angle Diff'
        'Frequency High and Low'
        'dF/dT High'
        'Reserved'
        'Digital'
        };
    Trigger_reason = Trigger_reason_map{bit2int([STATb(13); STATb(14); STATb(15); STATb(16)], 4) + 1};

    % Build the output struct
    S.DATA_error = DATA_error;
    S.PMU_SYNC = PMU_SYNC;
    S.Data_Sorting = Data_Sorting;
    S.PMU_Trigger = PMU_Trigger;
    S.Configuration_Change = Configuration_Change;
    S.Data_Modified = Data_Modified;
    S.PMUtq = PMUtq;
    S.PMU_Unlock_time = PMU_Unlock_time;
    S.Trigger_reason = Trigger_reason;
end

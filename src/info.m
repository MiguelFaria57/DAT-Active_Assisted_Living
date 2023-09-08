function info()
    % users in PL2
    User = {'05', '06', '07', '08'};
    % experiments done by the users
    Exp = {'09', '10','11','12','13','14','15','16'};
    % activities labels
    activities = {'W', 'W\_U', 'W\_D', 'SIT', 'STAND', 'LAY', 'STAND\_SIT', 'SIT\_STAND', 'SIT\_LIE', 'LIE\_SIT', 'STAND\_LIE', 'LIE\_STAND'};
    % sensors X, Y, Z
    sensors = {'ACC\_X', 'ACC\_Y', 'ACC\_Z'};
    % Frequency indicated on README
    Fs = 50;
    % Get label info (experience, user, activity id, start and end) 
    all_labels = import_labels('HAPT Data Set/RawData/labels.txt');
    % Save in MATLAB Data file
    save dataset;
end
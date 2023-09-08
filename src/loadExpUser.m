function loadExpUser()
    load dataset;
    
    for n = 1 : 1 : numel(Exp)
        e = n; % current experiment
        u = ceil(e/2); % current user
        file = sprintf('datasetAcc_exp%s_user%s.mat', Exp{e}, User{u});
        
        % acc file name
        acc_file = sprintf('HAPT Data Set/RawData/acc_exp%s_user%s.txt', Exp{e}, User{u});
        % import acc rawdata
        data = import_rawdata(acc_file);
        % get labels for the current data file, returns number of the lines 
        current_labels = intersect(find(all_labels(:, 1) == str2num(Exp{e})), find(all_labels(:, 2) == str2num(User{u})));
        % create time vector 
        t = [0: size(data, 1) - 1]./Fs;
        % get data size
        [n_points, n_plots] = size(data);
        % Save in MATLAB Data file
        save(file);
    end
end
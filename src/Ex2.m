function Ex2()
    load dataset;
    for n = 1 : 1%numel(Exp)
        e = n; % current experiment
        u = ceil(e/2); % current user
        
        file = sprintf('datasetAcc_exp%s_user%s.mat', Exp{e}, User{u});
        load(file);

        figure;
        for i = 1 : n_plots % 'ACC\_X', 'ACC\_Y', 'ACC\_Z'

            subplot(n_plots, 1, i); % subplot to get all axis on the same figure
            plot(t./60, data(:, i), 'k--') % plot the experiment of the axis index i
            axis([0, t(end)./60, min(data(:, i)), max(data(:, i))]) % define the length of the axis
            titulo = sprintf('User %s Experience %s', User{u}, Exp{e}); % get the title
            title(titulo); % insert title
            xlabel('Time (min)'); % insert x label
            ylabel(sensors{i}); % insert correct axis to the y label
            hold on

            for j = 1 : numel(current_labels) % number of array elements - each activity
                % plot (beginning of act - end of act in min, data from the beginning to the end from i column)
                plot(t(all_labels(current_labels(j), 4):all_labels(current_labels(j), 5))./60, data(all_labels(current_labels(j), 4):all_labels(current_labels(j), 5), i));
                % alternate between writing on top and bottom
                if mod(j, 2) == 1
                    act = min(data(:, i)) - (0.2 * min(data(:, i))); % act down
                else
                    act = max(data(:, i)) - (-0.2 * min(data(:, i))); % act up
                end
                text(t(all_labels(current_labels(j), 4))/60, act, activities{all_labels(current_labels(j), 3)});
            end

            hold off

        end
    end
end
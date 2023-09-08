function Ex3()
%%
%Ex_3.1
    load dataset;
    for n = 1 : 1%numel(Exp)
        e = n; % current experiment
        u = ceil(e/2); % current user

        file = sprintf('datasetAcc_exp%s_user%s.mat', Exp{e}, User{u});
        load(file);
        
        % Choose a dynamic activity for 3.1
        activity = 'W\_U';
        for j = 1 : numel(current_labels) % number of array elements - each activity
            a = activities{all_labels(current_labels(j), 3)}; % get activity name from the activity id
            if strcmp(a, activity) % verify if the activity is the selected dynamic activity
                figure;
                for i = 1 : n_plots % 'ACC\_X', 'ACC\_Y', 'ACC\_Z'
                    x = data(all_labels(current_labels(j), 4):all_labels(current_labels(j), 5), i); % get activity data
                    windowTesting(x, i); 
                end
                titulo = sprintf('Exp%s User%s - %s', Exp{e}, User{u}, activity);
                sgtitle(titulo);
                
                break % analizing all windows just for one activity as an example
            end
        end
    end
    
    
%%
%Ex_3.2
    load dataset;
    for n = 1 : 1%numel(Exp)
        e = n; % current experiment
        u = ceil(e/2); % current user

        file = sprintf('datasetAcc_exp%s_user%s.mat', Exp{e}, User{u});
        load(file);
                
        for j = 1 : numel(current_labels) % number of array elements - each activity
            a = activities{all_labels(current_labels(j), 3)}; % get activity name from the activity id
            figure;
            for i = 1 : n_plots % 'ACC\_X', 'ACC\_Y', 'ACC\_Z'
                x = data(all_labels(current_labels(j), 4):all_labels(current_labels(j), 5), i); % get activity data
                subplot(n_plots, 1, i);
                DFT(e, u, x, i); 
            end
            titulo = sprintf('Exp%s User%s - DFT %s', Exp{e}, User{u}, a);
            sgtitle(titulo);
        end
    end
    
%%
%Ex_3.3


%%
%Ex_3.4
    load dataset;
    
    dynamicAct = {'W', 'W\_U', 'W\_D'};
    walking = [];
    walking_up = [];
    walking_down = [];
    desv_walking = [];
    desv_walking_up = [];
    desv_walking_down = [];
    for n = 1 : numel(Exp)
        e = n; % current experiment
        u = ceil(e/2); % current user
        file = sprintf('datasetAcc_exp%s_user%s.mat', Exp{e}, User{u});
        load(file);
        
         for a = 1 : length(dynamicAct) % dynamic activities 
             passosAtividade = [];
             for j = 1 : numel(current_labels)
                act = activities{all_labels(current_labels(j), 3)}; % get activity name from the activity id
                passosEixos = [];
                if strcmp(dynamicAct(a), act) % verify if the activity is the correspondent
                    for i = 1 : n_plots % 'ACC\_X', 'ACC\_Y', 'ACC\_Z'
                        x = data(all_labels(current_labels(j), 4):all_labels(current_labels(j), 5), i); % get activity data
                        step = steps(x);
                        passosEixos(end +1) = step; 
                    end
                    passosEixos = mean(passosEixos);
                    passosAtividade(end +1) = passosEixos;
                end
             end
             desvio = std(passosAtividade);
             media = mean(passosAtividade);
             if a == 1
                 walking(end +1) = media;
                 desv_walking(end +1) = desvio;
             elseif a == 2
                 walking_up(end +1) = media;
                 desv_walking_up(end +1) = desvio;
             elseif a == 3
                walking_down(end +1) = media;
                desv_walking_down(end +1) = desvio;
             end
         end
    end
    walking
    walking_up
    walking_down
    
    desv_walking
    desv_walking_up
    desv_walking_down
    
    
%%
%Ex_3.5
    load dataset;
    
    DA_x = [];
    DA_y = [];
    DA_z = [];
    SA_x = [];
    SA_y = [];
    SA_z = [];
    TA_x = [];
    TA_y = [];
    TA_z = [];
    
    for n = 1 : numel(Exp)
        e = n; % current experiment
        u = ceil(e/2); % current user

        file = sprintf('datasetAcc_exp%s_user%s.mat', Exp{e}, User{u});
        load(file);
        
        for j = 1 : numel(current_labels)
            a = activities{all_labels(current_labels(j), 3)}; % get activity name from the activity id
            for i = 1 : n_plots % 'ACC\_X', 'ACC\_Y', 'ACC\_Z'
                x = data(all_labels(current_labels(j), 4):all_labels(current_labels(j), 5), i); % get activity data
                X = fftshift(fft(detrend(x)));
                m = max(abs(X));
                if strcmp(a, 'W') == 1 ||strcmp(a, 'W\_U') == 1 || strcmp(a, 'W\_D') == 1
                    if i == 1
                        DA_x(end +1) = m;
                    elseif i ==2
                        DA_y(end +1) = m;
                    else
                        DA_z(end +1) = m;
                    end
                
                elseif strcmp(a, 'SIT') == 1 ||strcmp(a, 'STAND') == 1 || strcmp(a, 'LAY') == 1
                    if i == 1
                        SA_x(end +1) = m;
                    elseif i == 2
                        SA_y(end +1) = m;
                    else
                        SA_z(end +1) = m;
                    end
                else
                    if i == 1
                        TA_x(end +1) = m;
                    elseif i ==2
                        TA_y(end +1) = m;
                    else
                        TA_z(end +1) = m;
                    end
                end 
            end
        end
    end 
    
    % calculate average and deviation
    %{ 
    media_m_dax = mean(DA_x)
    std(DA_x)
    media_m_day = mean(DA_y)
    std(DA_y)
    media_m_daz = mean(DA_z)
    std(DA_z)
    media_m_sax = mean(SA_x)
    std(SA_x)
    media_m_say = mean(SA_y)
    std(SA_y)
    media_m_saz = mean(SA_z)
    std(SA_z)
    media_m_tax = mean(TA_x)
    std(TA_x)
    media_m_tay = mean(TA_y)
    std(TA_y)
    media_m_taz = mean(TA_z)
    std(TA_z)
    %}
    
    figure;
    plot3(DA_x,DA_y,DA_z,'*g','DisplayName','Dynamic Activities')
    hold on
    plot3(SA_x,SA_y,SA_z,'ob','DisplayName','Static Activities')
    plot3(TA_x,TA_y,TA_z,'+r','DisplayName','Transition Activities')
    xlabel('ACC_X')
    ylabel('ACC_Y')
    zlabel('ACC_Z')
    legend show
    hold off

    
 %%
 %Ex_3.6
 
     Wx = [];Wy = [];Wz = [];
     WUx = []; WUy = []; WUz = [];
     WDx = []; WDy = []; WDz = [];

     SITx = []; SITy = []; SITz = [];
     STANDx = []; STANDy = []; STANDz = [];
     LAYx = []; LAYy = []; LAYz = [];

     STANDSITx = [];STANDSITy = [];STANDSITz = [];
     STANDLIEx = []; STANDLIEy = []; STANDLIEz = [];
     SITSTANDx = []; SITSTANDy = []; SITSTANDz = [];
     SITLIEx = []; SITLIEy = []; SITLIEz = [];
     LIESITx = []; LIESITy = []; LIESITz = [];
     LIESTANDx = []; LIESTANDy = []; LIESTANDz = [];

     for n = 1 : numel(Exp)
            e = n; % current experiment
            u = ceil(e/2); % current user

            file = sprintf('datasetAcc_exp%s_user%s.mat', Exp{e}, User{u});
            load(file);

            for j = 1 : numel(current_labels)
                a = activities{all_labels(current_labels(j), 3)}; % get activity name from the activity id
                for i = 1 : n_plots % 'ACC\_X', 'ACC\_Y', 'ACC\_Z'
                    x = data(all_labels(current_labels(j), 4):all_labels(current_labels(j), 5), i); % get activity data
                    X = fftshift(fft(detrend(x)));
                    m = max(abs(X));
                    if strcmp(a, 'W') == 1
                        if i == 1
                            Wx(end +1) = m;
                        elseif i ==2
                            Wy(end +1) = m;
                        else
                            Wz(end +1) = m;
                        end
                    elseif strcmp(a, 'W\_U') == 1
                        if i == 1
                            WUx(end +1) = m;
                        elseif i ==2
                            WUy(end +1) = m;
                        else
                            WUz(end +1) = m;
                        end
                    elseif strcmp(a, 'W\_D') == 1
                        if i == 1
                            WDx(end +1) = m;
                        elseif i ==2
                            WDy(end +1) = m;
                        else
                            WDz(end +1) = m;
                        end
                    elseif strcmp(a, 'SIT') == 1
                        if i == 1
                            SITx (end +1) = m;
                        elseif i ==2
                            SITy (end +1) = m;
                        else
                            SITz (end +1) = m;
                        end

                    elseif strcmp(a, 'STAND') == 1
                        if i == 1
                            STANDx(end +1) = m;
                        elseif i ==2
                            STANDy(end +1) = m;
                        else
                            STANDz(end +1) = m;
                        end

                    elseif strcmp(a, 'LAY') == 1
                        if i == 1
                            LAYx(end +1) = m;
                        elseif i ==2
                            LAYy(end +1) = m;
                        else
                            LAYz(end +1) = m;
                        end
                    elseif strcmp(a, 'STAND\_SIT') == 1 
                        if i == 1
                            STANDSITx(end +1) = m;
                        elseif i ==2
                            STANDSITy(end +1) = m;
                        else
                            STANDSITz(end +1) = m;
                        end

                    elseif strcmp(a, 'STAND\_LIE') == 1 if i == 1
                             STANDLIEx (end +1) = m;
                        elseif i ==2
                             STANDLIEy (end +1) = m;
                        else
                             STANDLIEz (end +1) = m;
                        end

                    elseif strcmp(a, 'SIT\_STAND') == 1 
                        if i == 1
                            SITSTANDx(end +1) = m;
                        elseif i ==2
                            SITSTANDy(end +1) = m;
                        else
                            SITSTANDz(end +1) = m;
                        end

                    elseif strcmp(a, 'SIT\_LIE') == 1 
                        if i == 1
                            SITLIEx(end +1) = m;
                        elseif i ==2
                            SITLIEy(end +1) = m;
                        else
                            SITLIEz(end +1) = m;
                        end

                    elseif strcmp(a, 'LIE\_SIT') == 1 
                        if i == 1
                            LIESITx(end +1) = m;
                        elseif i ==2
                            LIESITy(end +1) = m;
                        else
                            LIESITz(end +1) = m;
                        end

                    elseif strcmp(a, 'LIE\_STAND') == 1 
                        if i == 1
                            LIESTANDx(end +1) = m;
                        elseif i ==2
                            LIESTANDy(end +1) = m;
                        else
                            LIESTANDz(end +1) = m;
                        end

                    end
                end
            end
     end

     figure;
        plot3(Wx,Wy,Wz,'*g','DisplayName','walking')
        hold on
        plot3(WUx,WUy,WUz,'*r','DisplayName','walking upstairs')
        plot3(WDx,WDy,WDz,'*b','DisplayName','walking downstairs')
        plot3(SITx,SITy,SITz,'oc','DisplayName','sitting')
        plot3(STANDx,STANDy,STANDz,'om','DisplayName','sitting')
        plot3(LAYx,LAYy,LAYz,'oy','DisplayName','laying')
        plot3(STANDSITx,STANDSITy,STANDSITz,'+','DisplayName','stand - sit')
        plot3(STANDLIEx,STANDLIEy,STANDLIEz,'+','DisplayName','stand - lie')
        plot3(SITSTANDx,SITSTANDy,SITSTANDz,'+','DisplayName','sit - stant')
        plot3(SITLIEx,SITLIEy,SITLIEz,'+','DisplayName','sit - lie')
        plot3(LIESITx,LIESITy,LIESITz,'+','DisplayName','lie- sit')
        plot3( LIESTANDx, LIESTANDy, LIESTANDz,'+','DisplayName','lie - stand')
        xlabel('ACC_X')
        ylabel('ACC_Y')
        zlabel('ACC_Z')
        legend show
        hold off
    
end
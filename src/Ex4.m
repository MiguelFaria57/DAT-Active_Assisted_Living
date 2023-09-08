function Ex4()
%%
%Ex_4.1
% Function in the file 'STFT.m'

%%
%Ex_4.2
    load dataset;
    
    for n = 1 : 1%numel(Exp)
        e = n; % current experiment
        u = ceil(e/2); % current user
        STFT(e, u, 2.56, 1.28); % calculate STFT 
    end
end
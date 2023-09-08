function STFT(e, u, frame, overlap)
    load dataset;
    file = sprintf('datasetAcc_exp%s_user%s.mat', Exp{e}, User{u});
    load(file);
   
    figure;
    
    Tframe = frame; % window size
    Toverlap = overlap; % window overlap
    Nframe = round(Tframe*Fs); % number of samples
    Noverlap = round(Toverlap*Fs); % number of overlaped samples

    h = hamming(Nframe); % hamming window

    if mod(Nframe, 2)==0
        f_frame = -Fs/2:Fs/Nframe:Fs/2-Fs/Nframe;
    else 
        f_frame = -Fs/2+Fs/(2*Nframe):Fs/Nframe:Fs/2-Fs/(2*Nframe);
    end

    f_relev = [];
    nframes = 0;
    tframes = []; 

    x = data(:,3); % get activity data of Z axis
    N = numel(x);

    for ii = 1:Nframe-Noverlap:N-Nframe+1
        % aply window
        x_frame = x(ii:ii+Nframe-1).*h;

        % get magnitude
        m_X_frame = abs(fftshift(fft(x_frame)));

        % gat max magnitude
        m_X_frame_max = max(m_X_frame);

        % find index of max magnitude
        ind = find(abs(m_X_frame-m_X_frame_max)<0.1);

        % find the frequency correspondent to the max magnitude
        f_relev = [f_relev, f_frame(ind(end))];

        nframes = nframes+1;
        
        t_frame = t(ii:ii+Nframe-1);
        tframes = [tframes, t_frame(round(Nframe/2)+1)];

    end

    subplot(2, 1, 1);
    plot(tframes./60, f_relev, 'ro')
    xlabel('Time (min)');
    yl = sprintf('%s\nFrequency (Hz)', sensors{3});
    ylabel(yl);
    titulo = sprintf('Exp%s User%s - STFT', Exp{e}, User{u});
    sgtitle(titulo);

    subplot(2, 1, 2);
    spectrogram(x,Nframe,Noverlap,[],Fs,'yaxis')
end 
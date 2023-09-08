function windowTesting(x, i)
    load dataset;

    n = i*5-4;
    n_plots = 3;
    
    N = numel(x);
    if (mod(N,2)==0)
        f = -Fs/2:Fs/N:Fs/2-Fs/N;
    else
        f = -Fs/2+Fs/(2*N):Fs/N:Fs/2-Fs/(2*N);
    end

    % normal DFT
    subplot(n_plots, 5, n);
    X = fftshift(fft(detrend(x)));
    plot(f, abs(X));
    title('Normal DFT');
    xlabel('Frequency (Hz)');
    ylabel(sensors{i});
    % rectangular window
    subplot(n_plots, 5, n+1);
    window_rect = rectwin(numel(x));
    X = fftshift(fft(detrend(x).*window_rect));
    plot(f, abs(X));
    title('Rectengular Window');
    xlabel('Frequency (Hz)');
    ylabel(sensors{i});
    % hamming window
    subplot(n_plots, 5, n+2);
    window_ham = hamming(numel(x));
    X = fftshift(fft(detrend(x).*window_ham));
    plot(f, abs(X));
    title('Hamming Window');
    xlabel('Frequency (Hz)');
    ylabel(sensors{i});
    % blackman window
    subplot(n_plots, 5, n+3);
    window_blk = blackman(numel(x));
    X = fftshift(fft(detrend(x).*window_blk));
    plot(f, abs(X));
    title('Blackman Window');
    xlabel('Frequency (Hz)');
    ylabel(sensors{i});
    % gaussian window
    subplot(n_plots, 5, n+4);
    window_gss = gausswin(numel(x));
    X = fftshift(fft(detrend(x).*window_gss));
    plot(f, abs(X));
    title('Gaussian Window');
    xlabel('Frequency (Hz)');
    ylabel(sensors{i});
    
    % analizing all windows in X axis as an example
    if i == 1
        wvt = wvtool(window_rect, window_ham, window_blk, window_gss);
        legend(wvt.CurrentAxes,'Rectangular','Hamming', 'Blackman', 'Gaussian');
        
        w_rect = wvtool(window_rect);
        legend(w_rect.CurrentAxes,'Rectangular')
        w_ham = wvtool(window_ham);
        legend(w_ham.CurrentAxes,'Hamming')
        w_blk = wvtool(window_blk);
        legend(w_blk.CurrentAxes,'Blackman')
        w_gss = wvtool(window_gss);
        legend(w_gss.CurrentAxes,'Gaussian')
    end
end
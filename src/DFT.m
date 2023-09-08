function DFT(e, u, x, i)
    load dataset;
    file = sprintf('datasetAcc_exp%s_user%s.mat', Exp{e}, User{u});
    load(file);
    
    N = numel(x);
    if (mod(N,2)==0)
        f = -Fs/2:Fs/N:Fs/2-Fs/N;
    else
        f = -Fs/2+Fs/(2*N):Fs/N:Fs/2-Fs/(2*N);
    end
    
    window_ham = hamming(numel(x));
    X = fftshift(fft(detrend(x).*window_ham));
    plot(f, abs(X));
    title('Hamming Window');
    xlabel('Frequency (Hz)');
    ylabel(sensors{i});
end
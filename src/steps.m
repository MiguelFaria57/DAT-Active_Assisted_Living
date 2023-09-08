function spm = steps(x)
    load dataset

    N = numel(x);
    if (mod(N,2)==0)
        f = -Fs/2:Fs/N:Fs/2-Fs/N;
    else
        f = -Fs/2+Fs/(2*N):Fs/N:Fs/2-Fs/(2*N);
    end
    
    X = fftshift(fft(detrend(x)));
    m = 0.7*max(abs(X));
    [pks, locs] = findpeaks(abs(X), 'MinPeakHeight', m);
    f_relev = f(locs);
    f_relev = f_relev(f_relev>0);
    
    spm = mean(f_relev)*60;
end
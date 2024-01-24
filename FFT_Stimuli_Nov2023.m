%% Run Hilbert transform to get the instantaneous amplitude
cd('D:\Erica\Infant_Rhythm_3tempos\Matlab_Analysis')

[signal, Fs] = audioread('PianoE_32s.mp3');

signal_envelope = abs(hilbert(signal));
% signal_envelope_dup = abs(hilbert(signal_dup));
% signal_envelope_trp = abs(hilbert(signal_trp));

T = 1/Fs;
len = length(signal_envelope);
signal_envelope = signal_envelope(1:(32*Fs));
signal_freq = fft(signal_envelope); 

% len_d = length(signal_envelope_dup);
% signal_envelope_dup = signal_envelope_dup(1:(32*Fs));
% signal_freq_dup = fft(signal_envelope_dup); 

% len_t = length(signal_envelope_trp);
% signal_envelope_trp = signal_envelope_trp(1:(32*Fs));
% signal_freq_trp = fft(signal_envelope_trp); 

% Compute the two-sided spectrum P2. Then compute the single-sided spectrum
% P1 based on P2 and the even-valued signal length L
P2 = abs(signal_freq/len);
P1 = P2(1:len/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(len/2))/len;

% P2_d = abs(signal_freq_dup/len_d);
% P1_d = P2_d(1:len_d/2+1);
% P1_d(2:end-1) = 2*P1_d(2:end-1);
% f_d = Fs*(0:(len_d/2))/len_d;
% 
% P2_t = abs(signal_freq_trp/len_t);
% P1_t = P2_t(1:len_t/2+1);
% P1_t(2:end-1) = 2*P1_t(2:end-1);
% f_t = Fs*(0:(len_t/2))/len_t;

for x = 1:length(f)
    if round(f(x),1) == 4.0
        break
    end
end

f_index = [1:x];
figure
plot(f(f_index),P1(f_index))
ylim([0 0.08]);
% 
% for x = 1:length(f_d)
%     if round(f_d(x),1) == 4.0
%         break
%     end
% end
% 
% f_d_index = [1:x];
% figure
% plot(f_d(f_d_index),P1_d(f_d_index))
% ylim([0 0.12]);
% hold on
% 
% for x = 1:length(f_t)
%     if round(f_t(x),1) == 4.0
%         break
%     end
% end
% 
% f_t_index = [1:x];
% plot(f_t(f_t_index),P1_t(f_t_index))
%% Run the FFT on the stimuli averaged
[signal1, Fs] = audioread('PianoA_32s.mp3');
[signal2, Fs] = audioread('PianoC_32s.mp3');
[signal3, Fs] = audioread('PianoE_32s.mp3');

signals_cat = cat(3,signal1, signal2, signal3);
average_signal = mean(signals_cat,3);
signal_envelope = abs(hilbert(average_signal));

T = 1/Fs;
len = length(signal_envelope);
signal_envelope = signal_envelope(1:(32*Fs));
signal_freq = fft(signal_envelope); 
% Compute the two-sided spectrum P2. Then compute the single-sided spectrum
% P1 based on P2 and the even-valued signal length L
P2 = abs(signal_freq/len);
P1 = P2(1:len/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(len/2))/len; %not sure about this...
% f = 0:0.03472:4; %frequency resolution used for the baby freq analysis.
for x = 1:length(f)
    if round(f(x),1) == 4.0
        break
    end
end
f_index = [1:x];
figure
plot(f(f_index),P1(f_index))
% ylim([0,0.08]);
xlim([0.1,4])
% title('Single-Sided Amplitude Spectrum of average')


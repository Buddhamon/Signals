% set up my time vector
fsampling = 100;
t = 0:1/fsampling:2*pi;

f1 = 2;
f2 = 5;
x1 = sin(2*pi*f1*t);
x2 = sin(2*pi*f2*t);
x = x1 + x2;
X = fft(x);
x_noisy = x1 + x2 + 0.5*randn(size(t));
X_noisy = fft(x_noisy);
omega = ((0:length(X_noisy) - 1)/length(X_noisy))*fsampling;

for order = 2:3:16
      
    fig = figure;
    set(fig, 'Position', [100 100 1366 768]); % sets size of figure; 1366x768
    
    filtered_x = medfilt1(x_noisy, order);
    X_filtered = fft(filtered_x);
    subplot(2,1,1);
    hold on;
    plot(t, x_noisy, 'DisplayName', 'Noisy Data', 'Color', [0.5 0.5 0.5], 'LineStyle', ':');
    plot(t, filtered_x, 'DisplayName', 'Filtered Data');
    plot(t, x, 'DisplayName', 'Clean Data', 'Color', 'g');
    err = immse(x, filtered_x);
    hold off;
    xlim([0,2*pi]);
    xticks([0:pi/2:2*pi])
    xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
    ylim([-2.5,2.5]);
    xlabel('t');
    ylabel('x(t)');
    legend('show');
    title(sprintf('Medfilt1(Order=%d) vs Clean Signal (Time Domain): Error=%f', order, err))
    
    subplot(2,1,2);
    hold on;
    plot(omega, abs(X_noisy), 'DisplayName', 'Noisy Data', 'Color', [0.5 0.5 0.5], 'LineStyle', ':');
    plot(omega, abs(X_filtered), 'DisplayName', 'Filtered Data');
    plot(omega, abs(X), 'DisplayName', 'Clean Data', 'Color', 'g');
    hold off
    xlabel('\omega');
    ylabel('X(\omega)');
    title(sprintf('Medfilt1(Order=%d) vs Clean Signal (Frequency Domain)', order));
    legend('show')
    
    saveas(fig, sprintf('medfilt_order_%d', order), 'png')
end
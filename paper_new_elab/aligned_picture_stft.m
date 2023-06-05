%% Matlab_pspectrum

dim_fontb = 20;
dim_font = 30;

if exist('id_plot', 'var') == 0
	id_plot = 1;
end

accx = turtle2_turchia_dive.big_dive.homing(28).accx;
accy = turtle2_turchia_dive.big_dive.homing(28).accy;
accz = turtle2_turchia_dive.big_dive.homing(28).accz;
depth = turtle2_turchia_dive.big_dive.homing(28).depth;
t_fft = turtle2_turchia_dive.big_dive.homing(28).datatime;
odba = turtle2_turchia_dive.big_dive.homing(28).ODBA;

%%

mean_odba = mean(odba, 'all');
fh2 = figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ': ODBA'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
sfh3 = subplot(2,1,1,'Parent',fh2);
plot(t_fft, odba, 'DisplayName', 'ODBA');
hold on
plot(t_fft, mean_odba.*ones(size(odba, 1), size(odba, 2)));
set(gca,'FontSize', dim_fontb)
grid on;
axis tight;
sfh4 = subplot(2,1,2,'Parent',fh2);
plot(t_fft, depth, 'DisplayName', 'Depth');
grid on;
axis tight
xlabel('time','FontSize', dim_fontb)
ylabel('Depth (m)','FontSize', dim_fontb)
legend('Location', 'best','FontSize', dim_fontb)
set(gca,'FontSize', dim_fontb)
sgtitle([name_turtle, ' ', motion_type, ': ODBA'],'FontSize', dim_font)

%%

[P_accx, F_accx, T_accx] = pspectrum(accx, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);

figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accx'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
subplot(2, 1, 1)
pspectrum(accx, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
ylim([0, 2]);
set(gca,'FontSize', dim_fontb)
subplot(2, 1, 2)
plot(t_fft, depth, 'DisplayName', 'Depth');
grid on;
axis tight
xlabel('time','FontSize', dim_fontb)
ylabel('Depth (m)','FontSize', dim_fontb)
legend('Location', 'best','FontSize', dim_fontb)
set(gca,'FontSize', dim_fontb)
sgtitle([name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accx'],'FontSize', dim_font)

%%
fh2 = figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accx'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
sfh3 = subplot(2,1,1,'Parent',fh2);
pspectrum(accx, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
ylim([0, 2]);
set(gca,'FontSize', dim_fontb)
sfh4 = subplot(2,1,2,'Parent',fh2);
plot(t_fft, depth, 'DisplayName', 'Depth');
sfh4.Position = sfh4.Position + [0 0 -0.038 0];
grid on;
axis tight
xlabel('time','FontSize', dim_fontb)
ylabel('Depth (m)','FontSize', dim_fontb)
legend('Location', 'best','FontSize', dim_fontb)
set(gca,'FontSize', dim_fontb)
sgtitle([name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accx'],'FontSize', dim_font)

%%
[P_accy, F_accy, T_accy] = pspectrum(accy, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);

figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accy'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
subplot(2, 1, 1)
pspectrum(accy, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
ylim([0, 2]);
set(gca,'FontSize', dim_fontb)
subplot(2, 1, 2)
plot(t_fft, depth, 'DisplayName', 'Depth');
grid on;
axis tight
xlabel('time','FontSize', dim_fontb)
ylabel('Depth (m)','FontSize', dim_fontb)
legend('Location', 'best','FontSize', dim_fontb)
set(gca,'FontSize', dim_fontb)
sgtitle([name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accy'],'FontSize', dim_font)

%% 

fh2 = figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accy'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
sfh3 = subplot(2,1,1,'Parent',fh2);
pspectrum(accy, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
ylim([0, 2]);
set(gca,'FontSize', dim_fontb)
sfh4 = subplot(2,1,2,'Parent',fh2);
plot(t_fft, depth, 'DisplayName', 'Depth');
sfh4.Position = sfh4.Position + [0 0 -0.038 0];
grid on;
axis tight
xlabel('time','FontSize', dim_fontb)
ylabel('Depth (m)','FontSize', dim_fontb)
legend('Location', 'best','FontSize', dim_fontb)
set(gca,'FontSize', dim_fontb)
sgtitle([name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accy'],'FontSize', dim_font)

%%

[P_accz, F_accz, T_accz] = pspectrum(accz, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);

figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accz'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
subplot(2, 1, 1)
pspectrum(accz, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
ylim([0, 2]);
set(gca,'FontSize', dim_fontb)
subplot(2, 1, 2)
plot(t_fft, depth, 'DisplayName', 'Depth');
grid on;
axis tight
xlabel('time','FontSize', dim_fontb)
ylabel('Depth (m)','FontSize', dim_fontb)
legend('Location', 'best','FontSize', dim_fontb)
set(gca,'FontSize', dim_fontb)
sgtitle([name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accz'],'FontSize', dim_font)

%%

fh2 = figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accz'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
sfh3 = subplot(2,1,1,'Parent',fh2);
pspectrum(accz, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
ylim([0, 2]);
set(gca,'FontSize', dim_fontb)
sfh4 = subplot(2,1,2,'Parent',fh2);
plot(t_fft, depth, 'DisplayName', 'Depth');
sfh4.Position = sfh4.Position + [0 0 -0.038 0];
grid on;
axis tight
xlabel('time','FontSize', dim_fontb)
ylabel('Depth (m)','FontSize', dim_fontb)
legend('Location', 'best','FontSize', dim_fontb)
set(gca,'FontSize', dim_fontb)
sgtitle([name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accz'],'FontSize', dim_font)

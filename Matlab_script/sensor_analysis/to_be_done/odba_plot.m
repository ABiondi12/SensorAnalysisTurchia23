%% ODBA: plot (commented)

% if exist('id_plot', 'var') == 0
% 	id_plot = 1;
% end
% dim_font = 30;
% dim_fontb = 20;
% % homing: mean ODBA for each dive and shallow section
% figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' homing: mean ODBA for each big dive section'], 'NumberTitle','off'); id_plot = id_plot + 1;
% clf
% subplot(3, 1, 1)
% plot(mean_ODBA_dive_h, 'Linewidth', 1)
% grid on
% box on
% ylabel('mean ODBA')
% legend('big dive', 'Location', 'best', 'FontSize', dim_fontb)
% set(gca,'FontSize', dim_fontb)
% title('mean ODBA for each big dive section')
% 
% subplot(3, 1, 2)
% plot(mean_ODBA_sdive_h, 'Linewidth', 1)
% grid on
% box on
% ylabel('mean ODBA')
% legend('shallow dive', 'Location', 'best', 'FontSize', dim_fontb)
% set(gca,'FontSize', dim_fontb)
% title('mean ODBA for each shallow dive section')
% 
% subplot(3, 1, 3)
% plot(mean_ODBA_surf_h, 'Linewidth', 1)
% grid on
% box on
% ylabel('mean ODBA')
% legend('sub surface', 'Location', 'best', 'FontSize', dim_fontb)
% set(gca,'FontSize', dim_fontb)
% title('mean ODBA for each sub surface section')
% 
% sgtitle([name_turtle, ' homing: mean ODBA for each section'],'FontSize', dim_font)
% %%%%%%%
% 
% figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' homing: mean ODBA for each big dive section'], 'NumberTitle','off'); id_plot = id_plot + 1;
% clf
% plot(mean_ODBA_dive_h, 'Linewidth', 1)
% grid on
% box on
% legend('big dive', 'Location', 'best', 'FontSize', dim_fontb)
% set(gca,'FontSize', dim_font)
% title([name_turtle, ' homing: mean ODBA for each big dive section'])
% %%%%%%%
% figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' homing: mean ODBA for each shallow dive section'], 'NumberTitle','off'); id_plot = id_plot + 1;
% clf
% plot(mean_ODBA_sdive_h, 'Linewidth', 1)
% grid on
% box on
% legend('shallow dive', 'Location', 'best', 'FontSize', dim_fontb)
% set(gca,'FontSize', dim_font)
% title([name_turtle, ' homing: mean ODBA for each shallow dive section'])
% %%%%%%%
% figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' homing: mean ODBA and ODBA (din) for each sub surface section'], 'NumberTitle','off'); id_plot = id_plot + 1;
% clf
% plot(mean_ODBA_surf_h, 'Linewidth', 1)
% hold on
% plot(mean_ODBA_surf_h_din, 'Linewidth', 1)
% grid on
% box on
% legend('sub surface', 'sub surface din', 'Location', 'best','FontSize', dim_fontb)
% set(gca,'FontSize', dim_font)
% title([name_turtle, ' homing: mean ODBA and ODBA (din) for each sub surface section'])
% % homing: mean ODBA for big dives' phases
% figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' homing: mean ODBA for dives'' phases'], 'NumberTitle','off'); id_plot = id_plot + 1;
% clf
% plot(mean_ODBA_dive_h_disc, 'Linewidth', 1)
% hold on
% plot(mean_ODBA_dive_h_asc, 'Linewidth', 1)
% plot(mean_ODBA_dive_h_bott, 'Linewidth', 1)
% grid on
% box on
% legend('Descent', 'Ascent', 'Bottom', 'Location', 'best', 'FontSize', dim_fontb)
% set(gca,'FontSize', dim_font)
% title([name_turtle, ' homing: mean ODBA for dives'' phases'])
%% homing: mean pitch for dives' phases (commented)

% if isempty(turtle_dive.big_dive.homing(1).pitch) == 0
% 	abs_mean_pitch_dive_h_disc = abs(mean_pitch_dive_h_disc);
% 	figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' homing: mean pitch for dives'' phases'], 'NumberTitle','off'); id_plot = id_plot + 1;
% 	clf
% 	plot(mean_pitch_dive_h_disc, 'Linewidth', 1)
% 	hold on
% 	plot(abs_mean_pitch_dive_h_disc, 'Linewidth', 1)
% 	plot(mean_pitch_dive_h_asc, 'Linewidth', 1)
% 	plot(mean_pitch_dive_h_bott, 'Linewidth', 1)
% 	grid on
% 	box on
% 	legend(['dive_h dis pitch'; '|dv|_h dis pitch'; 'dive_h asc pitch'; 'dive_h bot pitch'], 'Location', 'best', 'FontSize', dim_fontb)
% 	set(gca,'FontSize', dim_font)
% 	title([name_turtle, ' homing: mean pitch for dives'' phases'])
% end


% ODBA and VeDBA over acc are computed using dynamic acceleration, while
% when they're computed over din acc it means that, talking about sub
% surface sections, din_no waves are used instead of din.

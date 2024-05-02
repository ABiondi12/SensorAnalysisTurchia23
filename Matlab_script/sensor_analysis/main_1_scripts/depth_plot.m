%% Depth plot
% This script is demanded to handle the plot of the depth profile

%% threshold definition
l		= size(datetime_depth, 1);
thr1	= -1.*ones(l,1);	% 1m = threshold between subsurface and shallow dive
thr2	= -5.*ones(l,1);	% 5m = threshold between shallow dive and big dive

%% plot
figure('Name', ['figure ', num2str(id_plot),', depth profile and ranges'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_depth, depth);
hold on
plot(datetime_depth, thr1, 'Linewidth', 1.5);
plot(datetime_depth, thr2, 'Linewidth', 1.5);
grid on
box on
axis tight
xlabel('time','FontSize', dim_font)
ylabel('depth (m)','FontSize', dim_font)
legend('depth', 'sub surface-shallow dive', 'shallow dive-big dive','Location', 'best', 'FontSize', dim_font);
set(gca,'FontSize', dim_font)
title('Depth profile and ranges')

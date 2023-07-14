% mag_calibration_plot

% plot: Uncalibrated vs Calibrated mf data best fitting (ellips - sphere)
%	ellips - Uncalibrated mf
%	sphere - Calibrated mf
figure('Name', ['figure ', num2str(id_plot),', uncalibrated vs calibrated magnetic field fitting'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot3(ellips_fit(:, 1), ellips_fit(:, 2), ellips_fit(:, 3), 'LineStyle','none','Marker', 'o','MarkerSize',1,'MarkerEdgeColor','g', 'MarkerFaceColor','g')
hold on
plot3(sphere_fit(:, 1), sphere_fit(:, 2), sphere_fit(:, 3), 'LineStyle','none','Marker', 'o','MarkerSize',1, 'MarkerEdgeColor','r', 'MarkerFaceColor','r')
grid on
box on
axis equal
xlabel('x uT','FontSize', 20)
ylabel('y uT','FontSize', 20)
zlabel('z uT','FontSize', 20)
legend('Uncalibrated best fitting', 'Calibrated best fitting','Location', 'southeast','FontSize', 20)
set(gca,'FontSize', 20)
title("Uncalibrated vs Calibrated" + newline + "magnetic field fitting")
hold off

% plot: Uncalibrated mf data and best fitting ellips
figure('Name', ['figure ', num2str(id_plot),', uncalibrated magnetic field fitting'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot3(ellips_fit(:, 1), ellips_fit(:, 2), ellips_fit(:, 3), 'LineStyle','none','Marker', 'o','MarkerSize',1,'MarkerEdgeColor','g', 'MarkerFaceColor','g')
hold on
plot3(mag_reor(:, 1), mag_reor(:, 2), mag_reor(:, 3), 'LineStyle','none','Marker', 'o','MarkerSize', 3)
grid on
box on
axis equal
xlabel('x uT','FontSize', 20)
ylabel('y uT','FontSize', 20)
zlabel('z uT','FontSize', 20)
legend('Uncalibrated best fitting', 'magnetic field','Location', 'southeast','FontSize', 20)
set(gca,'FontSize', 20)
title("Uncalibrated magnetic field fitting")
hold off

% plot: Calibrated mf data and best fitting sphere
figure('Name', ['figure ', num2str(id_plot),', calibrated magnetic field fitting'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot3(sphere_fit(:, 1), sphere_fit(:, 2), sphere_fit(:, 3), 'LineStyle','none','Marker', 'o','MarkerSize',1,'MarkerEdgeColor','g', 'MarkerFaceColor','g')
hold on
plot3(mag_postcalib(:, 1), mag_postcalib(:, 2), mag_postcalib(:, 3), 'LineStyle','none','Marker', 'o','MarkerSize', 3)
grid on
box on
axis equal
xlabel('x uT','FontSize', 20)
ylabel('y uT','FontSize', 20)
zlabel('z uT','FontSize', 20)
legend('Calibrated best fitting', 'Calibrated magnetic field','Location', 'southeast','FontSize', 20)
set(gca,'FontSize', 20)
title("Calibrated magnetic field fitting")
hold off
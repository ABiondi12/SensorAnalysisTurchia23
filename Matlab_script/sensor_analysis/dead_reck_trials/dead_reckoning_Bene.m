% dead reckoning benedetta
gps_fix = readtable('Erica_gps.csv');

datetime_gps = table2array(gps_fix(:, 1));
lla = strrep(table2array(gps_fix(:, 2:4)), ',', '.');

lla_plt = str2double(lla);
release_gps = [str2double(lla(1, 1)), str2double(lla(1, 2))];

dist= 1.65/3600; % km percorsi in 1 secondo
R=6371; % raggio Terra
angular_displ = dist/R;

lat= zeros(length(yaw_m_calib), 1); % lat punto inizio
lon= zeros(length(yaw_m_calib), 1); % long punto inizio


lat(1)= release_gps(1); % lat punto inizio
lon(1)= release_gps(2); % long punto inizio


for i = 2:(length(yaw_m_calib))
  lat1= lat(i-1);
  lon1= lon(i-1);
  brng= yaw_m_calib(i-1);
  
   
  % Trasforma in radianti
  lat1 = lat1 * pi / 180;
  lon1 = lon1 * pi / 180;
  brng = brng * pi / 180;
  
  % Calculate φ2 (lat finale)
  phi2 = asin(sin(lat1) * cos(angular_displ) + cos(lat1) * sin(angular_displ) * cos(brng));
  % Calculate λ2 (long finale)
  lambda2 = lon1 + atan2(sin(brng) * sin(angular_displ) * cos(lat1), cos(angular_displ) - sin(lat1) * sin(phi2));
  
  
  % Convert radians back to degrees

  lat(i)= phi2 * 180 / pi;
  lon(i) = lambda2 * 180 / pi;
end

%% plot

    figure('Name', ['figure ', num2str(id_plot),', ll dead reckoning vs gps fixes'], 'NumberTitle','off'); id_plot = id_plot + 1;
    clf
    plot(lat, lon, '*', 'MarkerSize', 2)
    hold on
    plot(lla_plt(:, 1), lla_plt(:, 2), '>', 'MarkerSize', 2)
    
    grid on
    box on
    axis tight
    xlabel('lat','FontSize', dim_font)
    ylabel('long','FontSize', dim_font)
    legend('dr', 'gps','FontSize', dim_font, 'Location', 'best')
    set(gca,'FontSize', dim_font)
    title('dead reckoning')

    figure('Name', ['figure ', num2str(id_plot),', ll dead reckoning'], 'NumberTitle','off'); id_plot = id_plot + 1;
    clf
    plot(lat, lon, '*', 'MarkerSize', 2)
    
    grid on
    box on
    axis tight
    xlabel('lat','FontSize', dim_font)
    ylabel('long','FontSize', dim_font)
    set(gca,'FontSize', dim_font)
    title('dead reckoning')
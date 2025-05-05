% yaw_circling_research

%% count yaw circling
yaw_circling_plot = 1;

% flag and initial values
in_the_circling = 0;
start_new_research = 1;
one_completed = 0;
least_half = 0;
jump = 0;
count_yaw = 0;
count_change = 0;
start_circling_eval_id = 2;

% tunable threshold
max_yaw_step = 45;                          % tunable
err_deg = 30;                               % tunable
wrap_correction_angle = 360 - max_yaw_step;                % tunable
th_angle = 160;                             % tunable
min_yaw_point = round(360/max_yaw_step);    % tunable
tolerate_yaw_change_num = 20;                % tunable

% variables
time_start_circling = [];
time_end_circling = [];
count_circling = 0;


for i = 2:length(yaw_g_calib)

    if in_the_circling == 1
        yaw_prev = yaw_g_calib(i-1);
        yaw_current = yaw_g_calib(i);

        if abs(yaw_current - yaw_prev) < wrap_correction_angle
            sign_curr = sign(yaw_current - yaw_prev);
        else
            sign_curr = -sign(yaw_current - yaw_prev);
            jump = 1;
        end

        % if sign_curr == sign_prev || sign_curr == 0
        % if (sign_curr == sign_prev && sign_curr == sign_start)

        if (sign_curr == sign_prev && sign_curr == sign_start)
            coherent_sign = 1;
        elseif count_change < tolerate_yaw_change_num
            count_change = count_change + 1;
            coherent_sign = 1;
            sign_curr = - sign_curr;
        else
            coherent_sign = 0;
        end

        if coherent_sign == 1 || sign_curr == 0
            fprintf('in the circling \n')
            count_yaw = count_yaw + 1;
            sign_prev = sign_curr;

            if abs(yaw_current - yaw_start) >= th_angle && least_half == 0
                least_half = 1;
                fprintf('least half \n')
            end

            % if jump == 1 && abs(yaw_current - yaw_start) < err_deg && least_half == 1 && one_completed == 0
            if abs(yaw_current - yaw_start) < err_deg && least_half == 1 && one_completed == 0
                one_completed = 1;
                fprintf('one completed \n')
            end

        else

            if jump == 1 && least_half == 1 && count_yaw > min_yaw_point && (abs(yaw_current - yaw_start) < err_deg || one_completed == 1)
            % if least_half == 1 && count_yaw > min_yaw_point && (abs(yaw_current - yaw_start) < err_deg || one_completed == 1)
                count_circling = count_circling+1;
                time_start_circling = [time_start_circling, temp_start_time];
                time_end_circling = [time_end_circling, datetime_mag(i)];
            end

            jump = 0;
            one_completed = 0;
            in_the_circling = 0;
            least_half = 0;
            count_yaw = 0;
            start_new_research = 1;
            start_circling_eval_id = i;
        end
    end

    if in_the_circling == 0 && start_new_research == 1 && start_circling_eval_id < length(yaw_g_calib)
        yaw_start = yaw_g_calib(start_circling_eval_id);
        temp_start_time = datetime_mag(start_circling_eval_id);

        if abs(yaw_g_calib(start_circling_eval_id)-yaw_g_calib(start_circling_eval_id-1)) < wrap_correction_angle
            sign_start = sign(yaw_g_calib(start_circling_eval_id)-yaw_g_calib(start_circling_eval_id-1));
            jump = 0;
        else
            sign_start = -sign(yaw_g_calib(start_circling_eval_id)-yaw_g_calib(start_circling_eval_id-1));
            jump = 1;
        end

        % sign_start = sign(yaw_g_calib(start_circling_eval_id+1)-yaw_g_calib(start_circling_eval_id));
        sign_prev = sign_start;
        in_the_circling = 1;
        start_new_research = 0;
        one_completed = 0;
        least_half = 0;
        count_yaw = 0;
    end
end

if yaw_circling_plot
    %% plot preparation
    start_point = zeros(length(datetime_mag), 1);
    end_point = zeros(length(datetime_mag), 1);
    count_time_start = 1;
    count_time_end = 1;

    if isempty(time_end_circling) == 0
        for ii = 1:length(datetime_mag)
            if datetime_mag(ii) == time_end_circling(count_time_end)
                end_point(ii) = 100;
                if count_time_end < length(time_end_circling)
                    count_time_end = count_time_end+1;
                end
            end
        end
    end

    if isempty(time_start_circling) == 0
        for ii = 1:length(datetime_mag)
            if datetime_mag(ii) == time_start_circling(count_time_start)
                start_point(ii) = 100;
                if count_time_start < length(time_start_circling)
                    count_time_start = count_time_start+1;
                end
            end
        end
    end
    %% Yaw reoriented w.r.t. geographic North

    if isempty(time_start_circling) == 0 && isempty(time_end_circling) == 0

        yaw_g_plot_wrap = rad2deg(wrapTo2Pi(deg2rad(yaw_g_plot)));
    
        figure('Name', ['figure ', num2str(id_plot),', Yaw angle w.r.t. geographic North'], 'NumberTitle','off'); id_plot = id_plot + 1;
        clf
        plot(datetime_mag, yaw_g_plot_wrap, '*', 'MarkerSize', 2)
        hold on
        plot(datetime_mag, start_point, '>', 'MarkerSize', 10)
        plot(datetime_mag, end_point, 'o', 'MarkerSize', 10)
        
        grid on
        box on
        axis tight
        xlabel('time','FontSize', dim_font)
        ylabel('angle (deg)','FontSize', dim_font)
        legend('Yaw','FontSize', dim_font, 'Location', 'best')
        set(gca,'FontSize', dim_font)
        title('Yaw angle w.r.t. geographic North')
    else
       
        yaw_g_plot_wrap = rad2deg(wrapTo2Pi(deg2rad(yaw_g_plot)));
    
        figure('Name', ['figure ', num2str(id_plot),', Yaw angle w.r.t. geographic North'], 'NumberTitle','off'); id_plot = id_plot + 1;
        clf
        plot(datetime_mag, yaw_g_plot_wrap, '*', 'MarkerSize', 2)
                
        grid on
        box on
        axis tight
        xlabel('time','FontSize', dim_font)
        ylabel('angle (deg)','FontSize', dim_font)
        legend('Yaw','FontSize', dim_font, 'Location', 'best')
        set(gca,'FontSize', dim_font)
        title('Yaw angle w.r.t. geographic North')        
    end

    %% Yaw reoriented w.r.t. geographic North

%     yaw_g_plot_wrap = rad2deg(wrapTo2Pi(deg2rad(yaw_g_plot)));
% 
%     figure('Name', ['figure ', num2str(id_plot),', Yaw angle w.r.t. geographic North'], 'NumberTitle','off'); id_plot = id_plot + 1;
%     clf
%     plot(datetime_mag, yaw_g_plot_wrap, '*', 'MarkerSize', 2)
%     grid on
%     box on
%     axis tight
%     xlabel('time','FontSize', dim_font)
%     ylabel('angle (deg)','FontSize', dim_font)
%     legend('Yaw','FontSize', dim_font, 'Location', 'best')
%     set(gca,'FontSize', dim_font)
%     title('Yaw angle w.r.t. geographic North')

end
% main_2_ypr
% In this script there are evaluated:
%
%	1_ angle between local magnetic field and acceleration vectors (with
%	the hypothesis that only gravity field occurs, because turtles movement
%	are much slow with respect to gravity magnitude, so we expect their
%	proper accelerations along 3 axis will be negligible w.r.t. g).
%
%	2_ Yaw Pitch and Roll angles in order to evaluate turtles orientation.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	UPDATE: use filtered values of acc measures in order to keep only low
%	frequency components, corresponding to static acceleration (gravity)

%% init

main_num = 2;

existing_dataset_load

if exist('main_num', 'var') == 0
	main_num = 2;
end

if new_ypr_dataset == 1 || ov_to_do == 0
	
	%% mf info
	mf_info
	
	%% angle g-mf evaluation
	angle_g_mf_script

	%% YPR computation
	ypr_comp_main
	
	%% Plot script
	Single_Turtle_orientation_plot

	%% save date
	if exist('all_together', 'var') == 0 
		% metti qua il salvataggio dei dati intermedi prodotti e che possono
		% servire poi per le successive elaborazioni
		save_ypr_data
	end
	
else
	load_ypr_data
	fprintf('Load operation completed! \n')
end
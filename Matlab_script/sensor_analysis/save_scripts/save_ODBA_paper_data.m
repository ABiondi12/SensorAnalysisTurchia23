% save_ODBA_paper_data

% struct creation

% means ODBA struct and means VeDBA struct for a turtle (dives and
% surfs still splitted in two separate struct)
turtle_dives_ODBA_h		= struct('mean', mean_ODBA_dive_h, 'var', var_ODBA_dive_h, 'disc', mean_ODBA_dive_h_disc, 'asc', mean_ODBA_dive_h_asc, 'bott', mean_ODBA_dive_h_bott);
turtle_sdives_ODBA_h	= struct('mean', mean_ODBA_sdive_h, 'var', var_ODBA_sdive_h);
turtle_surfs_ODBA_h		= struct('mean', mean_ODBA_surf_h, 'var', var_ODBA_surf_h);

if exist('mean_pitch_dive_h_disc', 'var') && isempty(turtle_dive.big_dive.homing(1).pitch) == 0
	turtle_dives_pitch_h	= struct('mean_disc', mean_pitch_dive_h_disc, 'mean_asc', mean_pitch_dive_h_asc, 'mean_bott', mean_pitch_dive_h_bott);
	% merge together ODBA and VeDBA into a single struct (dives and
	% surfs still splitted in two separate struct)
	turtle_dives_DBA_h		= struct('ODBA',turtle_dives_ODBA_h, 'pitch', turtle_dives_pitch_h);
else
	turtle_dives_DBA_h		= struct('ODBA',turtle_dives_ODBA_h);
end

% merge together ODBA and VeDBA into a single struct (dives and
% surfs still splitted in two separate struct)
turtle_sdives_DBA_h		= struct('ODBA',turtle_sdives_ODBA_h);
turtle_surfs_DBA_h		= struct('ODBA',turtle_surfs_ODBA_h);

turtle_dives_DBA	= struct('homing', turtle_dives_DBA_h);
turtle_sdives_DBA	= struct('homing', turtle_sdives_DBA_h);
turtle_surf_DBA		=	struct('homing', turtle_surfs_DBA_h);
	
	% merge together dive and surf data
turtle_DBA			= struct('name', turtle_name, 'big_dive', turtle_dives_DBA, 'shallow_dive', turtle_sdives_DBA, 'sub_surface', turtle_surf_DBA);


new_DBA_dataset = 0;

if exist (turtle_DBA_name_paper, 'file') == 2
	fprintf([turtle_DBA_name_paper ': dive dataset exists!!! \n'])
	ov_to_do = 0;
	
	yn_ans = 0;
	while yn_ans < 1 || yn_ans > 2
		fprintf([turtle_DBA_name_paper ': do you want to overwrite it? \n'])
		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans = input('');
	end
	
	if yn_ans == 1
		ov_to_do = 1;
		fprintf([turtle_DBA_name_paper ': start overwrite \n'])
	elseif yn_ans == 2
		ov_to_do = 0;
		fprintf([turtle_DBA_name_paper ': overwrite operation aborted \n'])
	end
	
else
	fprintf([turtle_DBA_name_paper ': dataset not exists, start making it \n'])
	new_DBA_dataset = 1;
end

% if a new struct has to be created or if an old struct has to be
% overwritten:

if new_DBA_dataset == 1 || ov_to_do == 1
		turtle_DBA_paper = turtle_DBA;
		fprintf([turtle_DBA_name_paper ': saving struct \n'])
		save(turtle_DBA_name_paper, 'turtle_DBA_paper', '-v7.3');
		fprintf([turtle_DBA_name_paper, ' saved! \n'])
end

%% din version

% struct creation

% means ODBA struct and means VeDBA struct for a turtle (dives and
% surfs still splitted in two separate struct)
turtle_dives_ODBA_h_din		= struct('mean', mean_ODBA_dive_h_din, 'var', var_ODBA_dive_h_din, 'disc', mean_ODBA_dive_h_disc_din, 'asc', mean_ODBA_dive_h_asc_din, 'bott', mean_ODBA_dive_h_bott_din);
turtle_sdives_ODBA_h_din	= struct('mean', mean_ODBA_sdive_h_din, 'var', var_ODBA_sdive_h_din);
turtle_surfs_ODBA_h_din		= struct('mean', mean_ODBA_surf_h_din, 'var', var_ODBA_surf_h_din, 'mean_nw', mean_ODBA_surf_h_din_nw, 'var_nw', var_ODBA_surf_h_din_nw);

if exist('mean_pitch_dive_h_disc_din', 'var') && isempty(turtle_dive_din.big_dive.homing(1).pitch) == 0
	turtle_dives_pitch_h_din	= struct('mean_disc', mean_pitch_dive_h_disc_din, 'mean_asc', mean_pitch_dive_h_asc_din, 'mean_bott', mean_pitch_dive_h_bott_din);
	% merge together ODBA and VeDBA into a single struct (dives and
	% surfs still splitted in two separate struct)
	turtle_dives_DBA_h_din		= struct('ODBA',turtle_dives_ODBA_h_din, 'pitch', turtle_dives_pitch_h_din);
else
	turtle_dives_DBA_h_din		= struct('ODBA',turtle_dives_ODBA_h_din);
end

% merge together ODBA and VeDBA into a single struct (dives and
% surfs still splitted in two separate struct)
turtle_sdives_DBA_h_din		= struct('ODBA',turtle_sdives_ODBA_h_din);
turtle_surfs_DBA_h_din		= struct('ODBA',turtle_surfs_ODBA_h_din);

turtle_dives_DBA_din	= struct('homing', turtle_dives_DBA_h_din);
turtle_sdives_DBA_din	= struct('homing', turtle_sdives_DBA_h_din);
turtle_surf_DBA_din		=	struct('homing', turtle_surfs_DBA_h_din);
	
	% merge together dive and surf data
turtle_DBA_din			= struct('name', turtle_name, 'big_dive', turtle_dives_DBA_din, 'shallow_dive', turtle_sdives_DBA_din, 'sub_surface', turtle_surf_DBA_din);


new_DBA_dataset_din = 0;

if exist (turtle_DBA_name_paper_din, 'file') == 2
	fprintf([turtle_DBA_name_paper_din ': dive dataset exists!!! \n'])
	ov_to_do_din = 0;
	
	yn_ans_din = 0;
	while yn_ans_din < 1 || yn_ans_din > 2
		fprintf([turtle_DBA_name_paper_din ': do you want to overwrite it? \n'])
		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans_din = input('');
	end
	
	if yn_ans_din == 1
		ov_to_do_din = 1;
		fprintf([turtle_DBA_name_paper_din ': start overwrite \n'])
	elseif yn_ans_din == 2
		ov_to_do_din = 0;
		fprintf([turtle_DBA_name_paper_din ': overwrite operation aborted \n'])
	end
	
else
	fprintf([turtle_DBA_name_paper_din ': dataset not exists, start making it \n'])
	new_DBA_dataset_din = 1;
end

% if a new struct has to be created or if an old struct has to be
% overwritten:

if new_DBA_dataset_din == 1 || ov_to_do_din == 1
		turtle_DBA_paper_din = turtle_DBA_din;
		fprintf([turtle_DBA_name_paper_din ': saving struct \n'])
		save(turtle_DBA_name_paper_din, 'turtle_DBA_paper_din', '-v7.3');
		fprintf([turtle_DBA_name_paper_din, ' saved! \n'])
end
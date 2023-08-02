% turtle_info
% Script that hosts the name of the variables that will be saved.

%% name of the structs to be saved as Matlab variable files

turtle_nm = 0;
fprintf('Turtle name: \n')
fprintf('1. Melis \n')
fprintf('2. Banu \n')
fprintf('3. Fati \n')
fprintf('4. Emine \n')
fprintf('5. Sevval \n')
fprintf('6. Didar \n')
fprintf('7. Deniz \n')
fprintf('8. Elif \n')
fprintf('9. Funda \n')

while turtle_nm <= 0 || turtle_nm > 9
	turtle_nm = input('');
end

if turtle_nm == 1
	turtle_name		= "Melis";
	name_table_agm	= 'Melis_agm.csv';
	name_table_axy	= 'Melis_axy.csv';
	name_table_calib = 'Melis_agm.csv';
	turtle_dive_name		= 'turtle_dive_Melis.mat';
	turtle_dive_fft_name	= 'turtle_dive_fft_Melis.mat';
	turtle_DBA_name			= 'turtle_DBA_Melis.mat';
	turtle_DBA_name_paper	= 'turtle_DBA_paper_Melis.mat';
	turtle_freq_name		= 'turtle_freq_Melis.mat';
elseif turtle_nm == 2
	turtle_name		= "Banu";
	name_table_agm	= 'Banu_agm.csv'; 
	name_table_axy	= 'Banu_axy.csv';
	name_table_calib = 'Banu_agm.csv';
	turtle_dive_name		= 'turtle_dive_Banu.mat';
	turtle_dive_fft_name	= 'turtle_dive_fft_Banu.mat';
	turtle_DBA_name			= 'turtle_DBA_Banu.mat';
	turtle_DBA_name_paper	= 'turtle_DBA_paper_Banu.mat';
	turtle_freq_name		= 'turtle_freq_Banu.mat';
elseif turtle_nm == 3
	turtle_name		= "Fati";
	name_table_agm	= 'Fati_agm.csv'; 
	name_table_axy	= 'Fati_axy.csv';
	name_table_calib = 'Fati_agm.csv';
	turtle_dive_name		= 'turtle_dive_Fati.mat';
	turtle_dive_fft_name	= 'turtle_dive_fft_Fati.mat';
	turtle_DBA_name			= 'turtle_DBA_Fati.mat';
	turtle_DBA_name_paper	= 'turtle_DBA_paper_Fati.mat';
	turtle_freq_name		= 'turtle_freq_Fati.mat';
elseif turtle_nm == 4
	turtle_name		= "Emine";
	name_table_agm	= 'Emine_agm.csv'; 
	name_table_axy	= 'Emine_axy.csv';
	name_table_calib = 'Emine_agm.csv';
	turtle_dive_name		= 'turtle_dive_Emine.mat';
	turtle_dive_fft_name	= 'turtle_dive_fft_Emine.mat';
	turtle_DBA_name			= 'turtle_DBA_Emine.mat';
	turtle_DBA_name_paper	= 'turtle_DBA_paper_Emine.mat';
	turtle_freq_name		= 'turtle_freq_Emine.mat';
elseif turtle_nm == 5
	turtle_name		= "Sevval";
	name_table_agm	= 'Sevval_agm.csv'; 
	name_table_axy	= 'Sevval_axy.csv'; 
	name_table_calib = 'Sevval_agm.csv';
	turtle_dive_name		= 'turtle_dive_Sevval.mat';
	turtle_dive_fft_name	= 'turtle_dive_fft_Sevval.mat';
	turtle_DBA_name			= 'turtle_DBA_Sevval.mat';
	turtle_DBA_name_paper	= 'turtle_DBA_paper_Sevval.mat';
	turtle_freq_name		= 'turtle_freq_Sevval.mat';
elseif turtle_nm == 6
	turtle_name		= "Didar";
	name_table_agm	= 'Didar_agm.csv'; 
	name_table_axy	= 'Didar_axy.csv'; 
	name_table_calib = 'Didar_agm.csv';
	turtle_dive_name		= 'turtle_dive_Didar.mat';
	turtle_dive_fft_name	= 'turtle_dive_fft_Didar.mat';
	turtle_DBA_name			= 'turtle_DBA_Didar.mat';
	turtle_DBA_name_paper	= 'turtle_DBA_paper_Didar.mat';
	turtle_freq_name		= 'turtle_freq_Didar.mat';
elseif turtle_nm == 7
	turtle_name		= "Deniz";
	name_table_agm	= 'Deniz_agm.csv'; 
	name_table_axy	= 'Deniz_axy.csv'; 
	name_table_calib = 'Deniz_agm.csv';
	turtle_dive_name		= 'turtle_dive_Deniz.mat';
	turtle_dive_fft_name	= 'turtle_dive_fft_Deniz.mat';
	turtle_DBA_name			= 'turtle_DBA_Deniz.mat';
	turtle_DBA_name_paper	= 'turtle_DBA_paper_Deniz.mat';
	turtle_freq_name		= 'turtle_freq_Deniz.mat';
elseif turtle_nm == 8
	turtle_name		= "Elif";
	name_table_agm	= 'Elif_agm.csv'; 
	name_table_axy	= 'Elif_axy.csv'; 
	name_table_calib = 'Elif_agm.csv';
	turtle_dive_name		= 'turtle_dive_Elif.mat';
	turtle_dive_fft_name	= 'turtle_dive_fft_Elif.mat';
	turtle_DBA_name			= 'turtle_DBA_Elif.mat';
	turtle_DBA_name_paper	= 'turtle_DBA_paper_Elif.mat';
	turtle_freq_name		= 'turtle_freq_Elif.mat';
elseif turtle_nm == 9
	turtle_name		= "Funda";
	name_table_agm	= 'Funda_agm.csv'; 
	name_table_axy	= 'Funda_axy.csv'; 
	name_table_calib = 'Funda_agm.csv';
	turtle_dive_name		= 'turtle_dive_Funda.mat';
	turtle_dive_fft_name	= 'turtle_dive_fft_Funda.mat';
	turtle_DBA_name			= 'turtle_DBA_Funda.mat';
	turtle_DBA_name_paper	= 'turtle_DBA_paper_Funda.mat';
	turtle_freq_name		= 'turtle_freq_Funda.mat';
end

% turtle_dive_name_din = 'turtle_dive_din.mat';
% turtle_dive_fft_name_din = 'turtle_dive_fft_din.mat';
% turtle_DBA_name_din = 'turtle_DBA_din.mat';
% turtle_freq_name_din = 'turtle_freq_din.mat';

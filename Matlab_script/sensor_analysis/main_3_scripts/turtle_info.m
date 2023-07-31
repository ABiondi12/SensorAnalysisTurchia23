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
fprintf('6. Deniz \n')
fprintf('7. Elif \n')
fprintf('8. Funda \n')

while turtle_nm <= 0 || turtle_nm > 8
	turtle_nm = input('');
end

if turtle_nm == 1
	turtle_name = "Melis";
	turtle_dive_name		= 'turtle_dive_Melis.mat';
	turtle_dive_fft_name	= 'turtle_dive_fft_Melis.mat';
	turtle_DBA_name			= 'turtle_DBA_Melis.mat';
	turtle_DBA_name_paper	= 'turtle_DBA_paper_Melis.mat';
	turtle_freq_name		= 'turtle_freq_Melis.mat';
elseif turtle_nm == 2
	turtle_name = "Banu";
	turtle_dive_name		= 'turtle_dive_Banu.mat';
	turtle_dive_fft_name	= 'turtle_dive_fft_Banu.mat';
	turtle_DBA_name			= 'turtle_DBA_Banu.mat';
	turtle_DBA_name_paper	= 'turtle_DBA_paper_Banu.mat';
	turtle_freq_name		= 'turtle_freq_Banu.mat';
elseif turtle_nm == 3
	turtle_name = "Fati";
	turtle_dive_name		= 'turtle_dive_Fati.mat';
	turtle_dive_fft_name	= 'turtle_dive_fft_Fati.mat';
	turtle_DBA_name			= 'turtle_DBA_Fati.mat';
	turtle_DBA_name_paper	= 'turtle_DBA_paper_Fati.mat';
	turtle_freq_name		= 'turtle_freq_Fati.mat';
elseif turtle_nm == 4
	turtle_name = "Emine";
	turtle_dive_name		= 'turtle_dive_Emine.mat';
	turtle_dive_fft_name	= 'turtle_dive_fft_Emine.mat';
	turtle_DBA_name			= 'turtle_DBA_Emine.mat';
	turtle_DBA_name_paper	= 'turtle_DBA_paper_Emine.mat';
	turtle_freq_name		= 'turtle_freq_Emine.mat';
elseif turtle_nm == 5
	turtle_name = "Sevval";
	turtle_dive_name		= 'turtle_dive_Sevval.mat';
	turtle_dive_fft_name	= 'turtle_dive_fft_Sevval.mat';
	turtle_DBA_name			= 'turtle_DBA_Sevval.mat';
	turtle_DBA_name_paper	= 'turtle_DBA_paper_Sevval.mat';
	turtle_freq_name		= 'turtle_freq_Sevval.mat';
elseif turtle_nm == 6
	turtle_name = "Deniz";
	turtle_dive_name		= 'turtle_dive_Deniz.mat';
	turtle_dive_fft_name	= 'turtle_dive_fft_Deniz.mat';
	turtle_DBA_name			= 'turtle_DBA_Deniz.mat';
	turtle_DBA_name_paper	= 'turtle_DBA_paper_Deniz.mat';
	turtle_freq_name		= 'turtle_freq_Deniz.mat';
elseif turtle_nm == 7
	turtle_name = "Elif";
	turtle_dive_name		= 'turtle_dive_Elif.mat';
	turtle_dive_fft_name	= 'turtle_dive_fft_Elif.mat';
	turtle_DBA_name			= 'turtle_DBA_Elif.mat';
	turtle_DBA_name_paper	= 'turtle_DBA_paper_Elif.mat';
	turtle_freq_name		= 'turtle_freq_Elif.mat';
elseif turtle_nm == 8
	turtle_name = "Funda";
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

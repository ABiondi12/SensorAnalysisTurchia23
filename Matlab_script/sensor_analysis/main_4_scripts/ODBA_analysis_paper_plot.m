% ODBA_analysis_paper_plot
%
% Script demanded to handle the plot of all the results for ODBA in big
% dives, shallow dives and sub-surface periods.
% 
% In particular, there are the following plots:
%
%	1. box plots of big, shallow and sub surface
%
%	2. boxplot big dives' type
%		2.1 complete dive
%		2.2 descent phase only
%		2.3 bottom phase only
%		2.4 ascent phase only
%
%	3. histogram big dives
%		3.1 ODBA distribution complete dive
%		3.2 ODBA distribution descent phase only
%		3.3 ODBA distribution bottom phase only
%		3.4 ODBA distribution ascent phase only
%
%	4. ODBA distribution day-night and offshore-inshore big dives
%		4.1 complete dive
%		4.2 descent phase only
%		4.3 bottom phase only
%		4.4 ascent phase only
%		and for each (* is one among 1,2,3,4 relative to the phase):
%			4.*.1 day-night
%			4.*.2 offshore-inshore
%			4.*.3 day-night and offshore-inshore
%
%	5. histogram big dives S type
%		5.1 ODBA distribution complete dive
%		5.2 ODBA distribution descent phase only
%		5.3 ODBA distribution bottom phase only
%		5.4 ODBA distribution ascent phase only
%
%	6. ODBA distribution day-night and offshore-inshore big dives S type
%		6.1 complete dive
%		6.2 descent phase only
%		6.3 bottom phase only
%		6.4 ascent phase only
%		and for each (* is one among 1,2,3,4 relative to the phase):
%			6.*.1 day-night
%			6.*.2 offshore-inshore
%			6.*.3 day-night and offshore-inshore
%
%	7. histogram shallow dives
%
%	8. ODBA distribution day-night and offshore-inshore shallow dives
%		8.1 day-night
%		8.2 offshore-inshore
%		8.3 day-night and offshore-inshore
%
% For now, it is commented at the end of the script
% "main_4_ODBA_statistic_paper", so for its execution be sure to previously
% uncomment the corresponding row.

%% init parameters
C = {'s', 'u', 'v', 'm'};

%% turtle
ODBA = [turtle_big_ODBA; turtle_sh_ODBA; turtle_sub_ODBA];

count_s = length(id_s);	
count_u = length(id_u);	
count_v = length(id_v);	
count_m = length(id_m);

type = [count_s, count_u, count_v, count_m];

count_s_d = length(day_id_s);	
% count_2u_d = length(day_id_2_u);		% to be executed yet
% count_2v_d = length(day_id_2_v);	
% count_2m_d = length(day_id_2_m);	

count_s_n = length(night_id_s);	
% count_2u_n = length(night_id_2_u);	% to be executed yet
% count_2v_n = length(night_id_2_v);	
% count_2m_n = length(night_id_2_m);	

% type2_n = [count_2s_n, count_2u_n, count_2v_n, count_2m_n];
% type2_d = [count_2s_d, count_2u_d, count_2v_d, count_2m_d];

% Create a grouping variable that assigns the same value to rows that 
% correspond to the same vector in x (here, ODBA2).  

g1 = repmat({'Big'}, big_num, 1);
g2 = repmat({'Shallow'}, sh_num, 1);
g3 = repmat({'sub'}, sub_num, 1);
g = [g1; g2; g3];

	%% box plots of big, shallow and sub surface
figure('Name', ['figure ', num2str(id_plot),': ODBA analysis: depth behaviour'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
boxplot(ODBA, g, 'Notch', 'on', 'Labels', {'Big Dive', 'Shallow Dive', 'Sub Surface'})
ylabel('ODBA')
set(gca,'FontSize', dim_fontb)
title('ODBA analysis: depth behaviour')

	%% boxplot big dives' type
% tot
figure('Name', ['figure ', num2str(id_plot),': ODBA analysis of big dives'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
boxplot(turtle_big_ODBA, dive_type', 'Notch', 'on', 'Labels', {'s Dive', 'v Dive', 'm Dive'})
ylabel('Time (s)')
set(gca,'FontSize', dim_fontb)
title('ODBA analysis of big dives')

% disc
figure('Name', ['figure ', num2str(id_plot),': ODBA analysis of big dives, disc phase'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
boxplot(turtle_big_ODBA_disc, dive_type', 'Notch', 'on', 'Labels', {'s Dive', 'v Dive', 'm Dive'})
ylabel('depth (s)')
set(gca,'FontSize', dim_fontb)
title('ODBA analysis of big dives, disc phase')

% bott
figure('Name', ['figure ', num2str(id_plot),': ODBA analysis of big dives, bott phase'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
boxplot(turtle_big_ODBA_bott, dive_type', 'Notch', 'on', 'Labels', {'s Dive', 'v Dive', 'm Dive'})
ylabel('depth (s)')
set(gca,'FontSize', dim_fontb)
title('ODBA analysis of big dives, bott phase')

% asc
figure('Name', ['figure ', num2str(id_plot),': ODBA analysis of big dives, asc phase'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
boxplot(turtle_big_ODBA_asc, dive_type', 'Notch', 'on', 'Labels', {'s Dive', 'v Dive', 'm Dive'})
ylabel('depth (s)')
set(gca,'FontSize', dim_fontb)
title('ODBA analysis of big dives, asc phase')

	%% histogram big dives
% ODBA distribution tot
figure('Name', ['figure ', num2str(id_plot),': big dives, ODBA distribution'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
histogram(turtle_big_ODBA, 'BinWidth', BW) 
set(gca,'FontSize', dim_fontb)
title('big dives, ODBA distribution')

% ODBA distribution disc
figure('Name', ['figure ', num2str(id_plot),': big dives, ODBA distribution, disc phase'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
histogram(turtle_big_ODBA_disc, 'BinWidth', BW) 
set(gca,'FontSize', dim_fontb)
title('big dives, ODBA distribution, disc phase')

% ODBA distribution bott
figure('Name', ['figure ', num2str(id_plot),': big dives, ODBA distribution, bott phase'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
histogram(turtle_big_ODBA_bott, 'BinWidth', BW) 
set(gca,'FontSize', dim_fontb)
title('big dives, ODBA distribution, bott phase')

% ODBA distribution asc
figure('Name', ['figure ', num2str(id_plot),': big dives, ODBA distribution, asc phase'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
histogram(turtle_big_ODBA_asc, 'BinWidth', BW) 
set(gca,'FontSize', dim_fontb)
title('big dives, ODBA distribution, asc phase')

	%% ODBA distribution day-night and offshore-inshore big dives
% day-night
figure('Name', ['figure ', num2str(id_plot),': big dives, ODBA distribution day vs night'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(1, 2, 1)
	histogram(turtle_big_ODBA(day_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('day')
subplot(1, 2, 2)
	histogram(turtle_big_ODBA(night_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('night')
sgtitle('big dives, ODBA distribution day vs night')

% offshore-inshore
figure('Name', ['figure ', num2str(id_plot),': big dives, ODBA distribution offshore vs inshore'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(1, 2, 1)
	histogram(turtle_big_ODBA(offshore_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore')
subplot(1, 2, 2)
	histogram(turtle_big_ODBA(inshore_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore')
sgtitle('big dives, ODBA distribution offshore vs inshore')

% day-night-offshore-inshore
figure('Name', ['figure ', num2str(id_plot),': big dives, ODBA distribution day-night and offshore-inshore'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(2, 2, 1)
	histogram(turtle_big_ODBA(off_day_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore, day')
subplot(2, 2, 2)
	histogram(turtle_big_ODBA(in_day_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore, day')
subplot(2, 2, 3)
	histogram(turtle_big_ODBA(off_night_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore, night')
subplot(2, 2, 4)
	histogram(turtle_big_ODBA(in_night_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore, night')
sgtitle('big dives, ODBA distribution day-night and offshore-inshore')

	%% ODBA distribution day-night and offshore-inshore disc phase
% day-night
figure('Name', ['figure ', num2str(id_plot),': big dives disc, ODBA distribution day vs night'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(1, 2, 1)
	histogram(turtle_big_ODBA_disc(day_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('day')
subplot(1, 2, 2)
	histogram(turtle_big_ODBA_disc(night_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('night')
sgtitle('big dives disc, ODBA distribution day vs night')

% offshore-inshore
figure('Name', ['figure ', num2str(id_plot),': big dives disc, ODBA distribution offshore vs inshore'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(1, 2, 1)
	histogram(turtle_big_ODBA_disc(offshore_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore')
subplot(1, 2, 2)
	histogram(turtle_big_ODBA_disc(inshore_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore')
sgtitle('big dives disc, ODBA distribution offshore vs inshore')

% day-night-offshore-inshore
figure('Name', ['figure ', num2str(id_plot),': big dives disc, ODBA distribution day-night and offshore-inshore'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(2, 2, 1)
	histogram(turtle_big_ODBA_disc(off_day_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore, day')
subplot(2, 2, 2)
	histogram(turtle_big_ODBA_disc(in_day_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore, day')
subplot(2, 2, 3)
	histogram(turtle_big_ODBA_disc(off_night_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore, night')
subplot(2, 2, 4)
	histogram(turtle_big_ODBA_disc(in_night_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore, night')
sgtitle('big dives disc, ODBA distribution day-night and offshore-inshore')

	%% ODBA distribution day-night and offshore-inshore bott phase
% day-night
figure('Name', ['figure ', num2str(id_plot),': big dives bott, ODBA distribution day vs night'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(1, 2, 1)
	histogram(turtle_big_ODBA_bott(day_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('day')
subplot(1, 2, 2)
	histogram(turtle_big_ODBA_bott(night_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('night')
sgtitle('big dives bott, ODBA distribution day vs night')

% offshore-inshore
figure('Name', ['figure ', num2str(id_plot),': big dives bott, ODBA distribution offshore vs inshore'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(1, 2, 1)
	histogram(turtle_big_ODBA_bott(offshore_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore')
subplot(1, 2, 2)
	histogram(turtle_big_ODBA_bott(inshore_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore')
sgtitle('big dives bott, ODBA distribution offshore vs inshore')

% day-night-offshore-inshore
figure('Name', ['figure ', num2str(id_plot),': big dives bott, ODBA distribution day-night and offshore-inshore'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(2, 2, 1)
	histogram(turtle_big_ODBA_bott(off_day_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore, day')
subplot(2, 2, 2)
	histogram(turtle_big_ODBA_bott(in_day_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore, day')
subplot(2, 2, 3)
	histogram(turtle_big_ODBA_bott(off_night_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore, night')
subplot(2, 2, 4)
	histogram(turtle_big_ODBA_bott(in_night_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore, night')
sgtitle('big dives bott, ODBA distribution day-night and offshore-inshore')

	%% ODBA distribution day-night and offshore-inshore asc phase
% day-night
figure('Name', ['figure ', num2str(id_plot),': big dives asc, ODBA distribution day vs night'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(1, 2, 1)
	histogram(turtle_big_ODBA_asc(day_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('day')
subplot(1, 2, 2)
	histogram(turtle_big_ODBA_asc(night_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('night')
sgtitle('big dives asc, ODBA distribution day vs night')

% offshore-inshore
figure('Name', ['figure ', num2str(id_plot),': big dives asc, ODBA distribution offshore vs inshore'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(1, 2, 1)
	histogram(turtle_big_ODBA_asc(offshore_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore')
subplot(1, 2, 2)
	histogram(turtle_big_ODBA_asc(inshore_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore')
sgtitle('big dives asc, ODBA distribution offshore vs inshore')

% day-night-offshore-inshore
figure('Name', ['figure ', num2str(id_plot),': big dives asc, ODBA distribution day-night and offshore-inshore'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(2, 2, 1)
	histogram(turtle_big_ODBA_asc(off_day_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore, day')
subplot(2, 2, 2)
	histogram(turtle_big_ODBA_asc(in_day_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore, day')
subplot(2, 2, 3)
	histogram(turtle_big_ODBA_asc(off_night_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore, night')
subplot(2, 2, 4)
	histogram(turtle_big_ODBA_asc(in_night_id), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore, night')
sgtitle('big dives asc, ODBA distribution day-night and offshore-inshore')

	%% histogram big dives S type
% ODBA distribution tot
figure('Name', ['figure ', num2str(id_plot),': big S dives, ODBA distribution'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
histogram(turtle_big_ODBA(id_s), 'BinWidth', BW) 
set(gca,'FontSize', dim_fontb)
title('big S dives, ODBA distribution')

% ODBA distribution disc
figure('Name', ['figure ', num2str(id_plot),': big S dives, ODBA distribution, disc phase'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
histogram(turtle_big_ODBA_disc(id_s), 'BinWidth', BW) 
set(gca,'FontSize', dim_fontb)
title('big S dives, ODBA distribution, disc phase')

% ODBA distribution bott
figure('Name', ['figure ', num2str(id_plot),': big S dives, ODBA distribution, bott phase'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
histogram(turtle_big_ODBA_bott(id_s), 'BinWidth', BW) 
set(gca,'FontSize', dim_fontb)
title('big S dives, ODBA distribution, bott phase')

% ODBA distribution asc
figure('Name', ['figure ', num2str(id_plot),': big S dives, ODBA distribution, asc phase'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
histogram(turtle_big_ODBA_asc(id_s), 'BinWidth', BW) 
set(gca,'FontSize', dim_fontb)
title('big S dives, ODBA distribution, asc phase')

	%% ODBA distribution day-night and offshore-inshore big dives S type
% day-night
figure('Name', ['figure ', num2str(id_plot),': big S dives, ODBA distribution day vs night'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(1, 2, 1)
	histogram(turtle_big_ODBA(day_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('day')
subplot(1, 2, 2)
	histogram(turtle_big_ODBA(night_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('night')
sgtitle('big S dives, ODBA distribution day vs night')

% offshore-inshore
figure('Name', ['figure ', num2str(id_plot),': big S dives, ODBA distribution offshore vs inshore'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(1, 2, 1)
	histogram(turtle_big_ODBA(offshore_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore')
subplot(1, 2, 2)
	histogram(turtle_big_ODBA(inshore_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore')
sgtitle('big S dives, ODBA distribution offshore vs inshore')

% day-night-offshore-inshore
figure('Name', ['figure ', num2str(id_plot),': big S dives, ODBA distribution day-night and offshore-inshore'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(2, 2, 1)
	histogram(turtle_big_ODBA(off_day_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore, day')
subplot(2, 2, 2)
	histogram(turtle_big_ODBA(in_day_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore, day')
subplot(2, 2, 3)
	histogram(turtle_big_ODBA(off_night_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore, night')
subplot(2, 2, 4)
	histogram(turtle_big_ODBA(in_night_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore, night')
sgtitle('big S dives, ODBA distribution day-night and offshore-inshore')

 	%% ODBA distribution day-night and offshore-inshore disc phase S type
% day-night
figure('Name', ['figure ', num2str(id_plot),': big S dives disc, ODBA distribution day vs night'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(1, 2, 1)
	histogram(turtle_big_ODBA_disc(day_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('day')
subplot(1, 2, 2)
	histogram(turtle_big_ODBA_disc(night_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('night')
sgtitle('big S dives disc, ODBA distribution day vs night')

% offshore-inshore
figure('Name', ['figure ', num2str(id_plot),': big S dives disc, ODBA distribution offshore vs inshore'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(1, 2, 1)
	histogram(turtle_big_ODBA_disc(offshore_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore')
subplot(1, 2, 2)
	histogram(turtle_big_ODBA_disc(inshore_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore')
sgtitle('big S dives disc, ODBA distribution offshore vs inshore')

% day-night-offshore-inshore
figure('Name', ['figure ', num2str(id_plot),': big S dives disc, ODBA distribution day-night and offshore-inshore'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(2, 2, 1)
	histogram(turtle_big_ODBA_disc(off_day_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore, day')
subplot(2, 2, 2)
	histogram(turtle_big_ODBA_disc(in_day_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore, day')
subplot(2, 2, 3)
	histogram(turtle_big_ODBA_disc(off_night_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore, night')
subplot(2, 2, 4)
	histogram(turtle_big_ODBA_disc(in_night_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore, night')
sgtitle('big S dives disc, ODBA distribution day-night and offshore-inshore')

 	%% ODBA distribution day-night and offshore-inshore bott phase S type
% day-night
figure('Name', ['figure ', num2str(id_plot),': big S dives bott, ODBA distribution day vs night'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(1, 2, 1)
	histogram(turtle_big_ODBA_bott(day_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('day')
subplot(1, 2, 2)
	histogram(turtle_big_ODBA_bott(night_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('night')
sgtitle('big S dives bott, ODBA distribution day vs night')

% offshore-inshore
figure('Name', ['figure ', num2str(id_plot),': big S dives bott, ODBA distribution offshore vs inshore'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(1, 2, 1)
	histogram(turtle_big_ODBA_bott(offshore_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore')
subplot(1, 2, 2)
	histogram(turtle_big_ODBA_bott(inshore_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore')
sgtitle('big S dives bott, ODBA distribution offshore vs inshore')

% day-night-offshore-inshore
figure('Name', ['figure ', num2str(id_plot),': big S dives bott, ODBA distribution day-night and offshore-inshore'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(2, 2, 1)
	histogram(turtle_big_ODBA_bott(off_day_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore, day')
subplot(2, 2, 2)
	histogram(turtle_big_ODBA_bott(in_day_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore, day')
subplot(2, 2, 3)
	histogram(turtle_big_ODBA_bott(off_night_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore, night')
subplot(2, 2, 4)
	histogram(turtle_big_ODBA_bott(in_night_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore, night')
sgtitle('big S dives bott, ODBA distribution day-night and offshore-inshore')

	%% ODBA distribution day-night and offshore-inshore asc phase S type
% day-night
figure('Name', ['figure ', num2str(id_plot),': big S dives asc, ODBA distribution day vs night'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(1, 2, 1)
	histogram(turtle_big_ODBA_asc(day_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('day')
subplot(1, 2, 2)
	histogram(turtle_big_ODBA_asc(night_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('night')
sgtitle('big S dives asc, ODBA distribution day vs night')

% offshore-inshore
figure('Name', ['figure ', num2str(id_plot),': big S dives asc, ODBA distribution offshore vs inshore'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(1, 2, 1)
	histogram(turtle_big_ODBA_asc(offshore_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore')
subplot(1, 2, 2)
	histogram(turtle_big_ODBA_asc(inshore_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore')
sgtitle('big S dives asc, ODBA distribution offshore vs inshore')

% day-night-offshore-inshore
figure('Name', ['figure ', num2str(id_plot),': big S dives asc, ODBA distribution day-night and offshore-inshore'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(2, 2, 1)
	histogram(turtle_big_ODBA_asc(off_day_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore, day')
subplot(2, 2, 2)
	histogram(turtle_big_ODBA_asc(in_day_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore, day')
subplot(2, 2, 3)
	histogram(turtle_big_ODBA_asc(off_night_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore, night')
subplot(2, 2, 4)
	histogram(turtle_big_ODBA_asc(in_night_id_s), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore, night')
sgtitle('big S dives asc, ODBA distribution day-night and offshore-inshore')

	%% histogram shallow dives
% ODBA distribution
figure('Name', ['figure ', num2str(id_plot),': shallow dives, ODBA distribution'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
histogram(turtle_sh_ODBA, 'BinWidth', BW) 
set(gca,'FontSize', dim_fontb)
title('shallow dives, ODBA distribution')

	%% ODBA distribution day-night and offshore-inshore shallow dives
% day-night
figure('Name', ['figure ', num2str(id_plot),': shallow dives, ODBA distribution day vs night'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(1, 2, 1)
	histogram(turtle_sh_ODBA(day_ids), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('day')
subplot(1, 2, 2)
	histogram(turtle_sh_ODBA(night_ids), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('night')
sgtitle('shallow dives, ODBA distribution day vs night')

% offshore-inshore
figure('Name', ['figure ', num2str(id_plot),': shallow dives, ODBA distribution offshore vs inshore'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(1, 2, 1)
	histogram(turtle_sh_ODBA(offshore_ids), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore')
subplot(1, 2, 2)
	histogram(turtle_sh_ODBA(inshore_ids), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore')
sgtitle('shallow dives, ODBA distribution offshore vs inshore')

% day-night-offshore-inshore
figure('Name', ['figure ', num2str(id_plot),': shallow dives, ODBA distribution day-night and offshore-inshore'], 'NumberTitle','off'); id_plot = id_plot + 1;	
clf
subplot(2, 2, 1)
	histogram(turtle_sh_ODBA(off_day_ids), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore, day')
subplot(2, 2, 2)
	histogram(turtle_sh_ODBA(in_day_ids), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore, day')
subplot(2, 2, 3)
	histogram(turtle_sh_ODBA(off_night_ids), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('offshore, night')
subplot(2, 2, 4)
	histogram(turtle_sh_ODBA(in_night_ids), 'BinWidth', BW) 
	set(gca,'FontSize', dim_fontb)
	title('inshore, night')
sgtitle('shallow dives, ODBA distribution day-night and offshore-inshore')
% save_dive_data
%
% save single dive division

new_dive_dataset = 0;

if exist (turtle_dive_name, 'file') == 2
	fprintf([turtle_dive_name,': dataset exists!!! \n'])
	ov_to_do = 0;
	
	yn_ans = 0;
	while yn_ans < 1 || yn_ans > 2
		fprintf([turtle_dive_name, ': do you want to overwrite it? \n'])
		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans = input('');
	end
	
	if yn_ans == 1
		ov_to_do = 1;
		fprintf([turtle_dive_name, ': start overwrite \n'])
	elseif yn_ans == 2
		ov_to_do = 0;
		fprintf([turtle_dive_name, ': overwrite operation aborted \n'])
	end
	
else
	fprintf([turtle_dive_name, ': dataset not exists, start making it \n'])
	new_dive_dataset = 1;
end

if new_dive_dataset == 1 || ov_to_do == 1
	turtle_dive_dataset = turtle_dive;
	fprintf([turtle_dive_name, ': saving struct \n'])
	% save('turtle_dive', 'turtle_dive', '-v7.3');
	save(turtle_dive_name, 'turtle_dive', '-v7.3');
	fprintf([turtle_dive_name,' saved! \n'])
end

%% save struct din

new_dive_dataset_din = 0;

if exist (turtle_dive_name_din, 'file') == 2
	fprintf([turtle_dive_name_din,': dataset exists!!! \n'])
	ov_to_do_din = 0;
	
	yn_ans_din = 0;
	while yn_ans_din < 1 || yn_ans_din > 2
		fprintf([turtle_dive_name_din, ': do you want to overwrite it? \n'])
		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans_din = input('');
	end
	
	if yn_ans_din == 1
		ov_to_do_din = 1;
		fprintf([turtle_dive_name_din, ': start overwrite \n'])
	elseif yn_ans_din == 2
		ov_to_do_din = 0;
		fprintf([turtle_dive_name_din, ': overwrite operation aborted \n'])
	end
	
else
	fprintf([turtle_dive_name_din, ': dataset not exists, start making it \n'])
	new_dive_dataset_din = 1;
end

if new_dive_dataset_din == 1 || ov_to_do_din == 1
	turtle_dive_dataset_din = turtle_dive_din;
	fprintf([turtle_dive_name_din, ': saving struct \n'])
	% save('turtle_dive', 'turtle_dive', '-v7.3');
	save(turtle_dive_name_din, 'turtle_dive_din', '-v7.3');
	fprintf([turtle_dive_name_din,' saved! \n'])
end
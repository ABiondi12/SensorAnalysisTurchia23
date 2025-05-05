% save_dive_data
%
% save single dive division

new_dive_dataset = 0;

if exist (turtle_dive_name, 'file') == 2
    formatSpec = "%s : dataset exists!!! \n";
    print_msg = compose(formatSpec, turtle_dive_name);
	fprintf(print_msg)

	ov_to_do = 0;
	
	yn_ans = 0;
	while yn_ans < 1 || yn_ans > 2
        formatSpec = "%s : do you want to overwrite it? \n";
        print_msg = compose(formatSpec, turtle_dive_name);
	    fprintf(print_msg)
		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans = input('');
	end
	
	if yn_ans == 1
		ov_to_do = 1;
        formatSpec = "%s : start overwrite \n";
        print_msg = compose(formatSpec, turtle_dive_name);
	    fprintf(print_msg)
	elseif yn_ans == 2
		ov_to_do = 0;
        formatSpec = "%s : overwrite operation aborted \n";
        print_msg = compose(formatSpec, turtle_dive_name);
	    fprintf(print_msg)
	end
	
else
    formatSpec = "%s : dataset not exists, start making it \n";
    print_msg = compose(formatSpec, turtle_dive_name);
    fprintf(print_msg)

	new_dive_dataset = 1;
end

if new_dive_dataset == 1 || ov_to_do == 1
	turtle_dive_dataset = turtle_dive;
    formatSpec = "%s : saving struct \n";
    print_msg = compose(formatSpec, turtle_dive_name);
    fprintf(print_msg)

	% save('turtle_dive', 'turtle_dive', '-v7.3');
	save(turtle_dive_name, 'turtle_dive', '-v7.3');
    formatSpec = "%s : saved! \n";
    print_msg = compose(formatSpec, turtle_dive_name);
    fprintf(print_msg)
end

%% save struct din

new_dive_dataset_din = 0;

if exist (turtle_dive_name_din, 'file') == 2
    formatSpec = "%s : dataset exists!!! \n";
    print_msg = compose(formatSpec, turtle_dive_name_din);
    fprintf(print_msg)
	ov_to_do_din = 0;
	
	yn_ans_din = 0;
	while yn_ans_din < 1 || yn_ans_din > 2
	    formatSpec = "%s : do you want to overwrite it? \n";
        print_msg = compose(formatSpec, turtle_dive_name_din);
        fprintf(print_msg)

		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans_din = input('');
	end
	
	if yn_ans_din == 1
		ov_to_do_din = 1;
        formatSpec = "%s : start overwrite \n";
        print_msg = compose(formatSpec, turtle_dive_name_din);
        fprintf(print_msg)

	elseif yn_ans_din == 2
		ov_to_do_din = 0;
        formatSpec = "%s : overwrite operation aborted \n";
        print_msg = compose(formatSpec, turtle_dive_name_din);
        fprintf(print_msg)

	end
	
else
	formatSpec = "%s : dataset not exists, start making it \n";
    print_msg = compose(formatSpec, turtle_dive_name_din);
    fprintf(print_msg)

	new_dive_dataset_din = 1;
end

if new_dive_dataset_din == 1 || ov_to_do_din == 1
	turtle_dive_dataset_din = turtle_dive_din;
	formatSpec = "%s : saving struct \n";
    print_msg = compose(formatSpec, turtle_dive_name_din);
    fprintf(print_msg)

	% save('turtle_dive', 'turtle_dive', '-v7.3');
	save(turtle_dive_name_din, 'turtle_dive_din', '-v7.3');
	formatSpec = "%s : saved! \n";
    print_msg = compose(formatSpec, turtle_dive_name_din);
    fprintf(print_msg)

end
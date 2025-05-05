% single_main_2_load

%% check for already existent YPR dataset
new_ypr_dataset = 0;

if exist(turtle_ypr_name, 'file') == 2
    formatSpec = "%s : dataset already exists!!! \n";
    print_msg = compose(formatSpec, turtle_ypr_name);
    fprintf(print_msg)
	
	ov_to_do = 0;
	
	yn_ans = 0;
	while yn_ans < 1 || yn_ans > 2
        formatSpec = "%s : do you want to load and use the existing dataset? \n";
        print_msg = compose(formatSpec, turtle_ypr_name);
        fprintf(print_msg)
		
		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans = input('');
	end
	
	if yn_ans == 1
		ov_to_do = 1;
        formatSpec = "%s : start loading... \n";
        print_msg = compose(formatSpec, turtle_ypr_name);
        fprintf(print_msg)
		
	elseif yn_ans == 2
		ov_to_do = 0;
        formatSpec = "%s : load operation aborted, create a new dataset! \n";
        print_msg = compose(formatSpec, turtle_ypr_name);
        fprintf(print_msg)
 		
	end
else
	new_ypr_dataset = 1;
end
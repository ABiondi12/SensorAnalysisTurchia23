% single_main_4_load

%% check for already existent STFT dataset
new_fft_dataset = 0;
if exist(turtle_dive_fft_name, 'file') == 2 && exist(turtle_dive_fft_name_din, 'file') == 2
	formatSpec = "%s and %s : datasets already exist!!! \n";
    print_msg = compose(formatSpec, turtle_dive_fft_name, turtle_dive_fft_name_din);
    fprintf(print_msg)

	ov_to_do = 0;
	
	yn_ans = 0;
	while yn_ans < 1 || yn_ans > 2
		formatSpec = "%s and %s : do you want to load and use the existing datasets? \n";
        print_msg = compose(formatSpec, turtle_dive_fft_name, turtle_dive_fft_name_din);
        fprintf(print_msg)

		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans = input('');
	end
	
	if yn_ans == 1
		ov_to_do = 1;
	    formatSpec = "%s and %s : start loading... \n";
        print_msg = compose(formatSpec, turtle_dive_fft_name, turtle_dive_fft_name_din);
        fprintf(print_msg)

    
	elseif yn_ans == 2
		ov_to_do = 0;
	    formatSpec = "%s and %s : load operation aborted, create new datasets! \n";
        print_msg = compose(formatSpec, turtle_dive_fft_name, turtle_dive_fft_name_din);
        fprintf(print_msg)
		
	end
else
	new_fft_dataset = 1;
end

%% check for already existent ODBA dataset
new_odba_dataset = 0;
if exist(turtle_DBA_name_paper, 'file') == 2 && exist(turtle_DBA_name_paper_din, 'file') == 2
	formatSpec = "%s and %s : datasets already exist!!! \n";
    print_msg = compose(formatSpec, turtle_DBA_name_paper, turtle_DBA_name_paper_din);
    fprintf(print_msg)
	
	ov_to_do_odba = 0;
	
	yn_ans = 0;
	while yn_ans < 1 || yn_ans > 2
	    formatSpec = "%s and %s : do you want to load and use the existing datasets? \n";
        print_msg = compose(formatSpec, turtle_DBA_name_paper, turtle_DBA_name_paper_din);
        fprintf(print_msg)
		
		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans = input('');
	end
	
	if yn_ans == 1
		ov_to_do_odba = 1;
	    formatSpec = "%s and %s : start loading... \n";
        print_msg = compose(formatSpec, turtle_DBA_name_paper, turtle_DBA_name_paper_din);
        fprintf(print_msg)
		
	elseif yn_ans == 2
		ov_to_do_odba = 0;
	    formatSpec = "%s and %s : load operation aborted, create new datasets! \n";
        print_msg = compose(formatSpec, turtle_DBA_name_paper, turtle_DBA_name_paper_din);
        fprintf(print_msg)
		
	end
else
	new_odba_dataset = 1;
end
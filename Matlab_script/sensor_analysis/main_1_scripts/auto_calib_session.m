% automatic insertion of the calibration session depending on the turtle
all_instr = 1;

if release == 1

    start_year	= [2023, 2023, 2023, 2023, 2023, 2023, 2023, 2023, 2023];
    stop_year	= [2023, 2023, 2023, 2023, 2023, 2023, 2023, 2023, 2023];
    
    start_month	= [05, 05, 05, 05, 05, 05, 06, 06, 06];
    stop_month	= [05, 05, 05, 05, 05, 05, 06, 06, 06];
    
    start_day	= [30, 30, 30, 30, 30, 30, 26, 26, 26];
    stop_day	= [30, 30, 30, 30, 30, 30, 26, 26, 26];
    
    start_hour	= [10, 10, 14, 16, 18, 18, 16, 16, 16];
    stop_hour	= [10, 10, 14, 16, 18, 19, 16, 16, 16];
    
    start_minute= [25, 52, 26, 39, 40, 57, 00, 00, 00];
    stop_minute	= [31, 58, 42, 45, 49, 05, 10, 10, 10];
    
    start_second= [00, 00, 00, 00, 00, 00, 00, 00, 00];
    stop_second	= [00, 00, 00, 00, 00, 00, 00, 00, 00];
    
    start_msec  = [00, 00, 00, 00, 00, 00, 00, 00, 00];
    stop_msec 	= [00, 00, 00, 00, 00, 00, 00, 00, 00];

elseif release == 2

    start_year	= [2024, 2024, 2024, 2024, 2024, 2024, 2024, 2024, 2024, 2024];
    stop_year	= [2024, 2024, 2024, 2024, 2024, 2024, 2024, 2024, 2024, 2024];
    
    start_month	= [05, 05, 05, 05, 05, 06, 06, 06, 06, 06];
    stop_month	= [05, 05, 05, 05, 05, 06, 06, 06, 06, 06];
    
    start_day	= [18, 19, 19, 19, 19, 00, 00, 00, 00, 00];
    stop_day	= [18, 19, 19, 19, 19, 00, 00, 00, 00, 00];
    
    if all_instr == 1

        start_hour	= [14, 07, 08, 09, 11, 00, 00, 00, 00, 00];
        stop_hour	= [14, 07, 08, 09, 11, 00, 00, 00, 00, 00];
        
        start_minute= [06, 48, 28, 17, 28, 00, 00, 00, 00, 00];
        stop_minute	= [12, 54, 34, 23, 34, 00, 00, 00, 00, 00];

    elseif all_instr == 0
        
        start_hour	= [14, 07, 08, 09, 11, 00, 00, 00, 00, 00];
        stop_hour	= [14, 08, 08, 09, 11, 00, 00, 00, 00, 00];
        
        start_minute= [06, 55, 35, 24, 20, 00, 00, 00, 00, 00];
        stop_minute	= [12, 01, 41, 30, 26, 00, 00, 00, 00, 00];

    end

    start_second= [00, 00, 00, 00, 00, 00, 00, 00, 00, 00];
    stop_second	= [00, 00, 00, 00, 00, 00, 00, 00, 00, 00];
    
    start_msec  = [00, 00, 00, 00, 00, 00, 00, 00, 00, 00];
    stop_msec 	= [00, 00, 00, 00, 00, 00, 00, 00, 00, 00];

end

Yi = start_year(turtle_nm);
Yf = stop_year(turtle_nm);

Mi = start_month(turtle_nm);
Mf = stop_month(turtle_nm);

Di = start_day(turtle_nm);
Df = stop_day(turtle_nm);

Hi = start_hour(turtle_nm);
Hf = stop_hour(turtle_nm);

MIi = start_minute(turtle_nm);
MIf = stop_minute(turtle_nm);

Si = start_second(turtle_nm);
Sf = stop_second(turtle_nm);

MSi = start_msec(turtle_nm);
MSf = stop_msec(turtle_nm);
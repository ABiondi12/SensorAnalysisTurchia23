function [DBA, DBA_mov_w, Norm, Norm_mov_w, Norm2, Norm2_mov_w] = energy_indeces(dinx, diny, dinz, mov_wind_size)
% This function computes energy indeces such as ODBA, VeDBA and VeDBA^2
% using as accelerations values passed as input (dinx, diny and dinz). It
% also execute a smoothdata operation using a moving window of size 
% mov_wind_size (given as input). 
% Output are the three indeces and their smoothed versions.
% 
% Indeces are computed using these formula:
%	DBA		= |accx| + |accy| + |accz|
%	Norm	= sqrt(accx^2 + accy^2 + accz^2)
%	Norm2	= accx^2 + accy^2 + accz^2
if mov_wind_size > 0
	
	DBA		= zeros(size(dinx, 1), size(dinx, 2));
	Norm	= zeros(size(dinx, 1), size(dinx, 2));
	Norm2	= zeros(size(dinx, 1), size(dinx, 2));

	for i = 1:length(dinx)
		DBA(i)	= abs(dinx(i)) + abs(diny(i)) + abs(dinz(i));
		Norm2(i)= dinx(i)^2 + diny(i)^2 + dinz(i)^2;
		Norm(i)	= sqrt(Norm2(i));
	end

	% smoothdata(A,METHOD,WINSIZE)
	wind_sample = mov_wind_size;
	DBA_mov_w	= smoothdata(DBA, 'movmean', wind_sample);
	Norm_mov_w	= smoothdata(Norm, 'movmean', wind_sample);
	Norm2_mov_w = smoothdata(Norm2, 'movmean', wind_sample);
	 
elseif mov_wind_size < 0 % mean of -mov_wind_size successive values (no mov_mean)
	num_mean = - mov_wind_size;
	size_x = ceil(size(dinx, 1)/num_mean);
	size_y = ceil(size(dinx, 2)/num_mean);
	
	dinx_m	= zeros(size_x, size_y);
	diny_m	= zeros(size_x, size_y);	
	dinz_m	= zeros(size_x, size_y);
	
	DBA		= zeros(size_x, size_y);
	Norm	= zeros(size_x, size_y);
	Norm2	= zeros(size_x, size_y);

	for i = 1:max(size_x, size_y)
		if i < max(size_x, size_y)
			dinx_m(i)	= mean(dinx((num_mean*(i-1) + 1) : num_mean*i));
			diny_m(i)	= mean(diny((num_mean*(i-1) + 1) : num_mean*i));
			dinz_m(i)	= mean(dinz((num_mean*(i-1) + 1) : num_mean*i));
		else
			dinx_m(i)	= mean(dinx((num_mean*(i-1) + 1) : end));
			diny_m(i)	= mean(diny((num_mean*(i-1) + 1) : end));
			dinz_m(i)	= mean(dinz((num_mean*(i-1) + 1) : end));
		end
		
		DBA(i)	= abs(dinx_m(i)) + abs(diny_m(i)) + abs(dinz_m(i));
		Norm2(i)= dinx_m(i)^2 + diny_m(i)^2 + dinz_m(i)^2;
		Norm(i)	= sqrt(Norm2(i));
	end

	% no smoothing of data here

	DBA_mov_w	= DBA;
	Norm_mov_w	= Norm;
	Norm2_mov_w = Norm2;
end
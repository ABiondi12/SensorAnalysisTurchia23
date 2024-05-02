% apply_filter

function [d_filt_x, d_filt_y, d_filt_z] = apply_filter(a_x, a_y, a_z, LP_FIR)

a_x_filt = LP_FIR(a_x);
a_y_filt = LP_FIR(a_y);
a_z_filt = LP_FIR(a_z);

d_filt_x	= a_x - a_x_filt;
d_filt_y	= a_y - a_y_filt;
d_filt_z	= a_z - a_z_filt;

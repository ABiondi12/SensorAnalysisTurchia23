function [mag_postcalib, soft_iron, hard_iron, exp_mag_strength, sphere_fit, ellips_fit]=mag_calib_main(mag_sens)
% Function that takes as input uncalibrated data over which to compute
% correction coefficient and gives as output the same data after been
% calibrated, together with the correction coefficients to be applied to
% the rest of the data in order to calibrate them.
%
%% magcal function description
%  magcal - Magnetometer calibration coefficients 
%  
%     [A,B,EXPMFS] = magcal(D) returns the coefficients needed to correct
%     uncalibrated magnetometer data D. Specify D as an N-by-3 matrix of 
%     [X Y Z] measurements. A is a 3-by-3 matrix which corrects soft-iron
%     effects. B is a 1-by-3 vector which corrects hard-iron effects. EXPMFS
%     is the scalar expected magnetic field strength.
%  
%     [A,B,EXPMFS] = magcal(..., FITKIND) constrains A to have the form in
%     FITKIND.  Valid choices for FITKIND are:
%  
%       'eye'   - constrains A to be eye(3)
%       'diag'  - constrains A to be diagonal
%       'sym'   - constrains A to be symmetric
%       'auto'  - (default) chooses A among 'eye', 'diag', and 'sym' to give
%                 the best fit.
%  
%     The data D can be corrected with the 3-by-3 matrix A and the 3-by-1
%     vector B using the equation
%       F = (D-B)*A
%     to produce the N-by-3 matrix F of corrected magnetometer data. The
%     corrected magnetometer data lies on a sphere of radius EXPMFS.

%% calibration procedure
mag_precalib = mag_sens;

% Compute correction terms starting from not calibrated dataset:
% soft_iron corresponds to the A term of the function description (see
% above), hard_iron corresponds to the B term of the function description.
[soft_iron, hard_iron, exp_mag_strength] = magcal(mag_precalib);

% Magnetic field correction: here, only the calibration dataset (called
% pre-deployment in prof. Luschi dataset) is corrected. If this calibration
% results to be failry good, then you have to apply the same formula over
% the entire dataset (turtle travel in open sea).
mag_postcalib = (mag_precalib-hard_iron)*soft_iron;

% reconstruct fitting ellipsoid (pre-calibration) and obtained sphere (post
% calibration).
num_p = 50;

% Description: starting from the knowledge of the best fitting sphere,
% which is obtained after the calibration procedure (it is centred in the
% origin and has radius magnitude equal to the magnetic field magnitude), 
% we proceed as a feedback and obtain back the ellipsoid of best fitting of
% the data before the calibration has been executed over them. This is done
% by reversing the order of the operations, thus by adding back the effects
% of the hard-iron distortions and of the soft-iron distortions which have
% been deleted during the calibration (that gave you the sphere).

% sphere of unitary radius centred in axis origin
[sphere_fit_x, sphere_fit_y, sphere_fit_z] = sphere(num_p);
sphere_fit = [sphere_fit_x(:), sphere_fit_y(:),sphere_fit_z(:)];

% sphere of exp_mag_strength radius centred in axis origin, where
% exp_mag_strength is the expected strength of magnetic field after
% calibration procedure has been applied over raw data
sphere_fit_x = sphere_fit(:, 1) * exp_mag_strength;
sphere_fit_y = sphere_fit(:, 2) * exp_mag_strength;
sphere_fit_z = sphere_fit(:, 3) * exp_mag_strength;

sphere_fit = [sphere_fit_x, sphere_fit_y, sphere_fit_z];

% best fitting ellipsoid from which sphere is computed inside magcal fcn
ellips_fit = sphere_fit * inv(soft_iron) + hard_iron;
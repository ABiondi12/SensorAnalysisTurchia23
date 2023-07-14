%% Description
% Script in which are evaluated:
%
%	1_ angle between local magnetic field and acceleration vectors (with
%	the hypotesis that only gravity field occurs, because turtles movement
%	are much slow with respect to gravity magnitude, so we expect their
%	proper accelerations along 3 axis will be negligible w.r.t. g).
%
%	2_ Yaw Pitch and Roll angles in order to evaluate turtles orientation.

% Logger was located on turtles' carapace

%	UPDATE: use filtered values of acc measures in order to keep only low
%	frequency components, corresponding to static acceleration (gravity)

%% Local magnetic field extrapulation from online dataset in NED ref. frame

% chosen an indicative point to compute magnetic field, local space and
% time variability is very low so we decides to adopt the same one for
% every turtles and every days. (If necessary, you can select day and
% position from each turtle dataset)

% Turchia coordinates
height		= 0;
lat			= 36.6060000; % from satellite info about turtles patterns
long		= 28.8150000; % from satellite info about turtles patterns
year_calib	= 2023;
month_calib	= 5;
day_calib	= 30;
model		= '2020';
	
% local magnetic field from online dataset (NED frame)
% Results have nanoTesla magnitude
[XYZ, H, D, I, F] = wrldmagm(height, lat, long, decyear(year_calib, month_calib, day_calib), model);

% Sensors data have microTesla magnitude, so we bring all measures
% expressed in microTesla by dividing the first one by 1000
XYZ_micro = XYZ./1000;
H_micro = H/1000;		% horizontal plane intensity (magnitude)
F_micro = F/1000;		% total intensity (magnitude)

%% angle g_mf using NED values from online dataset
% angle between g and magnetic field evaluated using NED values ​​obtained
% from online database. We use normalized vectors, since we are only 
% interested in directions.

% normalized mf vector
XYZ_m_norm = XYZ_micro/norm(XYZ_micro);
% XYZ_m_norm = XYZ_micro/F_micro;	F_micro is the magnitude of mf

% normalized g vector expressed in NED reference frame
acc_NED = [0 0 1];

% % NED with N along magnetic north direction, we see E as zero
% XYZ_m_mag = rotz(-D, 'deg') * XYZ_micro;
% XYZ_m_mag_norm = XYZ_m_mag/norm(XYZ_m_mag);

% angle evaluation: we would like to obtain this value also using logger
% collected data.
[angle_c_NED, angle_s_NED, angle_tn_NED]= angle_g_mf(acc_NED, XYZ_m_norm', mag_step);
% angle_g_mf_NED = 90 - I;  should be the same as previously computed one,
% check 'angle_g_mf' script correctly works.

%% Norm computation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('norm_acc_mg using rotated sensor measures \n')
[norm_acc_reor, acc_norm_reor, norm_mag_reor, mag_norm_reor, norm_gyro_reor, gyro_norm_reor] = norm_acc_mg(acc_reor, mag_reor, gyro_reor);

fprintf('norm_acc_mg using rotated sensor measures and calibrated magnetic field \n')
[~, ~, norm_mag_reor_calib, mag_norm_reor_calib, ~, ~] = norm_acc_mg(acc_reor, mag_postcalib, gyro_reor);

if isnan(acc_norm_reor(end, 1))
	acc_norm_reor(end, 1) = 0;
end

if isnan(acc_norm_reor(end, 2))
	acc_norm_reor(end, 2) = 0;
end

if isnan(acc_norm_reor(end, 3))
	acc_norm_reor(end, 3) = 0;
end

%% NOTE: angle between g and mf and YPR angles computed with sensors data
% evaluation of the validity of the method by checking if the angle between
% the magnetic field and the gravitational field can be considered as a
% constant of the problem.

% Adopted 'rotated' data, rotated as they were collected with a
% logger having z axis along down direction and x axis along
% turtle motion direction.


% accelerometer - gravity field will be seen as [0 0 g]^T if accelerometer
%					has z axis along down direction
	%% angle g_mf using reoriented collected data from loggers

	% z axis along down (NED)
fprintf('angle_g_mf using rotated sensor measures \n')
[angle_c, angle_s, angle_tn]= angle_g_mf(acc_reor, mag_reor, mag_step);
fprintf('angle_g_mf using rotated sensor measures once divided by their norm \n')
[angle_c_norm, angle_s_norm, angle_tn_norm]= angle_g_mf(acc_norm_reor, mag_norm_reor, mag_step);

fprintf('angle_g_mf using rotated sensor measures and calibrated magnetic field \n')
[angle_c_calib, angle_s_calib, angle_tn_calib]= angle_g_mf(acc_reor, mag_postcalib, mag_step);
fprintf('angle_g_mf using rotated sensor measures once divided by their norm  and calibrated magnetic field \n')
[angle_c_norm_calib, angle_s_norm_calib, angle_tn_norm_calib]= angle_g_mf(acc_norm_reor, mag_norm_reor_calib, mag_step);

%% YPR computation
	%% Approach description (italiano per adesso)
% Calcoliamo roll e pitch valutando l'accelerazione di gravità g.
% Calcoliamo yaw con i medesimi ragionamenti fatti sul campo magnetico,
% dati pitch e roll per noti.

% Per roll e pitch, si valutano le componenti misurate in terna sensore:
%	se lungo x è diversa da 0: si ha pitch
%	se lungo y è diversa da 0: si ha roll

% Se ho 3 componenti in assi corpo del campo magnetico, come trovo il nord?
%	il vettore del campo magnetico è inclinato di un certo dip
%	(inclinazione, angolo che fa con l'orizzontale). Prendendo le sue
%	componenti sul piano tangente alla posizione locale, il vettore
%	risultante mi individua l'angolo di cui dovrei ruotare per puntare al
%	nord (voglio componente verso est nulla). Questo di fatto è il
%	-heading, ovvero il -yaw.
%	Per calcolarlo allora facciamo -atan2(mg_y/mg_x).
% Come facciamo ad avere le componenti del campo magnetico lungo x e y sul
% piano tangente all'orizzontale (allineati sul piano orizzontale). Per
% farlo, vado a prendere le grandezze in assi corpo e compenso per pitch e
% roll (non per yaw, non la conosco ed è quella che voglio trovare).
% I passi da fare sono:
%	1) prendo il vettore campo magnetico in assi corpo
%	2) lo ruoto con una matrice di rotazione intermedia data da solo roll e
%		pitch (pseudo navigation frame, allineato all'asse x Body e non 
%		all'asse x NED, cioè al nord)
%	3) calcolo quanto è disallineato il mio asse x di pseudo navigation
%		frame con quello di NED con atan2. Se voglio heading rispetto al
%		nord geografico, devo compensare anche per la declinazione
%		magnetica locale D.
%
%	Come trovare Roll e Pitch
% Per gli angoli di Roll e Pitch si lavora con la misura in assi corpo del
% campo gravitazionale g.
% Se la componente lungo x è non nulla allora si ha pitch.
% Se la componente lungo y è non nulla allora si ha roll.
% Prendendo la matrice di rotazione da nav a body e moltiplicando il
% vettore gravità g in NED ([0 0 g]^T) per questa matrice, allora si
% ottengono le componenti di accelerazione lungo i 3 assi che dovremmo
% misurare con quei valori di roll, pitch e yaw.
%		theta = -arcsin(g_x/g)	PITCH
%	ora che ho trovato theta, posso sfruttare la misura g_y o g_z per
%	trovare phi, cioè l'angolo di roll, ad esempio
%		phi = atan2(g_y/g_z)	ROLL
%
% Dalle misure del vettore "accelerazione di gravità" in body frame
% troviamo l'angolo di rollio e di beccheggio, ipotizzando che in NED
% l'accelerazione sia data solo dalla gravità).
%
% Adesso possiamo ripartire con il calcolo dell'imbardata, ovvero dello
% YAW, col metodo descritto e che richiedeva la conoscenza di pitch e roll.
% Facciamo gli stessi ragionamenti fatti con g in NED:
%	1)Prendiamo il campo magnetico mg in NED, avrà non solo la componente N
%		diversa da zero, infatti sappiamo che forma un angolo incidente non
%		nullo e non ortogonale alla superficie.
%	2)Sappiamo pitch e roll, allora ruotiamo il vettore campo magnetico da
%		Body a uno pseudo navigation frame, avente asse z (Down)
%		coincidente con quella del NED, mentre assi x e y ruotati rispetto 
%		a quelli del navigation frame di un angolo di yaw che non conosco.
%	3)Prendendo mg_x e mg_y nello pseudo navigation frame si ottiene yaw
%		come:
%			Yaw = -atan2(mg_y/mg_x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prendendo la matrice di rotazione da nav a body e moltiplicando il
% vettore gravità g in NED ([0 0 g]^T) per questa matrice, 
% allora si ottengono le componenti di accelerazione lungo i 3 assi che
% dovremmo misurare con quei valori di roll, pitch e yaw.
%		theta = arcsin(g_x/g)	PITCH
%	ora che ho trovato theta, posso sfruttare la misura g_y o g_z per
%	trovare phi, cioè l'angolo di roll, ad esempio
%		phi = atan2(g_y/g_z)	ROLL

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% da notare che i valori di Yaw ottenuti così, ovvero ipotizzando che
% la misura del campo magnetico sia nulla lungo la componente est, si
% riferiscono all'angolo di cui dovremmo ruotare rispetto al Nord
% magnetico per allinearci all'orientazione della tartaruga. Volendo
% ottenerle rispetto al nord geografico, dobbiamo andare ad aggiungere
% allo Yaw il valore della declinazione magnetica, ovvero l'angolo (che
% varia da posto a posto della terra) che forma la direzione del nord
% geografico con quella del nord magnetico (angolo da geogr a mag).

% XYZ_m_mag = rotz(-D, 'deg') * XYZ_m_geogr;
% XYZ_m_geogr = rotz(-D, 'deg') * XYZ_m_mag;

% Yaw_geog = Yaw_mag + D

%% functions
% minusg_NED = [0, 0, -1];
g_NED = [0, 0, 1];

if mag_step == 10
	Fs = 1;
elseif mag_step == 5
	Fs = 2;
elseif mag_step == 1
	Fs = 10;
end

Fs_filter = 0.01; 

fprintf('YPR using rotated sensor measures \n')
[yaw_m, yaw_g, pitch, roll, R_pose_m, R_pose_g]= YPR_comp(g_NED, D, acc_reor, mag_reor, Fs, Fs_filter);
fprintf('YPR using rotated sensor measures once divided by their norm \n')
[yaw_m_norm, yaw_g_norm, pitch_norm, roll_norm, R_pose_m_norm, R_pose_g_norm]= YPR_comp(g_NED, D, acc_norm_reor, mag_norm_reor, Fs, Fs_filter);

fprintf('YPR using rotated sensor measures and calibrated magnetic field \n')
[yaw_m_calib, yaw_g_calib, pitch_calib, roll_calib, R_pose_m_calib, R_pose_g_calib]= YPR_comp(g_NED, D, acc_reor, mag_postcalib, Fs, Fs_filter);
fprintf('YPR using rotated sensor measures once divided by their norm and calibrated magnetic field \n')
[yaw_m_norm_calib, yaw_g_norm_calib, pitch_norm_calib, roll_norm_calib, R_pose_m_norm_calib, R_pose_g_norm_calib]= YPR_comp(g_NED, D, acc_norm_reor, mag_norm_reor_calib, Fs, Fs_filter);

%% smooth data
% Windows choice is related to AAV computation, during which, by following
% Gunner paper steps, angles are smoothed using a 2 second moving window.
% Since our sample rate is 10Hz, we need to use a 20 samples width window.

% We so have to compute:
%		smooth_values = smoothdata(values, 'movmean', 20)

n_2s = 2*Fs;	% 2s smooth
more = 50;		% 100s smooth
yaw_m			= smoothdata(yaw_m, 'movmean', more*n_2s);
yaw_g			= smoothdata(yaw_g, 'movmean', more*n_2s);
pitch			= smoothdata(pitch, 'movmean', n_2s);
roll			= smoothdata(roll, 'movmean', n_2s);

mean_yaw_m	= mean(yaw_m);

yaw_m_norm	= smoothdata(yaw_m_norm, 'movmean', more*n_2s);
yaw_g_norm	= smoothdata(yaw_g_norm, 'movmean', more*n_2s);
pitch_norm		= smoothdata(pitch_norm, 'movmean', n_2s);
roll_norm		= smoothdata(roll_norm, 'movmean', n_2s);

% with calibrated magnetic field
yaw_m_calib			= smoothdata(yaw_m_calib, 'movmean', more*n_2s);
yaw_g_calib			= smoothdata(yaw_g_calib, 'movmean', more*n_2s);
pitch_calib			= smoothdata(pitch_calib, 'movmean', n_2s);
roll_calib			= smoothdata(roll_calib, 'movmean', n_2s);

mean_yaw_m_calib	= mean(yaw_m_calib);

yaw_m_norm_calib	= smoothdata(yaw_m_norm_calib, 'movmean', more*n_2s);
yaw_g_norm_calib	= smoothdata(yaw_g_norm_calib, 'movmean', more*n_2s);
pitch_norm_calib		= smoothdata(pitch_norm_calib, 'movmean', n_2s);
roll_norm_calib		= smoothdata(roll_norm_calib, 'movmean', n_2s);

%% Plot script (commented for now)
% Single_Turtle_orientation_plot

function [yaw_grad_m, yaw_grad_g, pitch_grad, roll_grad, R_pose_m, R_pose_g] = YPR_comp(g_NAV, Dec, acc, mag, Fs, Fs_filter)
% YPR_comp
% This function computes the yaw, pitch and roll angles starting from
% information about magnetic field and gravity, both in NED(navigation 
% frame, known once selected a place and a day) and in local (BODY)
% reference frame (same in accelerometers and magnetometers), known
% through logger informations, Yaw Pitch and Roll angles are computed.
%
% INPUT:
%	g_NAV		- gravity vector in navigation reference frame.
%	Dec			- local magnetic field declination in degrees. 
%	acc			- acceleration data reoriented.
%	mag			- magnetic field data reoriented.
%	Fs			- frequency for magnetic field data (acc is at 10 Hz)
%	Fs_filter	- passband frequency of the filter in hertz, used for 
%					filtering over acc measures in order to isolate g 
%					components from measures.
% 
% OUTPUT:
%	yaw_grad_m	- yaw angle w.r.t. magnetic North (degree)
%	yaw_grad_g	- yaw angle w.r.t. geographic North (degree)
%	pitch_grad	- pitch angle (degree)
%	roll_grad	- roll angle (degree)
%	R_pose_m	-
%	R_pose_g	-

%% Resample of acceleration
if(length(acc)~=length(mag))
	step = 10/Fs;
	acc = acc(1:step:end, :);
end

% Theoretical considerations are inserted in the following subsection 
% (italian explanation)

	%% Descrizione approccio (italiano per adesso)
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
	%		pitch (pseudo navigation frame, allineato all'asse x Body e non all'asse x NED, cioè al nord)
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
	%		coincidente con quella del NED mentre assi x e y ruotati rispetto a
	%		quelli del navigation frame di un angolo di yaw che non conosco.
	%	3)Prendendo mg_x e mg_y nello pseudo navigation frame si ottiene yaw
	%		come:
	%			Yaw = -atan2(mg_y/mg_x)
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% nota:
	% l'accelerometro misura -g, quindi lavoriamo con lui e non con il
	% vettore di gravità g quando eguagliamo con le misure in assi corpo
	% ruotate. Nel caso di z sensore verso l'alto, viene usato -g come
	% [0 0 g] in ENU. Nel caso di z sensore verso il basso, viene usato -g
	% come [0 0 -g] in NED. 

	% Prendendo la matrice di rotazione da nav a body e moltiplicando il
	% vettore gravità g in NED ([0 0 -g]^T) per questa matrice, allora si
	% ottengono le componenti di accelerazione lungo i 3 assi che dovremmo
	% misurare con quei valori di roll, pitch e yaw.
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

	%% computation
if length(acc)~= length(mag)
	error('acc e mag must have same dimensions')
end

if Fs_filter < 0
	fprintf('error, lpf will not be performed \n')
	Fs_filter = 0;
end

if Fs <= 0
	fprintf('error, Fs for data cannot be negative \n')
	Fs = 1;		% di default è 1 dato al secondo
end

% This section filters acc data in order to isolate only gravitational 
% components (static acceleration), which are the one to be used in yaw,
% pitch and roll computation procedure.

% In choosing the cutoff frequency, we must make sure that it is lower than 
% the flippers beat and wave frequencies.

if Fs_filter == 0
% no filtering over acc measures in order to isolate g components from
% measures
	g_x_B = acc(:, 1);
	g_y_B = acc(:, 2);
	g_z_B = acc(:, 3);
	
else 
%%%%%% no offset ax prova 2 and 3
%	Fpass = 0.1;	% Pass band freq
% 	Fpass = 0.05;	% Pass band freq

	Fpass = Fs_filter;
	
	g_x_B = lowpass(acc(:, 1), Fpass, Fs);
	g_y_B = lowpass(acc(:, 2), Fpass, Fs);
	g_z_B = lowpass(acc(:, 3), Fpass, Fs);
	
end

		%% pitch e roll
Theta = zeros(length(acc), 1);
Phi = zeros(length(acc), 1);

g_z = g_NAV(3);

for i = 1:length(acc)
	if g_x_B(i)<=1 && g_x_B(i)>= -1	
		Theta(i) = -g_z * asin(g_x_B(i));		% PITCH
	% sin cannot be more than 1 or less than -1	
	elseif acc(i, 1)>1
		Theta(i) = -g_z *asin(1);
		
	elseif acc(i, 1)< -1
		Theta(i) = -g_z *asin(-1);
	end
	
	Phi(i)		= atan(g_y_B(i)/ (g_z_B(i)));				% ROLL
	
end

		%% yaw  
% yaw (psi)
Psi = zeros(length(acc), 1);

% roty(theta)*rotx(phi)
R_pseudonav = eul2rotm([zeros(size(Psi, 1), 1), Theta, Phi]);

% traspose:
% (mag_N')^T = (mag_B)^T * (R_B^N')^T = (mag_B)^T * (R_N'^B)

R_pseudonav_T = R_pseudonav;
for i = 1:size(R_pseudonav, 3)
	R_pseudonav_T(:, :, i) = transpose(R_pseudonav(:, :, i));
end

for i = 1:length(acc)
	mg_pseudonav	= [mag(i, 1), mag(i, 2), mag(i, 3)]*R_pseudonav_T(:, :, i);
	Psi(i)			= -atan2(mg_pseudonav(2), mg_pseudonav(1)); 
end

		%% degree angles
Psi_grad	= Psi.*(180/pi);
Phi_grad	= Phi.*(180/pi);
Theta_grad	= Theta.*(180/pi);

roll_grad	= Phi_grad;
pitch_grad	= Theta_grad;
yaw_grad_m	= Psi_grad;					% magnetic North
yaw_grad_g	= Psi_grad + Dec * (-g_z);	% geographic North

%% pose (does not work for now)
% R_pose_m	= eul2rotm([Psi, Theta, Phi]);
R_pose_m = zeros(10); % falso, ma si impalla sennò

Psi_g		= yaw_grad_g.*(pi/180);
% R_pose_g	= eul2rotm([Psi_g, Theta, Phi]);
R_pose_g = R_pose_m; % falso, ma si impalla sennò

fprintf('YPR_comp completed \n')


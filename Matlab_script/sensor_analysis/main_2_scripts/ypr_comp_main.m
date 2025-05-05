% ypr_comp_main

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
g_NED = [0, 0, 1];

% frequency of magnetic field data (acceleration is sampled at 10 Hz)
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
smooth_yaw_m	= smoothdata(yaw_m, 'movmean', more*n_2s);
smooth_yaw_g	= smoothdata(yaw_g, 'movmean', more*n_2s);
smooth_pitch	= smoothdata(pitch, 'movmean', n_2s);
smooth_roll		= smoothdata(roll, 'movmean', n_2s);

mean_yaw_m	= mean(smooth_yaw_m);

smooth_yaw_m_norm	= smoothdata(yaw_m_norm, 'movmean', more*n_2s);
smooth_yaw_g_norm	= smoothdata(yaw_g_norm, 'movmean', more*n_2s);
smooth_pitch_norm	= smoothdata(pitch_norm, 'movmean', n_2s);
smooth_roll_norm	= smoothdata(roll_norm, 'movmean', n_2s);

% with calibrated magnetic field
smooth_yaw_m_calib	= smoothdata(yaw_m_calib, 'movmean', more*n_2s);
smooth_yaw_g_calib	= smoothdata(yaw_g_calib, 'movmean', more*n_2s);
smooth_pitch_calib	= smoothdata(pitch_calib, 'movmean', n_2s);
smooth_roll_calib	= smoothdata(roll_calib, 'movmean', n_2s);

mean_yaw_m_calib	= mean(smooth_yaw_m_calib);

smooth_yaw_m_norm_calib	= smoothdata(yaw_m_norm_calib, 'movmean', more*n_2s);
smooth_yaw_g_norm_calib	= smoothdata(yaw_g_norm_calib, 'movmean', more*n_2s);
smooth_pitch_norm_calib	= smoothdata(pitch_norm_calib, 'movmean', n_2s);
smooth_roll_norm_calib	= smoothdata(roll_norm_calib, 'movmean', n_2s);



%% calib session not in the same dataset
if same_dataset == 2 % no same dataset
    calib_session_ypr = 0;
    while calib_session_ypr ~= 1 && calib_session_ypr ~= 2
	    fprintf('Do you want to compute ypr for the calibration section? \n')
	    fprintf('1 = yes \n')
	    fprintf('2 = no \n')
	
	    calib_session_ypr = input('');
    end
    if calib_session_ypr == 1
        
        %	mag_calib_postcalib = post calibration of the calibration set
        %	mag_postcalib		= post calibration of the entire dataset

        fprintf('YPR using rotated sensor measures and calibrated magnetic field \n')
        [yaw_m_calib_clbsess, yaw_g_calib_clbsess, pitch_calib_clbsess, roll_calib_clbsess, R_pose_m_calib_clbsess, R_pose_g_calib_clbsess]= YPR_comp(g_NED, D, acc_reor_calib_tot, mag_postcalib_clbsess, Fs, Fs_filter);
        
        %% smooth data
        % Windows choice is related to AAV computation, during which, by following
        % Gunner paper steps, angles are smoothed using a 2 second moving window.
        % Since our sample rate is 10Hz, we need to use a 20 samples width window.
        
        % We so have to compute:
        %		smooth_values = smoothdata(values, 'movmean', 20)
        
        if exist("n_2s", "var") == 0
            n_2s = 2*Fs;	% 2s smooth
        end
        if exist("more", "var") == 0
            more = 50;		% 100s smooth
        end
        
        % with calibrated magnetic field
        smooth_yaw_m_calib_clbsess	= smoothdata(yaw_m_calib_clbsess, 'movmean', more*n_2s);
        smooth_yaw_g_calib_clbsess	= smoothdata(yaw_g_calib_clbsess, 'movmean', more*n_2s);
        smooth_pitch_calib_clbsess	= smoothdata(pitch_calib_clbsess, 'movmean', n_2s);
        smooth_roll_calib_clbsess	= smoothdata(roll_calib_clbsess, 'movmean', n_2s);
        
    end
end

if same_dataset == 1 || (same_dataset == 2 && calib_session_ypr == 1)
    calib_session_ypr_show = 0;
    while calib_session_ypr_show ~= 1 && calib_session_ypr_show ~= 2
	    fprintf('Do you want to show ypr for the calibration section? \n')
	    fprintf('1 = yes \n')
	    fprintf('2 = no \n')
	
	    calib_session_ypr_show = input('');
    end

    if calib_session_ypr_show == 1
        
        if same_dataset == 2 % no same dataset
        
                %% YPR reoriented w.r.t. magnetic North after calibration
            figure('Name', ['figure ', num2str(id_plot),', YPR reoriented w.r.t. magnetic North - calibration session'], 'NumberTitle','off'); id_plot = id_plot + 1;
            clf
            plot(datetime_mag_calib_plot, [roll_calib_clbsess(start_id_calib:stop_id_calib), pitch_calib_clbsess(start_id_calib:stop_id_calib), yaw_m_calib_clbsess(start_id_calib:stop_id_calib)], '*', 'MarkerSize', 2)
	        grid on
	        box on
	        axis tight
	        xlabel('time','FontSize', dim_font)
	        ylabel('angle (deg)','FontSize', dim_font)
	        legend('Roll', 'Pitch', 'Yaw','FontSize', dim_font, 'Location', 'best')
	        set(gca,'FontSize', dim_font) 
	        title('YPR reoriented w.r.t. magnetic North - calibration session')
    
            figure('Name', ['figure ', num2str(id_plot),', YPR reoriented w.r.t. magnetic North - calibration dataset'], 'NumberTitle','off'); id_plot = id_plot + 1;
            clf
            plot(datetime_mag_calib, [roll_calib_clbsess, pitch_calib_clbsess, yaw_m_calib_clbsess], '*', 'MarkerSize', 2)
	        grid on
	        box on
	        axis tight
	        xlabel('time','FontSize', dim_font)
	        ylabel('angle (deg)','FontSize', dim_font)
	        legend('Roll', 'Pitch', 'Yaw','FontSize', dim_font, 'Location', 'best')
	        set(gca,'FontSize', dim_font) 
	        title('YPR reoriented w.r.t. magnetic North - calibration dataset')
        elseif same_dataset == 1 % yes same dataset

            figure('Name', ['figure ', num2str(id_plot),', YPR reoriented w.r.t. magnetic North - calibration session'], 'NumberTitle','off'); id_plot = id_plot + 1;
            clf
            plot(datetime_mag_calib_plot, [roll_calib(start_id_calib:stop_id_calib), pitch_calib(start_id_calib:stop_id_calib), yaw_m_calib(start_id_calib:stop_id_calib)], '*', 'MarkerSize', 2)
	        grid on
	        box on
	        axis tight
	        xlabel('time','FontSize', dim_font)
	        ylabel('angle (deg)','FontSize', dim_font)
	        legend('Roll', 'Pitch', 'Yaw','FontSize', dim_font, 'Location', 'best')
	        set(gca,'FontSize', dim_font) 
	        title('YPR reoriented w.r.t. magnetic North - calibration session')
        end
    end

end

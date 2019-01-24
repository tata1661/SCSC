function PARA = auto_para_apg(R,K,psf_s,b,des,precS,use_gpu,tol)
PARA = [];
PARA.verbose = des; 
PARA.precS = precS;
PARA.gpu = use_gpu;
PARA.K=K;    
PARA.psf_s = psf_s; 
PARA.psf_radius = floor( PARA.psf_s/2 );
PARA.tol = tol;
lambda_residual = 1; 
lambda_l1 = 0.1; 
%%
PARA.lambda = [lambda_residual, lambda_l1];
PARA.max_it = 100;
PARA.max_it_d=100;
PARA.max_it_z=100;

PARA.n =1;
PARA.size_ori_x = size(b);
PARA.N = size(b,3);
PARA.size_x = [size(b,1) + 2*PARA.psf_radius(1), size(b,2) + 2*PARA.psf_radius(2),PARA.n];
PARA.size_z = [PARA.size_x(1), PARA.size_x(2), PARA.K,PARA.n];
PARA.size_k = [2*PARA.psf_radius(1) + 1, 2*PARA.psf_radius(2) + 1,PARA.K]; 
PARA.size_k_full = [PARA.size_x(1), PARA.size_x(2), PARA.K]; 
PARA.kernel_size = [PARA.psf_s,PARA.K];
%% 
mul_heur = 5000;%%%%% use 5000 to recover ori.
gamma_heuristic = mul_heur* 1/(100*max(b(:)));
PARA.rho_D = gamma_heuristic;
PARA.rho_Z = gamma_heuristic;
PARA.max_it_w = 100;
PARA.rho_W = gamma_heuristic; 
PARA.R=R; % used to be baseK
PARA.size_y = [PARA.size_x(1), PARA.size_x(2), PARA.R,PARA.n];
end
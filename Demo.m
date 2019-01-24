clear
dbstop if error
%addpath(genpath('.'));
%% set para
K = 100;
Ri = 10;
psf_s=[11,11]; 
psf_radius = floor( psf_s/2 );
precS = 1;
use_gpu = 1;
verbose = 'outer';
data = 'city_10';
%data = 'fruit_10';
%% load data
load (sprintf('datasets/%s/train/train_lcne.mat',data)) %%% 
%[b] = z0u1(b);
%b=b(:,:,1);
padB = padarray(b, [psf_radius, 0], 0, 'both');

PARA= auto_para_apg(Ri, K,psf_s,b,verbose,precS,use_gpu,1e-3);
if (PARA.precS ==1)
    b = single(b);
end
if (PARA.gpu ==1)
    b = gpuArray(b);
end
%% run
t1 = tic;
[s_small,s_hat,R] = alt_min_apg(padB,PARA,b);%%%
tt = toc(t1);
%% save
repo_name = 'result';
repo_path =  sprintf('%s/%s',repo_name,data);
save_name = sprintf('R%d_K%d_psf%d',Ri,K,psf_s(1));
save_me = sprintf('%s/record_%s.mat',repo_path,save_name);
save(save_me,'s_hat','s_small','R','tt');
fprintf('Done sample-dependent CSC! --> Time %2.2f sec.\n\n', tt)


    



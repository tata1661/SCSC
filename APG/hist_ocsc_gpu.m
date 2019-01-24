function [hisA_mat,hisB_mat] = hist_ocsc_gpu(bhat,zhat, par,hisA_mat,hisB_mat,b_no)
p = prod(par.size_x);
if size(zhat,3)==par.K
   hk = par.K;
else
    hk = par.R;
end
%%
zhat_flat = reshape( zhat, p, [] );
zhatT_flat = conj(zhat_flat.'); % exactly zhat_flat'
bhat_flat = reshape(bhat,1,[]);
new_zb = reshape(zhatT_flat.*bhat_flat,hk,1,[]);
%%
clear bhat_flat bhat
if (b_no==1)
    if (par.precS ==1)
        hisA_mat = zeros(hk, hk, p,'single','gpuArray');  
    else
        hisA_mat = zeros(hk, hk, p,'gpuArray');  
    end
    hisB_mat= new_zb;
    clear new_zb
    zhatTzhat_flat = sum(conj(zhat_flat).*zhat_flat,2);
    sc1 = 1 ./(par.rho_D*(par.rho_D + zhatTzhat_flat'));
    clear zhatTzhat_flat clear zhat zhat_flat

    z_inv1 = zhatT_flat.*sc1;
    z_inv2 = conj(zhatT_flat);
    z_inv1= reshape(z_inv1,hk,1,[]);
    z_inv2 = reshape(z_inv2,1,hk,[]); 
    clear sc1 zhatT_flat zhat_flat


    if (par.precS ==1)
        it = eye(hk,'single','gpuArray')/par.rho_D;
    else
        it = eye(hk,'gpuArray')/par.rho_D;
    end
     z_inv = pagefun(@mtimes,z_inv1,z_inv2); 
     hisA_mat =it-z_inv;    
else
    hisB_mat=hisB_mat+ new_zb;
     clear new_zb
    clear zhat zhat_flat
    zhat_f = reshape(zhatT_flat,hk,1,[]);
    zhatT_f =reshape(conj(zhatT_flat),1,hk,[]); 
    down = pagefun(@mtimes,zhatT_f,hisA_mat);
    down = pagefun(@mtimes,down,zhat_f);
    down = down+1;
    up1 = pagefun(@mtimes,hisA_mat,zhat_f);
    up2 = pagefun(@mtimes,zhatT_f,hisA_mat);
    clear zhatT_flat zhatT_f zhat_f 
    updown =  up2./down;
    clear up2 down
    hisA_mat= hisA_mat-pagefun(@mtimes,up1, updown);
end
end

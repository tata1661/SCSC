function [hisA_mat,hisB_mat] = hist_ocsc_cpu(bhat,zhat, par,hisA_mat,hisB_mat,b_no)
p = prod(par.size_x);
if size(zhat,3)==par.K
   hk = par.K;
else
    hk = par.R;
end
zhat_flat = reshape( zhat, p, [] );
zhatT_flat = conj(zhat_flat.'); % exactly zhat_flat'
bhat_flat = reshape(bhat,1,[]);
new_zb = reshape(zhatT_flat.*bhat_flat,hk,1,[]);
%% for obj of D
zhat_f = reshape(zhatT_flat,hk,1,[]);
zhatT_f =reshape(conj(zhatT_flat),1,hk,[]);
%%
if (b_no==1)  
    hisA_mat = zeros(hk, hk, p); 
    if (par.precS ==1)
        hisA_mat = single(hisA_mat);
    end
    hisB_mat = new_zb;
    zhatTzhat_flat = sum(conj(zhat_flat).*zhat_flat,2);
    sc1 = 1 ./(par.rho_D*(par.rho_D + zhatTzhat_flat.'));
    clear zhatTzhat_flat clear zhat zhat_flat
    z_inv1= reshape(bsxfun(@times,zhatT_flat,sc1),hk,1,[]);
    clear sc1 zhatT_flat zhat_flat
    z_inv = mtimesx(z_inv1,zhatT_f);    
    hisA_mat =eye(hk)/par.rho_D-z_inv;
else
hisB_mat=hisB_mat+ new_zb;
clear zhat zhat_flat
down = mtimesx(zhatT_f,hisA_mat);
down = mtimesx(down,zhat_f);
down = down+1;
up1 = mtimesx(hisA_mat,zhat_f);
up2 = mtimesx(zhatT_f,hisA_mat);
clear zhatT_flat zhatT_f zhat_f 
updown  = up2./ down;
clear up2 down
hisA_mat= hisA_mat-mtimesx(up1, updown);
end
end

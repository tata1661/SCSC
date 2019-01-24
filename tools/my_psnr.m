function [ps,rmse] = my_psnr(b,Dz,par)
ndim = length(par.size_z)-2;
size_Dz = size(Dz);
it = sqrt(prod(size_Dz(1:ndim)));
p1 =20*log10(it);

ndim = length(par.size_z)-2;
pp = prod(par.size_ori_x(1:ndim));

b = reshape(b,pp,[]) ; 
Dz = reshape(Dz,pp,[]) ; 
    
for i=1:size(b,2)
        b_tmp = b(:,i);
        Dz_tmp = Dz(:,i);
        tmp =  norm((b_tmp(:) - Dz_tmp(:)));
        p2 = 20*log10(tmp);
        p(i) = p1 - p2;
end
ps=mean(p);
rmse = sqrt( 1/length(b(:)) * (tmp^2)); 
end

function [f_val,f_z,recX,d_hat,z_hat] = obj_apg(z,W,x_hat,shat_flat,par)
dhat_flat  = shat_flat*W;
d_hat= reshape(dhat_flat,par.size_x(1),par.size_x(2),[]);
z_hat = fft2(z);
Dz_hat = sum(d_hat.* z_hat,3);
recX = x_hat - Dz_hat;
%z = real(ifft2(z_hat));
f_z = par.lambda(1) * 1/2 /(par.size_z(1)*par.size_z(2))* norm(recX(:), 2)^2;
g_z = par.lambda(2) * sum( abs( z(:) ), 1 );
f_val = f_z + g_z;
end
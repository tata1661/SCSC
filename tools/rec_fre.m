function [ Dz_small,Dz] = rec_fre(d_hat,z_hat,par)
Dz = real(ifft2( reshape(sum(d_hat .* z_hat, 3), par.size_x) ));
Dz_small = x2xsmall(Dz,par);
end


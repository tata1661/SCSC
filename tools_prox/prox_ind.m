function [d_out,d_hat_out] = prox_ind( d, par)

d_proj = d2dsmall(d,par);

d_proj = prox_d_small(d_proj);

d_proj = dsmall2d(d_proj,par);

d_out = d_proj;
d_hat_out = fft2(d_proj);
end
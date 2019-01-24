function [W,s]= initWR(p)


if p.precS==1
    if p.gpu==1
    s = randn(p.kernel_size(1),p.kernel_size(2),p.R,'single','gpuArray');
    W = randn(p.R,p.K,'single','gpuArray');       
    else
    s = randn(p.kernel_size(1),p.kernel_size(2),p.R,'single');
    W = randn(p.R,p.K,'single');
    end
else
    s = randn(p.kernel_size(1),p.kernel_size(2),p.R);
    W = randn(p.R,p.K);
end
   

W = proxW_l2(W);


s = prox_d_small(s);
end
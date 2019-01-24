function [d,d_hat,s,y,i_d]=updateD_ocsc_warm(para,Ahis,Bhis,s,y,d_hat)
% admm: d,s, dual y (unscaled)
if size(d_hat,3)==para.K
   hk = para.K;
else
    hk = para.R;
end

if isempty(s)||isempty(y)
    if para.gpu==1
        if (para.precS ==1)
            s = zeros(para.size_k_full(1),para.size_k_full(2),hk,'single','gpuArray');
        else
            s = zeros(para.size_k_full(1),para.size_k_full(2),hk,'gpuArray'); 
        end
    else
        s = zeros(para.size_k_full(1),para.size_k_full(2),hk);
        if (para.precS ==1)
           s=single(s);
        end
    end
    y=s;
end
s_hat = fft2(s);
y_hat = fft2(y);

rho = para.rho_D;
h=[];
for i_d = 1:para.max_it_d
    d_hat = solve_conv_term_D(rho * s_hat-y_hat,Ahis,Bhis, para,hk);
    d = real(ifft2( d_hat ));
    sold =s;
    s = prox_ind( d + y/rho,para);
    s_hat = fft2(s);
    y = y + rho* (d - s);
    y_hat = fft2(y);
    % stopping criteria
   [r1, s1,h] = admm_stop(d,s,y,sold,rho,i_d,h);

	if  r1 && s1
        break;
    end   
end

end

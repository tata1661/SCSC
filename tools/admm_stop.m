function  [r, s,h]= admm_stop(a,b,c,bold,rho,i_d,h)
a_length = numel(a);

ABSTOL = 1e-3;
RELTOL = 1e-3; 
h.r_norm(i_d) = norm(a(:)-b(:));
h.s_norm(i_d) = norm(-rho*(b(:)-bold(:)));      
h.eps_pri(i_d)=sqrt(a_length)*ABSTOL+RELTOL*max(norm(a(:)),norm(b(:)));
h.eps_dual(i_d)=sqrt(a_length)*ABSTOL+RELTOL*norm(c(:));
r = h.r_norm(i_d) < h.eps_pri(i_d);
s = h.s_norm(i_d) < h.eps_dual(i_d);   
%     if h.r_norm(i_d)>10*h.s_norm(i_d)
%         rho = rho*2;
%     elseif h.s_norm(i_d)>10*h.r_norm(i_d)
%         rho = rho/2;
%     end 

end
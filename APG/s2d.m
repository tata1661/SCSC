function [d]= s2d(w,s,par)
ss = prod(par.size_x);
q_flat = reshape(s,ss,[]);
d_flat  = q_flat*w;
d= reshape(d_flat,size(s,1),size(s,2),[]);
end
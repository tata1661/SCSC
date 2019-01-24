function  sp = sparse_level(z,par)     
z_length = prod(par.size_z);
temp1 = z(:);
sp = length( temp1(abs(temp1)<1e-5))/z_length *100;         
end
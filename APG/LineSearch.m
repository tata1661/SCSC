function [ qz, qw, fq, osparse, step_size ] = LineSearch( vz, vw, step_size, ...
    shat_flat, par, f )


[obj_acc, ~, recx, d_hat, z_hat] = f(vz, vw);

gVZ = gradZ(recx, d_hat, par); 
gVW = gradW(recx, z_hat, shat_flat, par);

for ls = 1:50
    qz = prox_l1(vz - gVZ*step_size, par.lambda(2)*step_size);  % work in spatial domain!
    qw = proxW_l2(vw - gVW*step_size);
    [fq, osparse] = f(qz,qw);
    
    if (fq <= obj_acc)
        step_size = step_size/0.98;
        break
    else
        step_size = 0.5*step_size;
    end
 end

end


function g = gradZ(recX,d_hat,par)
tmp = -conj(d_hat).* recX;
clear d_hat recX
g = ifft2(tmp);
g = real(g);
g=  g*par.lambda(1);
end

function g = gradW(recX,z_hat,shat_flat,par)
p = par.size_z(1)*par.size_z(2); 
recX_flat = reshape(recX,p,[]);
zhat_flat =  reshape(z_hat,p,[]);
g = - shat_flat'*(recX_flat.*conj(zhat_flat));
g = real(g);
g=  g*par.lambda(1);
g = g/(par.size_z(1)*par.size_z(2));
end
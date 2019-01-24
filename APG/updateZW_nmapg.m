function [z_hat, W, z,i] = updateZW_nmapg(z,W,x_hat,s_hat,par,b)

tol =1e-6;
max_it_z = 5000;
step_size = 1; 
shat_flat = reshape(s_hat,par.size_x(1)*par.size_x(2),[]);
f = @(z,W)obj_apg(z,W,x_hat,shat_flat, par);

z0 = z;
z1 = z0;
yz = z0;

w0 = W; 
w1 = w0;
yw = w0;

obj(1) = f(z1, w1);

if strcmp(par.verbose, 'inner') || strcmp( par.verbose, 'all')
    fprintf('start update Z \n--> Obj %3.3g \n',obj(1))
end

a0 = 1;
a1 = 1;

for i = 1:max_it_z  
    tt = cputime;
    
    yz = z1 + (a0/a1) * (yz - z1) + (a0 - 1)/a1 * (z1 - z0); 
    yw = w1 + (a0/a1) * (yw - w1) + (a0 - 1)/a1 * (w1 - w0); 
    
    [ yz, yw, obj_fst, recerr, step_size ] = ...
        LineSearch( yz, yw, step_size, shat_flat, par, f );
    
   acc = obj_fst < obj(i);
    if(acc)       
        z0 = z1;
        w0 = w1;
        z1 = yz;
        w1 = yw;
        
        obj(i+1) = obj_fst;
    else
        z0 = z1;
        w0 = w1;
        
        [ z1, w1, obj_sec, recerr, step_size ] = ...
            LineSearch( z1, w1, step_size, shat_flat, par, f );
        
        obj(i+1) = obj_sec;
    end
       
     delta = (obj(i)- obj(i+1))/obj(i+1);
    if step_size<1e-10
        break
    end
     if strcmp(par.verbose, 'inner') || strcmp( par.verbose, 'all') 
        [vd_hat]= s2d(w1,s_hat,par); 
		
	    z_hat = fft2(z1);

        [recX] = rec_fre(vd_hat,z_hat,par);
		ps = my_psnr(b,recX,par); 
        fprintf('iter: %d; obj: %.3d; rec err:%.3d (dif: %.3d, acc: %d); sz:%.2d; ps:%2.2f \n', ...
            i, obj(i+1), recerr,delta, acc, step_size,ps);

     end    

    a0 = a1;
    a1 = (sqrt(4*a1^2 + 1) + 1) / 2;
        
    time(i) = cputime - tt;

    if(i>5 && abs(delta) < tol)

        break;
    end  
end 

z = z1;
z_hat = fft2(z);
W = w1;
end




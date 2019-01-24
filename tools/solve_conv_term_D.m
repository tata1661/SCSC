function dd_hat = solve_conv_term_D(sub, Ahi,Bhi, par,hk)
    sy = par.size_z(1); sx = par.size_z(2); 
    left = Bhi+permute( reshape(sub, sx * sy, 1, hk), [3,2,1] );
    clear Bhi ss_hat yy_hat
    if par.gpu==1
        x2 = pagefun(@mtimes,Ahi,left);
    else
%         for i = 1:size(Ahi,3)
%             x2(:,:,i) = Ahi(:,:,i)*left(:,:,i);
%         end
        x2 = mtimesx(Ahi,left);
    end
    clear Ahi
    dd_hat = reshape(permute(x2,[3,1,2]),sy,sx,[]);
end
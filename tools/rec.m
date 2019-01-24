function [rec]=rec(z,d,par)
rec = zeros([par.size_x(1),par.size_x(2),par.n]);
for i_n = 1:size(z,4)
    for i_k = 1:size(z,3)
        rec(:,:,i_n) = rec(:,:,i_n)+conv2(z(:,:,i_k,i_n),d(:,:,i_k),'full');
    end
end
end
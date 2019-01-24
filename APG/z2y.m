function[y]=z2y(w,z,par)
% tic
for j=1:size(z,4)
z_flat = reshape(z(:,:,:,j),size(z,1)*size(z,2),[]);   
y_flat  = z_flat*w';
y(:,:,:,j)= reshape(y_flat,size(z,1),size(z,2),[]);
end

end
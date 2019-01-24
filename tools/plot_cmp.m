function plot_cmp(x,reconstruction)
figure()
if size(x,3)~=1
    x=x(:,:,1);
    reconstruction = reconstruction(:,:,1);
 end   
    
subplot(1,2,1), imshow(x);  axis image, colormap gray, title('Orig');
subplot(1,2,2), imshow(reconstruction); axis image, colormap gray; title(sprintf('Rec'));
%psnr_see = psnr(x,reconstruction);

end
function d = dsmall2d(d_small,para)

    ndim = length( para.size_z ) - 2;
    d = padarray( d_small, [para.size_x(1:ndim) - para.psf_s, 0], 0, 'post');
    d = circshift(d, -[para.psf_radius, 0] ); 
end
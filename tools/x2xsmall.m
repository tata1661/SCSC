function x = x2xsmall(x,par)
ndim = length(par.size_z)-2;
if ndim == 2
x = x(1 + par.psf_radius(1):end - par.psf_radius(1),1 + par.psf_radius(2):end - par.psf_radius(2),:);
end

end
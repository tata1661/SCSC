function W = proxW_l2_R(W,par)
bound_norm = 1/sqrt(par.R);
q_norm = repmat( sum(W.^2, 1),size(W,1),1);
W( q_norm >= bound_norm ) = bound_norm * W( q_norm >= bound_norm ) ./ sqrt(q_norm( q_norm >= bound_norm ));
end
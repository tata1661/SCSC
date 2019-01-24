function W = proxW_l2(W)
bound_norm = 1;
q_norm = repmat( sum(W.^2, 1),size(W,1),1);
W( q_norm >= bound_norm ) = bound_norm * W( q_norm >= bound_norm ) ./ sqrt(q_norm( q_norm >= bound_norm ));
end
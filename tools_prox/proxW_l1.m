function W = proxW_l1(W,para)
for k = 1:para.K
    W(:,k) = proj_l1_ball(W(:,k));
end
end

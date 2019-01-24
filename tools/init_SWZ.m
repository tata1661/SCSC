function  [W,s_small,z] = init_SWZ(para)

    [W,s_small] = initWR(para); %% for test only
     z = randn(para.size_z);
     
    if (para.precS ==1)
        s_small = single(s_small);
        W = single(W);
        z = single(z);
    end
    if (para.gpu ==1)
        s_small = gpuArray(s_small);
        W = gpuArray(W);
        z = gpuArray(z);
    end  
    

end
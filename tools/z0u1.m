function [nb,veam,vstd] = z0u1(b)
% zero mean and unit variance
size_b=size(b);
p=prod(size_b(3:end));
vmsi = permute(reshape(double(b), [], p), [2 1]);
veam = mean(vmsi,2);
vstd = std(vmsi, 0, 2);
vmsi = (vmsi-repmat(veam, [1 size(vmsi,2)])) ./ repmat(vstd, [1 size(vmsi,2)]);
nb = reshape(vmsi', size_b);    
end

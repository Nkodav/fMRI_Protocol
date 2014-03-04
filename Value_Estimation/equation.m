
function y = equation(p, x)

refBeta = p(1);
varBeta = p(2:6);
numberObs = length(x);
items = x(:,1);
q = x(:,2);

% refBeta = 1; 

for j = 1:numberObs
    probFcn(j) = (-1)*(x(j,3)*(log(1/(1 + exp(-varBeta(items(j))*q(j) + refBeta)))) + ...
        (1-x(j,3))*(log(1 - (1/(1 + exp(-varBeta(items(j))*q(j) + refBeta))))));
end

y = sum(probFcn(1:numberObs));

save('y.mat','y');
end
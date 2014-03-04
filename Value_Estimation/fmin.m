
%you need to feed data as two-column vector called 'x'. 
%this script will call on a log-likelihood fcn called 'equation.m' that
%will report parameters as variable called 'p_fit'

options = optimset('Algorithm','interior-point'); 
options.MaxFunEvals = 4000;

load('x.mat');

p_output = zeros(19,6);
y_output = zeros(19,1);

i = 0.05;
h = 1;
while i < 1;
    p_initial = [i, i, i, i, i, i];
    [p_fit,y_val] = fmincon(@(p) equation(p, x), p_initial,[],[],[],[],[-100,-100,-100,-100,-100,-100],[1,1,1,1,1,1],[],options);
    p_output(h,:) = p_fit;
    y_output(h,1) = y_val;
    i = i + 0.05;
    h = h + 1;
end

y_max = max(y_output);
b = find(y_output == max(y_output));
c = min(b);
bestP = p_output(c,:);
bestLL = y_max;
for i = 1:length(bestP)
    bestQ(i) = bestP(i)/bestP(1);
end


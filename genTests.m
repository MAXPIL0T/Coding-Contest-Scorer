% Generate tests

tmax = 500;
tests = struct([]);
for i = 1:tmax
    len = randi(100)+20;
    x = rand(len,1);
    lim = rand*sum(x);
    tests(i).x = x;
    tests(i).lim = lim;
end

save('testsuite.mat', 'tests')
%Modified Pair Correlation Function - probability that a particle lies at
%radius r from any particle.

XIJ = RandSym(76);
N = length(XIJ);
dist = squareform(pdist(XIJ));
rmax = 20;
dr = 0.1;
rlist = linspace(0,rmax,rmax/dr);


corr = [];
for j = 1:length(rlist) - 1

%     (length(d(d >= rlist(j) & d <= rlist(j+1))) / N) / (2*pi*rlist(j)*dr);
    c = 0;
    for i = 1:N
        d = dist(i,:);
        c = c + length(d(d >= rlist(j) & d <= rlist(j+1)));
    end
    rho = (0.5 * 10*cos(pi/10)*2 * 10*sin(pi/10)*10)/N;
    c = ((c / N) / (2*pi*rlist(j)*dr)) / rho;
    corr = [corr c];
end
corr = corr / trapz(rlist(2:end-1), corr(2:end))
plot(rlist(2:end-1), corr(2:end))
ylabel("Probability density")
xlabel("r")
title("Random lattice")


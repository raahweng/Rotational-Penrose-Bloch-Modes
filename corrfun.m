%Plot Pair Correlation function
%Might not be a normalised probability density...

XIJ = RotSym(11);
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
    rho = N / (0.5 * 10*cos(pi/10)*2 * 10*sin(pi/10)*10);
    c = ((c / N) / (2*pi*rlist(j)*dr)) / rho;
    corr = [corr c];
end
plot(rlist(1:end-1), corr)


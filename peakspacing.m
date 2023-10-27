%Fabry-Perot data

data = [
0.0208042
0.0664133
0.0964193
0.135627
0.178036
0.225245
0.277656
0.334067
0.392478
0.459292
0.528106
0.60212
0.679336
0.762953
0.84937
0.939788
1.03381
1.13223
1.20864
1.31786
1.42789
1.53991
1.65593
1.77275
1.88918
1.96999
];
data1 = [
0.0236047
0.0668134
0.0964193
0.135227
0.178036
0.226045
0.278856
0.335667
0.392879
0.459292
0.536507
0.605321
0.684137
0.768554
0.856571
0.942989
1.0134
1.11862
];
s1 = scatter(0:17,data1, "blue","x")
hold on
s2 = scatter(0:25,data, "red")
hold on
plot(0:size(data)-1,data,"red")
plot(0:size(data1)-1,data1,"blue")
xlabel("Ordinal of F-P resonance")
ylabel("Frequency, Ω")
l = legend([s1,s2],"Penrose", "Periodic")
set(l, "Location", "northwest")
% hold on
% p = polyfit(0:size(data)-1,data,2);
% plot(linspace(0,25),polyval(p,linspace(0,25)))
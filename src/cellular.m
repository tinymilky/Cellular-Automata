%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A Two-Lane Cellular Automaton Traffic Flow Model with the Keep-Right Rule
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
close all;

B=3;              % The number of the lanes
plazalength=100;  % The length of the simulation highways
h=NaN;            % The handle of the image


[plaza,v]=create_plaza(B,plazalength);
h=show_plaza(plaza,h,0.1);

iterations=1000;    % Number of iterations
probc=0.1;          % Density of the cars
probv=[0.1 1];      % Density of two kinds of cars
probslow=0.3;       % The probability of random slow
Dsafe=1;            % The safe gap distance for the car to change the lane
VTypes=[1,2];       % Maximum speed of two different cars 
[plaza,v,vmax]=new_cars(plaza,v,probc,probv,VTypes);% Generate cars on the lane

size(find(plaza==1))
PLAZA=rot90(plaza,2);
h=show_plaza(PLAZA,h,0.1);
for t=1:iterations;
    size(find(plaza==1))
    PLAZA=rot90(plaza,2);
    h=show_plaza(PLAZA,h,0.1);
    [v,gap,LUP,LDOWN]=para_count(plaza,v,vmax);
    [plaza,v,vmax]=switch_lane(plaza,v,vmax,gap,LUP,LDOWN);
    [plaza,v,vmax]=random_slow(plaza,v,vmax,probslow);
    [plaza,v,vmax]=move_forward(plaza,v,vmax);
end





clear all; close all; clc;

filenums = input('Input first and last file number: (Input in array notation [X Y]\n');
stack4d = filereader(filenums(1),filenums(2));
sampling_period = 10; %in ms
[sortedcent,Labels] = LabelSort(stack4d);
% Cardioplot(Labels(:,:,:,1));
a = sortedcent(56,:,1);
b = sortedcent(34,:,1);
c = sortedcent(55,:,1);
% mid = markerplot3(a,b,c);

p = sortedcent(62,:,1);
q = sortedcent(63,:,1);[
r = sortedcent(64,:,1);

[p_list,q_list,r_list] = trackmats(p,r,q,sortedcent);
[a_list, b_list, c_list] = trackmats(a,b,c,sortedcent);

% vidwrite(a_list,b_list,c_list);



[strain2, stretch2, principal2, rot2, ap2,t2] = straintrack(a_list,b_list,c_list);
[strain, stretch, principal, rot, ap, t]=straintrack(a_list,b_list,c_list);

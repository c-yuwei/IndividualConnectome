clc; clear;
diary('log_braph2.txt');
tic
braph2genesis('braph2individualconnectome_config.m')
toc
save('test_results.mat')
diary off
clear all;
close all;
clc;

init_bilevel_toolbox();


%% Load dataset
dataset = DatasetInFolder('data/circle_dataset_single_gaussian','*_circle_original.png','*_circle_noisy.png');

%% Load input image
original = dataset.get_target(1);
noisy = dataset.get_corrupt(1);

%% Solving the Lower Level Problem
param_solver.verbose = 2;
param_solver.maxit = 2000;
param_solver.alpha = 0.1;

[sol,gap] = solve_rof_cp_single_gaussian(noisy,param_solver);

%% Plotting the solution
imagesc_gray(original,1,'Original Image');
imagesc_gray(noisy,2,'Noisy Image');
imagesc_gray(sol,3,'Denoised Image');

figure 
plot(gap);

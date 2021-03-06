%% ROF DENOISING USING GENERIC L1 L2 SOLVER
% This sample script will show how to use the generic l1 l2 solver to denoise a gray image
% using the Rudin-Osher-Fatemi (ROF) denoising model.

clear all;
close all;
clc;

% Init toolbox
init_bilevel_toolbox();

% Load dataset
dataset = DatasetInFolder('data/circle_dataset_single_gaussian','*_circle_original.png','*_circle_noisy.png');
%dataset = DatasetInFolder('data/cameraman_dataset_single_gaussian','*_cameraman_original.png','*_cameraman_noisy.png');
%dataset = DatasetInFolder('data/playing_cards','*_playing_cards_original.tif','*_playing_cards_noisy.tif');

%% Load input image
original = dataset.get_target(1);
noisy = dataset.get_corrupt(1);

%% Solving the Lower Level Problem
param_solver.verbose = 2;
param_solver.maxiter = 2000;


%% Define the cell matrices
[M,N] = size(original);
id_op = IdentityOperator([M,N]);
z = noisy;
lambda = 4.5;
gradient = FinDiffOperator([M,N],'fn');
q = zeros(M,N,2);
alpha = 1;

gamma = 0; % NO Huber regularization

%% Call the solver
[sol,gap] = solve_generic_l1_l2({lambda},{alpha},{id_op},{gradient},z,q,gamma,0*noisy,param_solver);

%% Plotting the solution
figure(1)
subplot(1,3,1)
imagesc_gray(original,1,'Original Image');
subplot(1,3,2)
imagesc_gray(noisy,1,'Noisy Image');
subplot(1,3,3)
imagesc_gray(reshape(sol,M,N),1,'Denoised Image');

figure(2)
loglog(gap);
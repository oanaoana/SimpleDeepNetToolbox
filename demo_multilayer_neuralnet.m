%clc;
clear;
close all;

%rng('default')

% set parameters
max_epoch = 30;
batch_size = 100;
opt_alg = 'AdaGrad'; % 'SGD', 'AdaGrad'
learning_rate = 0.1;


% load dateaset
dataset_dir = './datasets/';
dataset_name = 'mnist';
%dataset_name = 'orl_face';
%dataset_name = 'usps';
%dataset_name = 'coil100';
%dataset_name = 'coil20';
%dataset_name = 'cifar-100';
[x_train, t_train, train_num, x_test, t_test, test_num, class_num, dimension, ~, ~] = ...
    load_dataset(dataset_name, dataset_dir, 5000, 1000, false);


% set network
network = multilayer_neural_net(dimension, [100 80], class_num, 'relu', 'relu', 0.01, 0, 0, 0, opt_alg, 0.1);


% set trainer
trainer = trainer(network, x_train, t_train, x_test, t_test, max_epoch, batch_size, 0, 1);


% train
tic             
[info] = trainer.train(); 
elapsedTime = toc;
fprintf('elapsed time = %5.2f [sec]\n', elapsedTime);


% plot
fs = 20;
figure
plot(info.epoch_array, info.cost_array, '-', 'LineWidth',2,'Color', [255, 0, 0]/255);
ax1 = gca;
set(ax1,'FontSize',fs);
title('epoch vs. cost')
xlabel('epoch','FontName','Arial','FontSize',fs,'FontWeight','bold')
ylabel('cost','FontName','Arial','FontSize',fs,'FontWeight','bold')
legend('cost');

figure
plot(info.epoch_array, info.train_acc_array, '-', 'LineWidth',2,'Color', [0, 0, 255]/255); hold on 
plot(info.epoch_array, info.test_acc_array, '-', 'LineWidth',2,'Color', [0, 255, 0]/255); hold off 
ax1 = gca;
set(ax1,'FontSize',fs);
title('epoch vs. accuracy')
xlabel('epoch','FontName','Arial','FontSize',fs,'FontWeight','bold')
ylabel('accuracy','FontName','Arial','FontSize',fs,'FontWeight','bold')
legend('train', 'test');


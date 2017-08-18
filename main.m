% Author: Wonjooong Cheon (Sungkyunkwan university)
% Date: 2017-08-18
% Subject: Receiver Operation Characteristic Curve (ROC curve) 
%          Area Under ROC curve (AUROC)
% Column 01 :  Patient code 
% Column 02 :  Dignosis (1: Malignant tumor, 0: Benign tumor)
% Column 03 :  Screening mehod 01 
% Column 04 :  Screening mehod 02 

clc
clear
close all
%%
ROC_curve_data = xlsread('ROC_curve_data.xlsx');
cancer_trueNfalse = ROC_curve_data(:,2);
screening_method_1 = ROC_curve_data(:,3);
screening_method_2 = ROC_curve_data(:,4);
%%
cancer_true_index = find(cancer_trueNfalse==1);
cancer_ture_num  = size(cancer_true_index,1);
%
cancer_false_index = find(cancer_trueNfalse==0);
cancer_false_num = size(cancer_false_index, 1);
%
min_screeing = min([screening_method_1 ; screening_method_2]);
max_screeing = max([screening_method_1 ; screening_method_2]);
%
%%
iter_value = min_screeing : 1 : max_screeing;
sensitivity_screening_method_1 = zeros(1,size(iter_value,2));
specificity_screening_method_1 = zeros(1,size(iter_value,2));

screening_method = screening_method_1;
for iter1 = 1: size(iter_value,2)
    creterion_value = iter_value(iter1);
    positive_index = find(screening_method>=creterion_value);
    [Lia,Locb] = ismember(cancer_true_index, positive_index);
    Lia(Lia==0) = [];
    true_positive_num = size(Lia,1);
    false_negative_num = cancer_ture_num - true_positive_num;
    %
    negative_index = find(screening_method<creterion_value);
    [Lia_negative,Locb_negative] = ismember(cancer_false_index, negative_index);
    Lia_negative(Lia_negative==0) = [];
    ture_negative_num = size(Lia_negative,1);
    false_positive_num = cancer_false_num - ture_negative_num;
    %
    sensitivity_screening_method_1(iter1) = true_positive_num/(true_positive_num+false_negative_num);
    specificity_screening_method_1(iter1) = ture_negative_num/(ture_negative_num+false_positive_num);
end

%%
sensitivity_screening_method_2 = zeros(1,size(iter_value,2));
specificity_screening_method_2 = zeros(1,size(iter_value,2));

screening_method = screening_method_2;
for iter1 = 1: size(iter_value,2)
    creterion_value = iter_value(iter1);
    positive_index = find(screening_method>=creterion_value);
    [Lia,Locb] = ismember(cancer_true_index, positive_index);
    Lia(Lia==0) = [];
    true_positive_num = size(Lia,1);
    false_negative_num = cancer_ture_num - true_positive_num;
    %
    negative_index = find(screening_method<creterion_value);
    [Lia_negative,Locb_negative] = ismember(cancer_false_index, negative_index);
    Lia_negative(Lia_negative==0) = [];
    ture_negative_num = size(Lia_negative,1);
    false_positive_num = cancer_false_num - ture_negative_num;
    %
    sensitivity_screening_method_2(iter1) = true_positive_num/(true_positive_num+false_negative_num);
    specificity_screening_method_2(iter1) = ture_negative_num/(ture_negative_num+false_positive_num);
end
%%
figure(1), plot(1- specificity_screening_method_1,sensitivity_screening_method_1,'b'), hold on
plot(1- specificity_screening_method_2,sensitivity_screening_method_2,'r'), 
plot(0:0.01:1,0:0.01:1,'k--'), grid on, axis equal, xlim([0 1]), ylim([0 1])
legend('Screening method 01', 'Screening method 02', 'reference line')
%%
[C,ia,ic] = unique(1- specificity_screening_method_1);
width_screening_1 = diff(C);
height_screening_1 = sensitivity_screening_method_1(ia);
auroc_val_method01 = sum(width_screening_1.*height_screening_1(1:end-1));
%%
[C,ia,ic] = unique(1- specificity_screening_method_2);
width_screening_2 = diff(C);
height_screening_2 = sensitivity_screening_method_2(ia);
auroc_val_method02 = sum(width_screening_2.*height_screening_2(1:end-1));
%
figure(1), title(sprintf('AUROC METHOD 01: %1.4f\n AUROC METHOD 02: %1.4f',auroc_val_method01,auroc_val_method02))

































%% Main Performance
clc;
clear all;
close all;
load FeaturesHog;
InputImage=[];
Acc=[];

%% Training Phase
% features = [Mean,Var,Skewness,Kurtosis,Entropy,Energy];
load group;
wxtrain=[FeaturesHog(:,2),FeaturesHog(:,4)];
wSVMStruct = svmtrain(wxtrain,group,'kernel_function','polynomial','Polyorder',12,'showplot',true);
wNB = NaiveBayes.fit(wxtrain,group,'dist','normal');

%% Testing Phase
[filename pathname] = uigetfile({'*.jpg'},'File Selector');
Image = strcat(pathname, filename);
A=double(filename(1:2))-48;

if A(2)>=0
   Index=A(1)*10+A(2);
else
   Index=A(1);
end

wtest=[FeaturesHog(Index,2),FeaturesHog(Index,4)];
%% SVM Classifier    
wspecies_svm = svmclassify(wSVMStruct,wtest);
%% Naive Bayes Classifier
[post,wspecies_nb]=posterior(wNB,wtest);
%% Outputs
disp('Image According to SVM');
disp(wspecies_svm);
disp('Image According to NB');
disp(wspecies_nb);
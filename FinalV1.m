clear; close all; clc;

pkg load statistics;

X_orig = csvread('creditcard.csv'); %Load the data-set

X = X_orig(2:end, :); %Store data-set without headers in X

Y = X(:, end); %Create vector Y of labels (1 for positive 0 for negative)

Time = X(:, 1); %Create vector Time that contains the time

X_t = X(:, 1:end - 1); %Store data-set without labels and headers in X_t

Xam = X_t(:, 2:end); %Store data-set without labels, headers, and time in Xam

Xam(:, [1, 8, 13, 15, 19 : 28]) = []; %Drop V1 because it does not follow a normal distribution, V8, V13, V15 and V19 to V28 because the fraudulent features are near identical to the normal ones so we gain no knowledge from these features.

amount = Xam(:, end); %Store amounts in vector amount

idxzero = find(amount == 0); %Find the transactions that were worth 0

X = Xam(:, 1:end - 1); %Store data-set without labels, headers, time, and amount in X

amount(idxzero) = []; %delete amounts that are equal to 0

Xam(idxzero, :) = []; %delete transactions whose amounts equal to 0

Yam = Y; Yam(idxzero) = []; %create a vector of labels for the second data-set

amountLog = log(amount); %Log transform the feature amount

Xam(:, end) = amountLog; %replace the feature amount with its log transformation

[m n] = size(X); [mam nam] = size(Xam); %Dimensions of data-sets

q = randperm(m); qam = randperm(mam); %randomize indices to shuffle data-sets

X = X(q, :); Y = Y(q); Xam = Xam(qam, :); Yam = Yam(qam); %shuffle data-sets

idxpos = find(Y == 1); idxposam = find(Yam == 1); %Find the fraudulent transactions

XClean = X; XClean(idxpos, :) = []; [mC nC] = size(XClean); %Create data-set of only normal transactions and find its dimensions

YClean = Y; YClean(idxpos) = [];

XamClean = Xam; XamClean(idxposam, :) = []; [mamC namC] = size(XamClean); %Create data-set of only normal transactions and find its dimensions

YamClean = Yam; YamClean(idxposam) = [];

XFraud = X(idxpos, :); [mF nF] = size(XFraud); %Create data-set of fraudulent transactions

YFraud = Y(idxpos);

XamFraud = Xam(idxposam, :); [mamF namF] = size(XamFraud); %Create data-set of fraudulent transactions

YamFraud = Yam(idxposam);

Xtrain = XClean(1 : mC * 0.6, :); [mT nT] = size(Xtrain); %Training set with 60% of normal data

XamTrain = XamClean(1 : floor(mamC * 0.6), :); [mamT namT] = size(XamTrain); %Training set with 60% of normal data

Xcv = XClean(mC * 0.6 + 1 : mC * 0.8, :); Xcv = [Xcv; XFraud(1 : mF/2, :)]; [mCV nCV] = size(Xcv); %CV set with 20% of normal data and 50% of fraudulent data

Ycv = YClean(mC * 0.6 + 1 : mC * 0.8); Ycv = [Ycv; YFraud(1 : mF/2)];

XamCV = XamClean(ceil(mamC * 0.6) : floor(mamC * 0.8), :); XamCV = [XamCV; XamFraud(1 : floor(mamF/2), :)]; [mamCV namCV] = size(XamCV); %CV set with 20% of normal data and 50% of fraudulent data

YamCV = YamClean(ceil(mamC * 0.6) : floor(mamC * 0.8)); YamCV = [YamCV; YamFraud(1 : floor(mamF/2))];

Xtest = XClean(mC * 0.8 + 1 : end, :); Xtest = [Xtest; XFraud(mF/2 + 1 : end, :)]; [mTest nTest] = size(Xtest); %Test set with 20% of normal data and 50% of fraudulent data

Ytest = YClean(mC * 0.8 + 1 : end); Ytest = [Ytest; YFraud(mF / 2 + 1 : end)];

XamTest = XamClean(ceil(mamC * 0.8) : end, :); XamTest = [XamTest; XamFraud(ceil(mamF / 2) : end, :)]; [mamTest namTest] = size(XamTest); %Test set with 20% of normal data and 50% of fraudulent data

YamTest = YamClean(ceil(mamC * 0.8) : end); YamTest = [YamTest; YamFraud(ceil(mamF / 2) : end)];

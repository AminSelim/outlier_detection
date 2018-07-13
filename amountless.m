[mu SIGMA] = estimateGaussian(Xtrain); %Find the maximum likelihood estimators

p = multivariategaussian(Xtrain, mu, SIGMA); %Find the vector of probability density function values of the training set

pcv = multivariategaussian(Xcv, mu, SIGMA); %Find the vector of probability density function values of the CV set

ptest = multivariategaussian(Xtest, mu, SIGMA); %Find the vector of probability density function values of the test set§

disp('Minimum probability in the training set: '), min(p),

disp('2nd minimum probability in the training set: '), min(p(find(p > 0))),

disp('Maximum probability in the training set: '), max(p),

disp('Minimum probability in the cross-validation set: '), min(pcv),

disp('2nd minimum probability in the cross-validation set: '), min(pcv(find(pcv > 0))),

disp('Maximum probability in the cross-validation set: '), max(pcv),

disp('Minimum probability in the test set: '), min(ptest),

disp('2nd minimum probability in the test set: '), min(ptest(find(ptest > 0))),

disp('Maximum probability in the test set: '), max(ptest),

[threshold Precision Recall F1score F1h precisionh recallh epsilonh] = selectThreshold(Ycv, pcv); %Calculate the cutoff probability, F1-score, Precision and recall

disp('Cutoff probability using p-values from the CV set: '), threshold,
disp('Precision: '), Precision,
disp('Recall: '), Recall,
disp('F1-score: '), F1score,

plog = p;

plog(find(plog == 0)) = min(plog(find(plog > 0)));

plog = log(plog);

pcvlog = pcv;

pcvlog(find(pcvlog == 0)) = min(pcvlog(find(pcvlog > 0)));

pcvlog = log(pcvlog);

[thresholdl Precisionl Recalll F1scorel F1hl precisionhl recallhl epsilonhl] = selectThreshold(Ycv, pcvlog); %Calculate the cutoff probability, F1-score, Precision and recall

disp('Cutoff probability using log-transformed p-values from the CV set: '), thresholdl,
disp('Precision: '), Precisionl,
disp('Recall: '), Recalll,
disp('F1-score: '), F1scorel

[Precisiont Recallt F1t tpt fpt fnt tnt] = test_set(Ytest, ptest, threshold); %test the original cutoff probability against the test set

disp('Precision of the original cutoff probability found from the CV set on the test set: '), Precisiont,
disp('Recall: '), Recallt,
disp('F1-score: '), F1t,

ptestlog = ptest;

ptestlog(find(ptestlog == 0)) = min(ptestlog(find(ptestlog > 0)));

ptestlog = log(ptestlog);

[Precisiontl Recalltl F1tl tptl fptl fntl tntl] = test_set(Ytest, ptestlog, thresholdl);

disp('Precision of the log-transformed cutoff probability found from the CV set on the test set: '), Precisiontl,
disp('Recall: '), Recalltl,
disp('F1-score: '), F1tl,

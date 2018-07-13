[muam SIGMAam] = estimateGaussian(XamTrain); %Find the maximum likelihood estimators

pam = multivariategaussian(XamTrain, muam, SIGMAam); %Find the vector of probability density function values of the training set

pamCV = multivariategaussian(XamCV, muam, SIGMAam); %Find the vector of probability density function values of the CV set

pamTest = multivariategaussian(XamTest, muam, SIGMAam); %Find the vector of probability density function values of the test set§

disp('The minimum p-value in the training set: '), min(pam),

disp('The second minimum p-value in the training set: '), min(pam(find(pam > 0))), %Get some information about p

disp('The maximum p-value in the training set: '), max(pam)

disp('The minimum p-value in the cross-validation set: '), min(pamCV),

disp('The second minimum p-value in the cross-validation set: '), min(pamCV(find(pamCV > 0))),

disp('The maximum p-value in the cross-validation set: '), max(pamCV), %Get some information about pcv

disp('The minimum p-value in the test set: '), min(pamTest),

disp('The second minimum p-value in the test set: '), min(pamTest(find(pamTest>0))),

disp('The maximum p-value in the test set: '), max(pamTest),

[thresholdam Precisionam Recallam F1scoream F1ham precisionham recallham epsilonham] = selectThreshold(YamCV, pamCV); %Calculate the cutoff probability, F1-score, Precision and recall

disp('The cutoff probability using the p-values from the CV set: '), thresholdam,

disp('Precision: '), Precisionam,

disp('Recall: '), Recallam,

disp('F1-score: '), F1scoream,

pamLog = pam;

pamLog(find(pamLog == 0)) = min(pamLog(find(pamLog > 0)));

pamLog = log(pamLog);

pamCVlog = pamCV;

pamCVlog(find(pamCVlog == 0)) = min(pamCVlog(find(pamCVlog > 0)));

pamCVlog = log(pamCVlog);

[thresholdlam Precisionlam Recalllam F1scorelam F1hlam precisionhlam recallhlam epsilonhlam] = selectThreshold(YamCV, pamCVlog); %Calculate the cutoff probability, F1-score, Precision and recall

disp('The cutoff probability using the log-transformed p-values from the CV set: '), thresholdlam,

disp('Precision: '), Precisionlam,

disp('Recall: '), Recalllam,

disp('F1-score: '), F1scorelam

[Precisiontam Recalltam F1tam tptam fptam fntam tntam] = test_set(YamTest, pamTest, thresholdam); %test the original cutoff probability against the test set

disp('Precision of cutoff probability obtained from original CV set p-values on the test set: '), Precisiontam,

disp('Recall: '), Recalltam,

disp('F1-score: '), F1tam,

pamTestlog = pamTest;

pamTestlog(find(pamTestlog == 0)) = min(pamTestlog(find(pamTestlog > 0)));

pamTestlog = log(pamTestlog);

[Precisiontlam Recalltlam F1tlam tptlam fptlam fntlam tntlam] = test_set(YamTest, pamTestlog, thresholdlam);

disp('Precision of cutoff probability obtained from log-transformed CV set p-values on the test set: '), Precisiontlam,

disp('Recall: '), Recalltlam,

disp('F1-score: '), F1tlam,

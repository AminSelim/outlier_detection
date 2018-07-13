# outlier_detection
This is a learning algorithm that takes as input credit card transactions of a particular format and decides whether they are fraudulent or not. 
Download the data-set here https://www.kaggle.com/mlg-ulb/creditcardfraud

This code was originally written in Octave but should be compatible with MATLAB as well. 

We assign a probability value to each transaction. This is the probability that the transaction is normal. The algorithm chooses a cutoff probability under which a transaction is deemed fraudulent. Success is measured with F1-score. 

Run FinalV1 on Octave/MATLAB to load the data

Run amountfull and amountless to train the model

Use test_set to test the epsilon chosen on the test set. 

Email me @ aeselim@aucegypt.edu if you have any questions. 

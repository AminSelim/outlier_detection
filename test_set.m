function [Prec Rec F1 tp fp fn tn] = test_set(yval, pval, eps)

predictions = (pval < eps);
tp = sum(predictions == 1 & yval == 1);
fp = sum(predictions == 1 & yval == 0);
fn = sum(predictions == 0 & yval == 1);
tn = sum(predictions == 0 & yval == 0);
if (tp + fp + fn == 0)
  Prec = 1;
  Rec = 1;
  F1 = 1;
elseif (tp == 0)
  Prec = 0;
  Rec = 0;
  F1 = 0;
else
  Prec = tp / (tp + fp);
  Rec = tp / (tp + fn);
  F1 = 2 * Prec * Rec / (Prec + Rec);
end

end

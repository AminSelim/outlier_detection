function [bestEpsilon bestPrec bestRec bestF1 F1h precisionh recallh epsilonh] = selectThreshold(yval, pval)

bestF1 = 0; precision = 0; recall = 0; f1 = 0; bestEpsilon = 0; F1h = []; epsilonh = [];
precisionh = []; recallh = []; bestPrec = 0; bestRec = 0;
ss = (max(pval) - min(pval))/200000;
for epsilon = min(pval) : ss : max(pval)
  predictions = (pval < epsilon);
  tp = sum(predictions == 1 & yval == 1);
  fp = sum(predictions == 1 & yval == 0);
  fn = sum(predictions == 0 & yval == 1);
  if (tp + fp + fn == 0)
    precision = 1;
    recall = 1;
    f1 = 1;
  elseif (tp == 0)
    precision = 0;
    recall = 0;
    f1 = 0;
  else
    precision = tp / (tp + fp);
    recall = tp / (tp + fn);
    f1 = 2 * precision * recall / (precision + recall);
  end

  F1h = [F1h f1]; precisionh = [precisionh precision]; recallh = [recallh recall];
  if f1 > bestF1
    bestF1 = f1;
    bestEpsilon = epsilon;
    bestRec = recall;
    bestPrec = precision;
  end
  epsilonh = [epsilonh epsilon];
end
end

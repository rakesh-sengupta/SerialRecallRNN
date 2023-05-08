clear
params = setparams;
nstim = 50:50:300;


nrun = 100;

recall_prob = zeros(numel(nstim),params.ninputs);

for i = 1: numel(nstim)
    params.nstim = nstim(i);
    for j = 1:nrun
        results = serialWM(params);
        check = (results.x(results.b,params.nt))';
        b = find(check <0.1);
        check(b) = 0;
        b = find(check > 0.1);
        check(b) = 1;
        recall_prob(i,:) = recall_prob(i,:) +check/nrun;
    end
    i
end

figure;
bar(1:params.ninputs,mean(recall_prob))
hold on
er = errorbar(1:params.ninputs,mean(recall_prob),std(recall_prob)/sqrt(numel(nstim)),'linewidth',2);
er.Color = [0 0 0];                            
er.LineStyle = 'none';
xlabel('Item Order (earliest to latest)')
ylabel('Recall Probability')
title('Serial recall')

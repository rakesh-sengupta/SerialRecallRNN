params = setparams;
nstim = 50:50:1000;


nrun = 100;

mean_recall_prob = zeros(params.ninputs,params.ninputs);

for k = 1:params.ninputs
    
    recall_prob = zeros(numel(nstim),params.ninputs);

    for i = 1: numel(nstim)
        params.nstim = nstim(i);
        for j = 1:nrun
            results = serialWM(params,k);
            check = (results.x(results.b,params.nt))';
            b = find(check <0.1);
            check(b) = 0;
            b = find(check > 0.1);
            check(b) = 1;
            recall_prob(i,:) = recall_prob(i,:) +check/nrun;
        end
        i
    end
    mean_recall_prob(k,:) = mean(recall_prob);
end

figure;
%errorbar(1:params.ninputs,mean(recall_prob),std(recall_prob)/sqrt(numel(nstim)),'linewidth',2)
plot(1:params.ninputs,mean_recall_prob','linewidth',2)
xlabel('Item Order (earliest to latest)')
ylabel('Recall Probability')
title('Serial recall')

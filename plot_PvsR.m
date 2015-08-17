function [] = plot_PvsR()
%     [Xpr,Ypr,Tpr,AUCpr] = perfcurve(recallVals, precisionVals, 1, 'xCrit', 'reca', 'yCrit', 'prec');
%     openfig('surf_f1.fig')
    figure
%     hold on
    plot(iterVals,f1Vals,'b')
    legend('Stage 1&2 positives','Location','southeast')
%     hold off
    title('F1 Measure vs Iterations - HRiding Replace Positives(>=50%)')
    xlabel('Iterations'); ylabel('F1 Measure')
%     savefig('surf_f1.fig');
end
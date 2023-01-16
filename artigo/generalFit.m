
% This allows us to map correctly a simulated time with our actual data
endTime = ElapsedTimeseconds(end);
timePoints = length(ElapsedTimeseconds);
dt = endTime/timePoints;


%======ADJUST PARAMETERS HERE======
fitParams = {'power'};
guess = [5];
% the program automagically adjusts number of fit variables and stuff


    
errorVectorT1 = @(x) (getTemperatureVector(0, endTime,dt,fitParams, x) - T1);
errorVectorT2 = @(x) (getTemperatureVector(0.075, endTime,dt,fitParams, x) - T2);
errorVectorT3 = @(x) (getTemperatureVector(0.15, endTime,dt,fitParams, x) - T3);
errorVectorT4 = @(x) (getTemperatureVector(0.2250, endTime,dt,fitParams, x) - T4);

errorLeastSquares = @(x) sum(errorVectorT1(x).^2);
            




initialGuess = getTemperatureVector(0.075, endTime, dt, fitParams, guess);
hold on;
plot(ElapsedTimeseconds, T1, 'r');
%plot(ElapsedTimeseconds, T2, 'g');
%plot(ElapsedTimeseconds, T3, 'b');
%plot(ElapsedTimeseconds, T4, 'k');
title('Initial Guess');
hold off;

figure;



disp(['=========FIT STARTING: ' datestr(now) '============'])

disp('Looking for ');
for paramNum = 1:length(fitParams)
    disp([fitParams{paramNum} ', with guess ' num2str(guess(paramNum))]);
end

disp(['Guess Error: ' num2str(errorLeastSquares(guess))]);

start = tic;

disp('...');

[params,fval] = fminsearch(errorLeastSquares,guess);

for paramNum = 1:length(fitParams)
    disp([fitParams{paramNum} ': ' num2str(params(paramNum))]);
end

disp(['Fit Error: ' num2str(fval)]);

disp(['Time Elapsed: ' num2str(toc(start))]);

disp(['=========FINISHED: ' datestr(now) '===========']);

hold on;
plot(ElapsedTimeseconds, T1, 'r');
%plot(ElapsedTimeseconds, T2, 'g');
%plot(ElapsedTimeseconds, T3, 'b');
%plot(ElapsedTimeseconds, T4, 'k');
title('Fitted Curve');
hold off;


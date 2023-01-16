function temperatureAtDistance = getTemperatureVector( varargin )
% First input is your distance
% Next two inputs are Time and dt
% Next is a cell array of param names, followed by a double array of
% guesses

distanceIndex = getDistanceIndex(varargin{1});


if length(varargin) == 1
    tempMatrix = getTemperatureGradient;
else
    endTime = varargin{2};
    dt = varargin{3};
    fitParams = varargin{4};
    guess = varargin{5};
    % Making a flexible input based on variable number of fitParams
    input = {endTime, dt};
    for paramNum = 1:length(fitParams)
        input = [input, fitParams{paramNum}];
        input = [input, guess(paramNum)]; 
    end

    tempMatrix = getTemperatureGradient(input{:});
end

temperatureAtDistance = tempMatrix(:, distanceIndex);


end
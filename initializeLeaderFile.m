% Initialize CSV file
% The headings for the allSolvers.csv file are
% - t
% - result
% - computeTime
% - score
% - author
% - commit hash

t = datetime("now");
result = inf;
computeTime = inf;
score = inf;
author = "NA";
commit = "NA";

ttLeaders = timetable(t, result, computeTime, score, author, commit);
writetimetable(ttLeaders,"allSolvers.csv")
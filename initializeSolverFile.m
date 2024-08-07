% Initialize CSV file
result = inf;
computeTime = inf;
score = inf;
commit = 0;
t = datetime("now");

ttLeaders = timetable(t, result, computeTime, score, commit);
writetimetable(ttLeaders,"leaders.csv")

writetimetable(ttLeaders,"allSolvers.csv")
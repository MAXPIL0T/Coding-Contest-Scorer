function processSolver(commitActor,commitHash)

    t = datetime("now");
    [result,computeTime] = testSolver();
    score = calculateScore(result,computeTime);
    author = commitActor;
    commit = commitHash;

    % Make the new table that correponds to the most recently tested file
    tt = timetable(t, result, computeTime, score, author, commit);

    ttAll = readtimetable("allSolvers.csv");
    ttAll = [ttAll; tt];
    writetimetable(ttAll,"allSolvers.csv")

    matlab.internal.liveeditor.executeAndSave('report.mlx')
    export("report.mlx","report.md")

end
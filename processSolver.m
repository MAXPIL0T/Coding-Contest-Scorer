function [score, highestScore] = processSolver(commitActor,commitHash)

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

    data = readtable("allSolvers.csv");
    scores = data.score;
    scores(strcmp(scores, 'Inf') | strcmp(scores, 'NA')) = {NaN};
    scores = cellfun(@str2double, scores);
    highestScore = max(scores, [], 'omitnan');

    matlab.internal.liveeditor.executeAndSave('report.mlx')
    export("report.mlx","report.md")
end
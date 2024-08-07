% Re-score
fname = "allSolvers.csv";
ld = readtimetable(fname);
ld.score = calculateScore(ld.result,ld.computeTime);
ld
writetimetable(ld,fname)
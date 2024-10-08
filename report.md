
# Contest Report
```matlab
% Read in the list of all solvers
solvers = readtimetable("allSolvers.csv");

% Get rid of bad entries
% The result may be infinite or negative. Neither is a good state.
ix = isinf(solvers.result)|(solvers.result<0);
solvers(ix,:) = [];
```

Here is the list of all the solvers

```matlab
solvers
```
| |t|result|computeTime|score|author|commit|
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|1|07-Aug-2024 17:40:34|103.1756|0.2825|544.1268|'MAXPIL0T'|'e40e8a6b1ac3ec055b2fd92398bd616a01a589de'|
|2|07-Aug-2024 18:35:16|103.1756|0.2302|538.8991|'MAXPIL0T'|'210f97a3c6ade05db23fa4d2ebb8ee12c0c0ad89'|
|3|16-Aug-2024 14:49:39|103.1756|0.3678|552.6548|'MAXPIL0T'|'210f97a3c6ade05db23fa4d2ebb8ee12c0c0ad89'|

```matlab
plot(solvers.computeTime,solvers.result,"-o")
```

![figure_0.png](report_media/figure_0.png)

```matlab
plot(solvers.t,solvers.result,"-o")
```

![figure_1.png](report_media/figure_1.png)

Calculate leaders

```matlab
bestScore = inf;
ixLeader = zeros(height(t),1);
```

```matlabTextOutput
Unrecognized function or variable 't'.
```

```matlab
for i = 1:height(solvers)
    if solvers.score(i) < bestScore
        ixLeader(i) = 1;
        bestScore = solvers.score(i);
    end
end

leaders = solvers(ixLeader,:)

```

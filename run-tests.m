name: Run MATLAB Tests

on:
  repository_dispatch:
    types: [test-suite]

jobs:
  run-tests:
    runs-on: windows-latest

    steps:
    - name: Checkout repository
      uses: actions/checkout@v4

    - name: Set up MATLAB
      uses: matlab-actions/setup-matlab@v2

    - name: Run custom testing procedure
      id: run-tests
      uses: matlab-actions/run-command@v2
      with:
        command: |
          disp('Running my task'); 
          score = processSolver("${{ github.event.client_payload.actor }}", "${{ github.event.client_payload.sha }}");
          fid = fopen('result.txt', 'wt');
          fprintf(fid, 'Score: %d\n', score);
          fclose(fid);

    - name: Get test score
      id: get-score
      run: |
        score=$(grep 'Score:' result.txt | awk '{print $2}')
        echo "::set-output name=score::$score"

    - name: Checkout repo1
      uses: actions/checkout@v4
      with:
        repository: MAXPIL0T/Coding-Contest
        token: ${{ secrets.GH_TOKEN }}
        path: repo1

    - name: Update score in repo1
      run: |
        cd repo1
        echo "${{ github.event.client_payload.pr_number }},${{ steps.get-score.outputs.score }}" >> scores.csv
        git config --global user.email "github-actions@github.com"
        git config --global user.name "GitHub Actions"
        git add scores.csv
        git commit -m "Update scores"
        git push

    - name: Check if the score is higher
      id: check-score
      run: |
        previous_high_score=$(cat repo1/scores.csv | awk -F, 'BEGIN {max=0} {if ($2 > max) max=$2} END {print max}')
        if [ ${{ steps.get-score.outputs.score }} -gt $previous_high_score ]; then
          echo "The new score is higher"
          echo "::set-output name=accept_pr::true"
        else
          echo "The new score is not higher"
          echo "::set-output name=accept_pr::false"

    - name: Accept or reject PR
      if: steps.check-score.outputs.accept_pr == 'true'
      run: |
        curl -X PUT -H "Authorization: token ${{ secrets.GH_TOKEN }}" \
          -H "Accept: application/vnd.github.v3+json" \
          https://api.github.com/repos/MAXPIL0T/Coding-Contest/pulls/${{ github.event.client_payload.pr_number }}/merge \
          -d '{"commit_title":"Merging PR as new score is higher"}'

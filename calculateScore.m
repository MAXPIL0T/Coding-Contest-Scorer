function score = calculateScore(result,computeTime)
    % The score is based on both the result and the computeTime. 

    if result > 0 
        k_result = 5;
        k_computeTime = 100;
        score = k_result*result + k_computeTime*computeTime;
    else
        score = -1;
    end

end
function [ logMask ] = create_log_filter( omg, size )

logMask = zeros(size,size);

intPart = fix(size/2);

    for i = -intPart:intPart
        for j = -intPart:intPart
            logMask(i+1+intPart, j+1+intPart) =  (-1/(pi*(omg^4))) * (1-((i^2)+(j^2))/(2*(omg^2))) * exp(-((i^2)+(j^2))/(2*(omg^2)));
        end
    end
    
    logMask = logMask - mean(logMask(:));
end


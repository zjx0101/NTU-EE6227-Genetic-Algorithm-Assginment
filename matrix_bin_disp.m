function matrix_out = matrix_bin_disp(matrix)
matrix_out = zeros(3,10);
for i=1:3
    for j=1:10
        ele = dec2bin(matrix(i,j)+1024);
        ele = ele(2:11);
        fprintf(ele);
        fprintf(' ')
    end
        fprintf('\n')
end
fprintf('\n')
end


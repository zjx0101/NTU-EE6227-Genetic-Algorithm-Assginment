clc;
seeds = [181,637,962,726,680,199,478,541,540,266,121,963,294,798,673,185,440,91,497,892,97,200,978,894,373,74,119,419,939,214,252,190,333,27,932,200,661,4,7,406,586,314,26,882,405,426,673,583,697,116,716,284,89,817,504,779,512,606,939,36,498,247,532,731,537,503,859,331,967,891,154,335,725,834,639,657,880,922,82,516,430,954,463,721,488,533,135,143,173,964,569,10,576,800,46,211,871,619,187,570,171,947,852,523,808,12,789,875,852,845,674,874,237,935,728,899,649,791,136,516,151,243,884,276,11,594,360,998,240,565,699,471,17,78,493,268,602,476,261,997,613,197,377,654,135,759,284,110,488,696,653,480,671,285,402,743,973,132,529,172,940,159,749,135,359,407,961,210,864,684,67,778,911,943,709,793,874,957,1,881,432,796,311,127,726,849,108,938,345,329,333,678,608,834,154,532,921,42,159,169];
matric = 683;
end_epoch = 300;
mate_per_epoch = 5;
start = mod(matric,100);
index = start;

a1 = randi([0,1024],[3,10]);
% a1 = [-6.1584,-13.7048,-13.5484,11.3196,-12.6882,-8.8172,-4.8289,-11.7889,-11.9844, 1.8182;
% 13.9785, 0.3715, 5.4545,-9.4037,-2.0919,17.3412, 3.7341, 8.9736,13.7830, 1.1535;
% -13.5875, 4.1642,13.8221,-7.4096,-6.9404,-4.0078,-17.2630, 3.0303,-3.0303,-12.6100]
% a1 = floor((a1+20)/40 * 1024)
disp('The starting binary:');
matrix_bin_disp(a1);
all_gene = a1;
a2 = normal(a1);
disp('The starting dec:');
disp(a2)
all_gene_norm = a2;
fitness = [];
for i=1:10
    fitness = [fitness,ack(a2(1,i),a2(2,i),a2(3,i))];
end
all_fitness = fitness;
disp('The starting fitness:');
disp(fitness);
mean_fitness = mean(fitness);
disp('The mean of starting fitness:');
disp(mean_fitness);

for epoch=1:end_epoch
    child_epoch = [];
    child_norm_epoch = [];
    child_fitness_epoch = [];
    num = length(all_fitness);
    sum = 0;
    for i=1:num
        sum = sum + all_fitness(i);
    end
    fit = 25 - all_fitness;

    sum = 0;
    for i=1:num
        sum = sum + fit(i);
    end
    fit = fit/sum;
    disp('The proportion of each fitness:');
    disp(fit);
    fprintf('epoch:%d\n',epoch);
    for child_num=1:mate_per_epoch
        seed = seeds(index);
        disp('current seed:');
        disp(seed);
        index = forward(index);
        pro = seed/1000;
        sum_pro = 0;
        for i=1:num
            sum_pro = sum_pro+fit(i);
            if sum_pro>pro
                break;
            end
        end
        p1_index = i;

        seed = seeds(index);
        index = forward(index);
        disp('current seed:');
        disp(seed);
        pro = seed/1000;
        num = length(fit);
        sum_pro = 0;
        for i=1:num
            sum_pro = sum_pro+fit(i);
            if sum_pro>pro
                break;
            end
        end
        p2_index = i;

        seed = seeds(index);
        index = forward(index);
        disp('current seed:');
        disp(seed);

        p1_1 = dec2bin(a1(1,p1_index)+1024);
        p1_1 = p1_1(2:11);
        p1_2 = dec2bin(a1(2,p1_index)+1024);
        p1_2 = p1_2(2:11);
        p1_3 = dec2bin(a1(3,p1_index)+1024);
        p1_3 = p1_3(2:11);
        p1 = [p1_1,p1_2,p1_3];

        p2_1 = dec2bin(a1(1,p2_index)+1024);
        p2_1 = p2_1(2:11);
        p2_2 = dec2bin(a1(2,p2_index)+1024);
        p2_2 = p2_2(2:11);
        p2_3 = dec2bin(a1(3,p2_index)+1024);
        p2_3 = p2_3(2:11);
        p2 = [p2_1,p2_2,p2_3];

        [child1,child2,cross_point] = f2s(p1,p2,seed);
        [child1_last,child2_last,index] = mutation(child1,child2,seeds,index);
        disp('parants:');
        fprintf('%s %s\n',p1,p2);
        fprintf('cross point:%d\n',cross_point);
        disp('children after cross:');
        fprintf('%s %s\n',child1,child2);
        disp('children after mutation:');
        fprintf('%s %s\n\n',child1_last,child2_last);
        [c1_1_dec,c1_2_dec,c1_3_dec,c2_1_dec,c2_2_dec,c2_3_dec] = bit2dec(child1_last,child2_last);
        child_all = [[c1_1_dec,c1_2_dec,c1_3_dec];[c2_1_dec,c2_2_dec,c2_3_dec]];
        child_all = child_all';
        child_norm = normal(child_all);
        child_epoch = [child_epoch,child_all];
        child_norm_epoch = [child_norm_epoch,child_norm];
    end
    for i=1:mate_per_epoch*2
        child_fitness_epoch = [child_fitness_epoch,ack(child_norm_epoch(1,i),child_norm_epoch(2,i),child_norm_epoch(3,i))];
    end
    all_gene = [all_gene,child_epoch];
    all_gene_norm = [all_gene_norm, child_norm_epoch];
    all_fitness = [all_fitness, child_fitness_epoch];
    [after_fitness,sit] = sort(all_fitness);
    all_gene_after = [];
    all_gene_norm_after = [];
    all_fitness_after = [];
    for i=1:10
        all_gene_after = [all_gene_after,all_gene(:,sit(i))];
        all_gene_norm_after = [all_gene_norm_after,all_gene_norm(:,sit(i))];
    end
    all_gene = all_gene_after;
    all_gene_norm = all_gene_norm_after;
    all_fitness = after_fitness(1:10);
    mean_fitness = mean(all_fitness);
    disp('best 10 binary:');
    matrix_bin_disp(all_gene);
    disp('best 10 dec:');
    disp(all_gene_norm_after);
    disp('best 10 fitness:');
    disp(all_fitness);
    disp('The mean of the best 10 fitness:');
    disp(mean_fitness)
end

sum = 0;
for i=1:num
    sum = sum + all_fitness(i);
end
fit = 25 - all_fitness;
seed = seeds(index);
index = forward(index);
pro = seed/1000;

sum = 0;
for i=1:num
    sum = sum + fit(i);
end
fit = fit/sum;
disp('The proportion of each fitness:');
disp(fit);

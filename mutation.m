function [child1,child2,index] = mutation(child1,child2,seeds,index)
for i=1:30
    seed = seeds(index);
    index = forward(index);
    pro = seed/1000;
    if pro<0.1
        if child1(i)=='1'
            child1(i) = '0';
        else
            child1(i)='1';
        end
    end
end
for i=1:30
    seed = seeds(index);
    index = forward(index);
    pro = seed/1000;
    if pro<0.1
        if child2(i)=='1'
            child2(i) = '0';
        else
            child2(i)='1';
        end
    end
end
end


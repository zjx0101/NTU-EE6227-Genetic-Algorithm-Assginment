function [child1,child2,pro1] = f2s(parrent1,parrent2,seed1)
pro1 = ceil(seed1/1000*30);
child1 = [parrent1(1:pro1),parrent2(pro1+1:30)];
child2 = [parrent2(1:pro1),parrent1(pro1+1:30)];
end


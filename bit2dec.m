function [c1_1_dec,c1_2_dec,c1_3_dec,c2_1_dec,c2_2_dec,c2_3_dec] = bit2dec(child1_last,child2_last)
c1_1 = child1_last(1:10);
c1_2 = child1_last(11:20);
c1_3 = child1_last(21:30);
c2_1 = child2_last(1:10);
c2_2 = child2_last(11:20);
c2_3 = child2_last(21:30);
c1_1_dec = bin2dec(c1_1);
c1_2_dec = bin2dec(c1_2);
c1_3_dec = bin2dec(c1_3);
c2_1_dec = bin2dec(c2_1);
c2_2_dec = bin2dec(c2_2);
c2_3_dec = bin2dec(c2_3);
end


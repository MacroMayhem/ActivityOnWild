function [TestLabels] = genTestLabels(vinePosMap, TestOrder)
TestLabels = [];

for i =1 : size(TestOrder,1)
        TestLabels = vertcat(TestLabels, vinePosMap(TestOrder{i}));
end
end
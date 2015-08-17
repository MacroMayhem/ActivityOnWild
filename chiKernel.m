
% % % %  Compue Chi SQ Distance between x and y given a normalisation
% array[4]
function res=chiKernel(x,y,Ac)
a=size(x);
b=size(y);
res = zeros(a(1,1), b(1,1));
for i=1:a(1,1)
    for j=1:b(1,1)
        i,j
        resVal = chiSQ(x(i,:), y(j,:), Ac);
        res(i,j) = exp(-1.0*resVal);
    end
end
end

function [Value] = chiSQ(X,Y,Ac)
  V = [0.0 0.0 0.0 0.0];
  thres = 0.0000000001;
  
  for i=1:4000
      if (X(i)+Y(i)) >= thres
      V(1) = V(1) + ((X(i)-Y(i))*(X(i)-Y(i)))/(X(i)+Y(i));
      end
  end
  
    for i=4001:8000
      if (X(i)+Y(i)) >= thres
      V(2) = V(2) + ((X(i)-Y(i))*(X(i)-Y(i)))/(X(i)+Y(i));
      end
    end
  
  
  for i=8001:12000
      if (X(i)+Y(i)) >= thres
      V(3)  = V(3) +((X(i)-Y(i))*(X(i)-Y(i)))/(X(i)+Y(i));
      end
  end
 
  
  for i=12001:16000
      if (X(i)+Y(i)) >= thres
      V(4) = V(4) + ((X(i)-Y(i))*(X(i)-Y(i)))/(X(i)+Y(i));
      end
  end
  V(1) = V(1)/Ac(1);
  V(2) = V(2)/Ac(2);
  V(3) = V(3)/Ac(3);
  V(4) = V(4)/Ac(4);
  
%   Value = gather(val1/(Ac(1)*2)+val2/(Ac(2)*2)+val3/(Ac(3)*2)+val4/(Ac(4)*2));
  Value = V(1)/2 + V(2)/2 + V(3)/2 + V(4)/2;
  
end
function threshold = otsuThreshold(grayImage)

x=grayImage;
%figure;
%imshow(x);
[m,n]=size(x);
N=m*n;
num=zeros(1,256);
p=zeros(1,256);

for i=1:m
for j=1:n
num(x(i,j)+1)=num(x(i,j)+1)+1;
end
end

for i=0:255
p(i+1)=num(i+1)/N;
end

totalmean=0;
for i=0:255
totalmean=totalmean+i*p(i+1);
end

maxvar=0;

for k=0:255
kk=k+1;
zerosth=sum(p(1:kk));

firsth=0;
for h=0:k
firsth=firsth+h*p(h+1);
end

var=totalmean*zerosth-firsth;
var=var*var;
var=var/(zerosth*(1-zerosth)+0.001);
var=sqrt(var);
if(var>maxvar)
maxvar=var;
point=k;
end
end
threshold=point; 
for i = 1:m
    for j = 1:n
        if x(i,j) > threshold
            ans1(i,j,1) = 255;
            ans1(i,j,2) = 255;
            ans1(i,j,3) = 255;
        else
            ans1(i,j,1) = 0;
            ans1(i,j,2) = 0;
            ans1(i,j,3) = 0;
        end
    end
end          


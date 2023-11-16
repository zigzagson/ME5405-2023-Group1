function s=Histq(I)
[x,y]=size(I);
g=zeros(1,256);
h=zeros(1,256);
for i=1:x
    for j=1:y
        w=I(i,j)+1;
        h(w)=h(w)+1;
    end
end
g(1)=h(1);
for i=2:256
    g(i)=g(i-1)+h(i);
end
for i=1:x
    for j=1:y
        v=I(i,j)+1;
        s(i,j)=g(v)*255/(x*y);
    end
end


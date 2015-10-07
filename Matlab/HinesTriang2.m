% uH=diag(A);
% bH=B;
% for i=2:N
%     k=Ks(i);
%     uH(k)=uH(k)-A(k,i-1)*(A(i-1,k)/uH(i-1)); % So far same as paper parallel
%     bH(k)=bH(k)-bH(i-1)*A(k,i-1)/uH(i-1); % bH is y
% end
% uHa=uH;
% bHa=bH;

uH=d';
bH=B;
for i=2:N
    k=Ks(i);
    uH(k)=uH(k)-e(i)*(f(i-1)/uH(i-1)); % So far same as paper parallel
    bH(k)=bH(k)-bH(i-1)*e(i)/uH(i-1); % bH is y
end
a=5;
% [all(uH==uHa) all(bH==bHa)]
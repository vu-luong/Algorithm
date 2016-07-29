#include <iostream>
#define BASE 15111992

int a[206],b[206];
int n,i,bi,j,bj,r,s;
long long v,res;
std::string S;

int main() {
do std::cin>>S; while(!S.size());
for(i=0;i<S.size();i++)a[206-S.size()+i]=S[i]-'0';
do std::cin>>S; while(!S.size());n=206-S.size();
for(i=0;i<S.size();i++)b[n+i]=S[i]-'0';

for (i=205,bi=1;i>=n;i--,bi=(bi*2)%BASE) {
r=0,v=a[i]>b[i]?-1:a[i]<b[i]?1:0;
for (j=i-1,bj=1;j>=0;j--,bj=(bj*2)%BASE) {
s=b[j]-a[j]-r;
if(s<0)s+=2,r=1;else r=0;
v+=s*bj;
}
res=(res+v*bi)%BASE;
}

printf("%lld",res);
}

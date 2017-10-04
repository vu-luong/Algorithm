#include <iostream>
#include <string.h>

using namespace std;

int Cong[] = {0, 3, 20, 90, 5040, 100000};
int Thu[] = {0, 2, 10, 300, 60000, 110000};

int A[12][16], B[12][16];

struct Ketqua
{
    int x;
    int y;
};

Ketqua danh;
Ketqua danhtruoc;

bool IsInside(int x, int y)
{
    if (x<0 || x>10) return false;
    
    if (x % 2 == 0)
    {
        if (y<0 || y>14) return false;
    }
    else
    {
        if(y<0 || y>13) return false;
    }
    
    return true;
}

Ketqua truoctrai(Ketqua u)
{
    u.y -= 1;
    return u;
}

Ketqua trentrai(Ketqua u)
{
    if (u.x % 2 == 0)
    {
        u.x -= 1;
        u.y -= 1;
        return u;
    }
    else
    {
        u.x -= 1;
        
        return u;
    }
    
    return u;
}

Ketqua trenphai(Ketqua u)
{
    if (u.x % 2 == 0)
    {
        u.x -= 1;
        return u;
    }
    else
    {
        u.x -= 1;
        u.y += 1;
        return u;
    }
    return u;
}

int CheckTheCo(int C[12][16])
{
    int tancong = 0;
    int phongngu = 0;
    int temp = 0;
    
    int i,j,k;
    Ketqua vt;
    
    //TanCong
    for (i = 0; i <= 10; i++)
        for (j = 0; j<= 14; j++)
            if (IsInside(i,j) == true && C[i][j] == 1)
            {
                //trai
                vt.x = i;
                vt.y = j;
                temp = 0;
                if (C[i][j] == 1) temp = 1;
                
                for (k = 0; k<4; k++)
                {
                    vt = truoctrai(vt);
                    
                    if (IsInside(vt.x, vt.y) == true)
                    {
                        if (C[vt.x][vt.y] == 1) temp++;
                        else break;
                    }
                    else break;
                }
                
                if (k == 4) tancong += Cong[temp];
                else tancong += Cong[temp]/2;
                
                //trentrai
                vt.x = i;
                vt.y = j;
                temp = 0;
                if (C[i][j] == 1) temp = 1;
                for (k = 0; k<4; k++)
                {
                    vt = trentrai(vt);
                    
                    if (IsInside(vt.x, vt.y) == true)
                    {
                        if (C[vt.x][vt.y] == 1) temp++;
                        else break;
                    }
                    else break;
                }
                
                if (k == 4) tancong += Cong[temp];
                else tancong += Cong[temp]/2;
                
                //trenphai
                vt.x = i;
                vt.y = j;
                temp = 0;
                if (C[i][j] == 1) temp = 1;
                for (k = 0; k<4; k++)
                {
                    vt = trenphai(vt);
                    
                    if (IsInside(vt.x, vt.y) == true)
                    {
                        if (C[vt.x][vt.y] == 1) temp++;
                        else break;
                    }
                    else break;
                }
                
                if (k == 4) tancong += Cong[temp];
                else tancong += Cong[temp]/2;
            }
    
    
    //Phong ngu
    for (i = 0; i <= 10; i++)
        for (j = 0; j<= 14; j++)
            if (IsInside(i,j) == true && C[i][j] ==2)
            {
                //trai
                vt.x = i;
                vt.y = j;
                temp = 0;
                if (C[i][j] == 2) temp = 1;
                for (k = 0; k<4; k++)
                {
                    vt = truoctrai(vt);
                    
                    if (IsInside(vt.x, vt.y) == true)
                    {
                        if (C[vt.x][vt.y] == 2) temp++;
                        else break;
                    }
                    else break;
                }
                
                if (k == 4) phongngu += Thu[temp];
                else phongngu += Thu[temp]/2;
                
                //trentrai
                vt.x = i;
                vt.y = j;
                temp = 0;
                if (C[i][j] == 2) temp = 1;
                for (k = 0; k<4; k++)
                {
                    vt = trentrai(vt);
                    
                    if (IsInside(vt.x, vt.y) == true)
                    {
                        if (C[vt.x][vt.y] == 2) temp++;
                        else break;
                    }
                    else break;
                }
                
                if (k == 4) phongngu += Thu[temp];
                else phongngu += Thu[temp]/2;
                
                //trenphai
                vt.x = i;
                vt.y = j;
                temp = 0;
                if (C[i][j] == 2) temp = 1;
                for (k = 0; k<4; k++)
                {
                    vt = trenphai(vt);
                    
                    if (IsInside(vt.x, vt.y) == true)
                    {
                        if (C[vt.x][vt.y] == 2) temp++;
                        else break;
                    }
                    else break;
                }
                
                if (k == 4) phongngu += Thu[temp];
                else phongngu += Thu[temp]/2;
            }
    
    
    return tancong - phongngu;
}


Ketqua Danh1(int C[12][16])
{
    int i,j,u,v;
    int dem1 = -7000000;
    int temp1 = 0;
    int temp2 = 1000000;
    int dem2 = 7000000;
    
    Ketqua res;
    res.x = -1;
    res.y = -1;
    
    for (i = 0; i <= 10; i++)
        for (j = 0; j<= 14; j++)
            if (IsInside(i,j) == true && C[i][j] == 0)
            {
                C[i][j] = 1;
                temp1 =  CheckTheCo(C);
                
                dem2 = 7000000;
                
                
                for (u=0; u<=10; u++)
                    for(v = 0; v<=14; v++)
                        if (IsInside(u,v) == true && C[u][v] == 0)
                        {
                            C[u][v] = 2;
                            temp2 = CheckTheCo(C);
                            if (dem2 > temp2) dem2 = temp2;
                            C[u][v] = 0;
                        }
                
                if (dem1 < dem2)
                {
                    dem1 = dem2;
                    res.x = i;
                    res.y = j;
                }
                C[i][j] = 0;
            }
    
    return res;
}

int main()
{	
    danhtruoc.x = 6;
    danhtruoc.y = 7;
    
    int sobuoc = 0;
    bool kt = true;
    bool dadoc = false;
    int x,y;
    int i,j;
    
    memset(A,0,sizeof(A));
    memset(B,0,sizeof(B));
    
    while (kt == true)
    {
        if (dadoc == false)
        {
            cin>> x;
            if (x == 1)
            {
                danh.x = 6;
                danh.y = 7;
                A[6][7] = 1;
                sobuoc++;
                cout << danh.x << " "<<danh.y<<endl;
            }
            
            dadoc = true;
        }
        
        else
        {
            //Doc nuoc di cua doi kia 
            cin >> x >> y;
            A[x][y] = 2;
            
            danh.x = 0;
            danh.y = 0;
            kt = false;
            for(i=0; i<=10; i++)
                for (j=0; j<=14; j++)
                    if (IsInside(i,j) == true && A[i][j] == 0)
                    {
                        danh.x = i;
                        danh.y = j;
                        kt = true;
                        break;
                    }
            
            
            if (kt == false) 
            {
                cout << "END" <<endl;
                return 0;
            }
            
            danh = Danh1(A);
            
            if (danh.x == -1)
            {
                cout << "END" <<endl;
                return 0;
            }
            
            
            A[danh.x][danh.y] = 1;
            danhtruoc.x = danh.x;
            danhtruoc.y = danh.y;
            cout << danh.x << " "<<danh.y<<endl;
            sobuoc++;
        }
        
        
    }
    return 0;
}

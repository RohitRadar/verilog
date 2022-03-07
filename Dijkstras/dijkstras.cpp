/*
Bot initial starting direction at 1: facing West
DIRECTIONS:
NORTH:1
EAST:2
SOUTH:3
WEST:4
*/

#include<iostream>
using namespace std;

int vertex[37][4];
int numvertex;
int adj[37][37];
int directioninit[37][37];
int directionnext[37][37];
int initialpos=4;
int direction[37];
int directlink;
int minDist(){
    int min;
    int pos;
    int i=0;
    while(i<numvertex){
        if(vertex[i][0] == 0){
            min = vertex[i][1];
            pos = i;
            i=numvertex;
        }
        i=i+1;
    }
    for(int i=0; i<numvertex; i++){
        if(vertex[i][1] < min && vertex[i][0] == 0){
            min = vertex[i][1];
            pos = i;
        }        
    }
    vertex[pos][0] = 1;
    return pos;
}

void inittable(int start){
    for(int i=0; i<numvertex; i++){
        vertex[i][0] = 0;
        vertex[i][1] = 9999;
        vertex[i][2] = -1;
        vertex[i][3] = 0;
    }
    vertex[start-1][1] = 0;
}

int distance(int n){
    return vertex[n][1];   
}

void readgraph(int n){
    numvertex = n;
    int x,y,d,di,dn;
    while(cin>>x>>y>>d>>di>>dn){
        if(x == n+1)
            break;
        adj[x-1][y-1] = d;
        directioninit[x-1][y-1] = di;
        directionnext[x-1][y-1] = dn;
    }
}

void printgraph(){
    for(int i=0; i<numvertex; i++){
        for(int j=0; j<numvertex; j++){
            cout<<adj[i][j]<<" ";
        }
        cout<<endl;
    }
}

void printPath(int v)
{   
    int path[40];
    int count = 0;
    int p = vertex[v][2];
    while(p != -1){
        path[count] = v+1;
        count++;
        v = p;
        p = vertex[v][2];
    }
    path[count] = v+1;
    count++;
    for(int i=count-1; i>=0; i--){
        direction[i]=path[i];
        if (i == 0){
            cout<<path[i];
            continue;
        }
        cout<<path[i]<<" to ";
    }
    directlink=count-1;
}

void dijkstra(){
    int pos;
    for(int i=0; i<numvertex; i++){
        int pos = minDist();
        for(int j=0; j<numvertex; j++){
            int a = adj[pos][j];
            int b = vertex[pos][1];
            int c = vertex[j][1];
            if(a != 0){
                //cout<<i<<" "<<j<<" "<<pos<< " "<<a<<" "<<b<<" "<<c<<"\n";
                if(b+a<c){
                    vertex[j][1] = vertex[pos][1] + adj[pos][j];
                    vertex[j][2] = pos;
                }
                //adj[j][pos] = 0;
            }
        }
    }
}
void direct(){
    int x=directlink;
    int di,dn;
    cout<<"\nInitial Direction:"<<initialpos<<"\n";
    while(x>0){
        di=directioninit[direction[x]-1][direction[x-1]-1];
        dn=directionnext[direction[x]-1][direction[x-1]-1];
        //cout<<"\n"<<x<<" "<<direction[x]<<" "<<direction[x-1]<<" "<<di<<" "<<dn<<"\n";
        x=x-1;
        if (initialpos-di==0){
            cout<<"Straight -- ";
            initialpos=dn;
        }
        else if (initialpos-di==1||initialpos-di==-3){
            cout<<"Left -- Straight -- ";
            initialpos=dn;
        }
        else if (initialpos-di==-1||initialpos-di==3){
            cout<<"Right -- Straight -- ";
            initialpos=dn;
        }
        else{
            cout<<"U-turn -- ";
            cout<<"Straight -- ";     
            initialpos=dn;
        }       
    }
    cout<<"\nFinal Direction:"<<initialpos;
}
int main(){
    for(int i=0; i<37; i++){
        for(int j=0; j<37; j++){
            adj[i][j] = 0;
            directioninit[i][j] = 0;
            directionnext[i][j]=0;
        }
        direction[i]=0;
    }
    int n = 0,start = 0;
    numvertex = n;
    cout<<"\nEnter the number of nodes to the graph: ";
    cin>>n;
    cout<<"\nEnter the nodes (eg format node1 node2 weight direction)\n";
    cout<<"\nEnter "<<n+1<<" "<<n+1<<" "<<n+1<<" "<<n+1<<" to exit the sequence.\n"; 
    readgraph(n);
    cout<<"\nEnter the start node: ";
    cin>>start;
    inittable(start);
    for(int i=0;i<10;i++){
        for (int j=0;j<37;j++){
            int a=adj[i][j];
            int b=directioninit[i][j];
            int c=directionnext[i][j];
            int d=vertex[i][j/4];
            //cout<<i<<" "<<j<<" "<<a<<" "<<b<<" "<<c<<" "<<d<<"\n";
        }
    } 
    dijkstra();
    cout<<endl;
    int end = 0;
    cout<<"\nEnter the ending node: ";
    cin>>end;
    cout<<"\nShortest path from "<<start<<" to "<<end<<" is:";
    printPath(end-1);
    cout<<"\nand the distance is "<<distance(end-1);
    direct();
    return 0;
}
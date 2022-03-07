f = open("new_map_data.txt",'r')
fu=open("digonthis.v",'w')
max=37
adj = [[0 for x in range(max)] for y in range(max)] 
directioninit = [[0 for x in range(max)] for y in range(max)] 
directionnext = [[0 for x in range(max)] for y in range(max)] 

for a in f:
    a=a.split(' ')
    print(a)
    if int(a[0])!=38:
        x=int(a[0])
        y=int(a[1])
        d=int(a[2])
        din=int(a[3])
        dn=int(a[4][:-1])
        adj[x-1][y-1] = d
        directioninit[x-1][y-1] = din
        directionnext[x-1][y-1] = dn
f.close()

for i in range(0,len(adj)):
    for j in range(0,len(adj[0])):
        if (adj[i][j]!=0):
            s=f"adj[{37*i+j}]={adj[i][j]};"
            fu.write(s)
fu.write("\n")
for i in range(0,len(adj)):
    for j in range(0,len(adj[0])):
        if (directioninit[i][j]!=0):
            s=f"di[{37*i+j}]={directioninit[i][j]};"
            fu.write(s)
fu.write("\n")
for i in range(0,len(adj)):
    for j in range(0,len(adj[0])):
        if (directionnext[i][j]!=0):
            s=f"dn[{37*i+j}]={directionnext[i][j]};"
            fu.write(s)
fu.write("\n")
fu.close()
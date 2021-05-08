clc
clear all
N = 200;
L = 600;
S = 1000;

ba_network = scalefree(N,10,L/N);
er_network = randomGraph(N,0.5,L);

G = graph(er_network,'upper');
shortest_path = distances(G);


i = randi([1,N],1);
j = randi([1,N],1);
coord_S = [[i j]];
len = 1;
while len<S
    i = randi([1,N],1);
    j = randi([1,N],1);
    if ~any(ismember(coord_S,[i j],'rows')) && ~any(ismember(coord_S,[j i],'rows')) && shortest_path(i,j)>0
        coord_S = [coord_S; [i j]];
        len=len+1;
    end
end

ds = [];
for i=1:S
    ds = [ds shortest_path(coord_S(i,1),coord_S(i,2))];
end
ds =ds + 1;

V_s = {};
for i=1:S
    V_s=[V_s; (shortestpath(G,coord_S(i,1),coord_S(i,2)))];
end

F_n = cell(N,1);
for i=1:S
    temp = V_s{i};
    for j=1:size(temp,2)
       F_n{temp(j)} = [F_n{temp(j)} i];
    end
end

F_l = cell(N,N);
for i=1:S
    temp = V_s{i};
    for j=1:size(temp,2)-1
        F_l{temp(j),temp(j+1)} = [F_l{temp(j),temp(j+1)} i];
        F_l{temp(j+1),temp(j)} = [F_l{temp(j+1),temp(j)} i];
    end
end
    
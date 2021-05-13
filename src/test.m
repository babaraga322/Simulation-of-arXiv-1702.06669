utility = [];
T1 = er_network;
p = (1./ds.^2)';
for M=0:1000:10000

    alpha = 0.1;
    
    cvx_begin sdp quiet
        variable x(S)
        variable D(N)
        maximize sum(-p.*inv_pos(x))
        subject to

    x >= 0;

    for i=1:N
        sum1 = 0;
        for j=F_n{i}
            sum1 = sum1 + x(j);
        end
        sum1<=D(i);
    end

    for m=1:N
        for n=1:N
            sum2 = 0;
            for j=F_l{m,n}
                sum2 = sum2 + x(j);
            end
            sum2 <= T1(m,n)*alpha*(D(m)+D(n));
        end
    end

    sum(D) == M ;
    D>=0;
    cvx_end
    res = -1./((ds.^2).*x');
    [M sum(res)]
    utility = [utility sum(res)];
    
end
hold on
plot(0:1000:10000,utility,'-*')
grid on

function t0=backtrack_a(w,KK,t,v)
    [n,~]=size(KK);
    alpha0=0.01;
    beta0=0.5;
    C=1000;

    t0=1;
    while ((P(w+t0*v,KK,t)>P(w,KK,t)+alpha0*t0*g(w,KK,t)'*v)||...
        sum(w+t0*v>=C*ones(n,1))~=0||sum(w+t0*v<=zeros(n,1))~=0)
        % t0
        t0=beta0*t0;
    end
end

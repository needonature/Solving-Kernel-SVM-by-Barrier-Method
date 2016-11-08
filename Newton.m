function w=Newton(w,KK,Y,t)
    [n,~]=size(KK);

    p_pre=P(w,KK,t);
    %first step
    A=[H_a(w,KK,t),Y;Y',0];
    B=-[g(w,KK,t);Y'*w];
    x=A\B;
    v=x(1:end-1);
    t0=backtrack_a(w,KK,t,v);
    w=w+t0*v;
    p_curr=P(w,KK,t);
    decrement(t,w,KK,v)

    %following steps
    while(decrement(t,w,KK,v)>t*1e-6)
        A=[H_a(w,KK,t),Y;Y',0];
        B=-[g(w,KK,t);Y'*w];
        x=A\B;
        v=x(1:end-1);
        t0=backtrack_a(w,KK,t,v);
        w=w+t0*v;
        p_pre=p_curr;
        p_curr=P(w,KK,t);
        decrement(t,w,KK,v)
    end
end

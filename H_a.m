function result=H_a(w,KK,t)
    [n,~]=size(KK);
    C=1000;
    result=t*KK+diag(1./w.^2+1./(C-w).^2);
end

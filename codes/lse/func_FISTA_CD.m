function [x, ek, fk, its] = func_FISTA_CD(x0, d, para, GradF, ObjF)

itsprint(sprintf('      step %09d: norm(ek) = %.3e', 1,1), 1);

beta = para.beta;
gamma = 1.0* beta;

n = para.n;
tol = para.tol;
maxits = para.maxits;

ek = zeros(maxits, 1);
fk = zeros(maxits, 1);

% x0 = zeros(n, 1);

x = x0;
y = x0;

t = 1;

its = 1;
while(its<maxits)
    
    fk(its) = ObjF(x);
    
    x_old = x;
    x = y - gamma*GradF(y);
    
    t_old = t;
    t = (its+d-1) /d;
    a = (t_old-1) /t;
    y = x + a*(x - x_old);
    
    %%% stop?
    normE = norm(x-x_old, 'fro');
    if mod(its, 1e4)==0
        itsprint(sprintf('      step %09d: norm(ek) = %.3e', its,normE), its);
    end
    
    ek(its) = normE;
    if (normE<tol)||(normE>1e10); break; end
    
    its = its + 1;
    
end
fprintf('\n');

ek = ek(1:its-1);
fk = fk(1:its-1);
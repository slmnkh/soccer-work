function ch = checkValidity(Amat)

ch =  sum(Amat(:)) > eps;
    
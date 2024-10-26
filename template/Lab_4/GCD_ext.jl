a = 3984759347
b = 47584

function euclidian_ext(a,b)
    if a<b
        a,b=b,a
    end
    r_0 = a
    r_1 = b
    x_0=1 # a*x + b*y = d (НОД(a,b))
    x_1=0 
    y_0=0
    y_1=1
    while r_1!=0
        q = div(r_0,r_1)
        r_next = r_0 - q*r_1 # НОД(r_0,r_1)
        r_0 = r_1
        r_1 = r_next

        x_next = x_0 - q*x_1
        x_0 = x_1
        x_1 = x_next

        y_next = y_0-q*y_1
        y_0 = y_1
        y_1 = y_next
    end 
    d = r_0
    x = x_0
    y = y_0
    return d, x, y
end
println(euclidian_ext(a,b))
d, x, y = euclidian_ext(a,b)
check = a*x+b*y
println(check)
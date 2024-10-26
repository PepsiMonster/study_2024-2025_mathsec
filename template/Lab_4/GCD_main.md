**Алгоритм Евклида**


```julia
a = 4567890
b = 462

function euclidian_algorithm(a,b)
    if a<b
        a,b=b,a
    end
    r_0 = a
    r_1 = b 
    while true
        r_next= r_0 % r_1
        if r_next == 0
            return r_1
        end
        r_0 = r_1
        r_1 = r_next
    end
end

println(euclidian_algorithm(a,b))
```

    6
    

**Бинарный алгоритм Евклида**


```julia
a = 678908890
b = 2937

function euclidian_binary(a,b)
    if a<b
        a,b=b,a
    end
    g = 1
    while a%2==0 && b%2==0
        a = div(a,2)
        b = div(a,2)
        g*= 2
    end
    u = a 
    v = b
    while u!=0
        while u%2==0
            u = div(u,2)
        end
        while v%2==0
            v = div(v,2)
        end
        if u>=v
            u -= v 
        else
            v -= u
        end 
    end
    d = g*v
    return d
end

println(euclidian_binary(a,b))
```

    11
    

**Расширенный алгоритм Евклида**


```julia
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
```

    (1, 18011, -1508269599)
    

**Проверка**


```julia
d, x, y = euclidian_ext(a,b)
check = a*x+b*y
println(check)
```

    1
    

**Бинарный расширенный алгоритм Евклида**


```julia
a = 1024
b = 512

function euclidean_ext_bin(a, b)
    if a < b
        a, b = b, a
    end
    g = 1
    while a % 2 == 0 && b % 2 == 0
        a = div(a, 2)
        b = div(b, 2)
        g *= 2
    end
    u = a
    v = b
    A = 1
    B = 0
    C = 0
    D = 1
    while u != 0
        while u % 2 == 0
            u = div(u, 2)
            if A % 2 == 0 && B % 2 == 0
                A = div(A, 2)
                B = div(B, 2)
            else
                A = div(A + b, 2)
                B = div(B - a, 2)
            end
        end
        while v % 2 == 0
            v = div(v, 2)
            if C % 2 == 0 && D % 2 == 0
                C = div(C, 2)
                D = div(D, 2)
            else
                C = div(C + b, 2)
                D = div(D - a, 2)
            end
        end
        if u >= v
            u -= v
            A -= C
            B -= D
        else
            v -= u
            C -= A
            D -= B
        end
    end
    d = g * v
    x = C
    y = D
    return d, x, y
end
println(euclidean_ext_bin(a,b))
```

    (512, 0, 1)
    

**Проверка**


```julia
d, x, y = euclidean_ext_bin(a,b)
check = a*x+b*y 
println(check)
```

    512
    

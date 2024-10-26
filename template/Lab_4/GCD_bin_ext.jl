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

d, x, y = euclidean_ext_bin(a,b)
check = a*x+b*y 
println(check)
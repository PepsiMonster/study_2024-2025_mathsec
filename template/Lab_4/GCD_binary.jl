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
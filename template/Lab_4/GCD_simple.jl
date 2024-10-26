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
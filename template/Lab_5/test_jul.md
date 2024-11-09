```julia
using Random
```


```julia
n = 20
function is_prime(n::Int,k::Int=5)
    if n < 5 || n%2 == 0
        return false
    end
    for _ in 1:k
        a = rand(2:n-2)    
        r = powermod(a,n-1,n)
        if r != 1
            return false
        end
    end
    return true
end
```


    is_prime (generic function with 2 methods)



```julia
if is_prime(n)
    println("Число $n скорее всего простое")
else
    println("Число $n составное")
end
```

    Число 20 составное
    


```julia
n = 19
a = rand(0:n)
```


    16



```julia
function jacobi_symbol(a::Int, n::Int)
    g = 1
    if a == 0
        return 0
    end
    if a == 1
        return g
    end
    while a != 0
        k = 0
        while a % 2 == 0
            a ÷= 2
            k += 1
        end
        a1 = a
        if k % 2 == 0
            s = 1
        else
            if n % 8 == 1 || n % 8 == 7
                s = 1
            elseif n % 8 == 3 || n % 8 == 5
                s = -1
            end
        end
        g *= s
        if a1 == 1
            return g
        end
        if n % 4 == 3 && a1 % 4 == 3
            g = -g
        end
        a, n = n % a1, a1
    end
    return g
end

```


    jacobi_symbol (generic function with 1 method)



```julia
result = jacobi_symbol(a, n)
println("Символ Якоби ($a/$n) = $result")
```

    Символ Якоби (16/19) = 1
    


```julia
n = 27
```


```julia
function test_solovei_strassen(n::Int)
    a = rand(2:n-2)
    n_1 = (n-1)/2
    r = powermod(a, n_1, n) # power(a, (n-1)/2, n)
    if r != 1 && r !=(n-1)
        return false
    end
    s = jacobi_symbol(a,n)
    if r == s%n
        return true
    else
        return false
    end
end
```


    test_solovei_strassen (generic function with 1 method)



```julia
if is_prime(n)
    println("Число $n скорее всего простое")
else
    println("Число $n не является простым")
end
```

    Число 19 скорее всего простое
    


```julia
n = 19
```


    19



```julia
function test_miller_rabin(n::Int, k::Int=5)
    s = 0
    r = n - 1
    while r % 2 == 0
        r ÷= 2
        s += 1
    end

    for _ in 1:k
        a = rand(2:n-2)
        y = powermod(a, r, n)

        if y == 1 || y == n - 1
            continue
        end

        for j in 1:s-1
            y = powermod(y, 2, n)
            if y == 1
                return false
            end
            if y == n - 1
                break
            end
        end

        if y != n - 1
            return false
        end
    end
    return true
end
```


    test_miller_rabin (generic function with 2 methods)



```julia
if test_miller_rabin(n)
    println("Число $n вероятно простое")
else
    println("Число $n составное")
end
```

    Число 19 вероятно простое
    

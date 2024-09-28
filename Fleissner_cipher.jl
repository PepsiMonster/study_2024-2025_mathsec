function fleissner_cipher(plaintext, password)
    # Для удобства в начале сразу убираем пробелы и делаем текст маленькими буквами
    plaintext = replace(plaintext, r"\s"=>"")
    plaintext = lowercase(plaintext)
    
    # Тоже косметическое, убираем не-буквы
    plaintext = replace(plaintext, r"[^а-яё]" => "")
    password = lowercase(password)
    password = replace(password, r"[^а-яё]" => "")

    # Смотрим, чтобы длина пароля была не меньше нашего квадарата
    N = 4  
    if length(password) < N
        error("Password length must be at least N (which is 4).") # Что-то на подобии try/except в питоне
    elseif length(password) > N
        password = password[1:N]  #если она больше, "обрезаем" слово до N
    end

    # Проверяем, чтобы буквы пароля были уникальными, иначе будут ошибки, ошибки, ошибки
    if length(unique(collect(password))) != N
        error("The password must contain unique letters of length N.")
    end
    
    plaintext_chars = collect(plaintext)    # Снова превращаем строку букв в мааатрицу
    total_cells = N^2   # Ничего не поделаешь, нужно чтобы длина послания была N^2
    if length(plaintext_chars) < total_cells
        padding_length = total_cells - length(plaintext_chars)
        plaintext_chars = vcat(plaintext_chars, ['я' for _ in 1:padding_length])
    elseif length(plaintext_chars) > total_cells
        plaintext_chars = plaintext_chars[1:total_cells]
    end

    
    big_grid_letters = Array{Char}(undef, N, N)     # Наш квадрат растет на глазах (в квадрате)
    hole_positions = [(1,1), (2,4), (3,3), (4,2)]   # Тут мы в ручную прописываем, где будут номера букв пароля 
                                                    #(первый номер буквы, второй номер квадрата)

    # Стандартная функция для "кручения" матрицы
    function rotate_positions(positions, N)
        rotated_positions = []
        for (i, j) in positions
            i_new = j # i становиться j
            j_new = N - i + 1 # а j становится i, но с конца
            push!(rotated_positions, (i_new, j_new)) # штука которая дает новые позиции
        end
        return rotated_positions
    end

    index = 1  # номер буквы нашей строчки с кучей букв
    current_positions = hole_positions
    for rotation in 0:3
        for (i, j) in current_positions
            big_grid_letters[i, j] = plaintext_chars[index] #зациклили 
            index += 1
        end # тут мы получили новые позиции для буквы и повторяем итерации
        current_positions = rotate_positions(current_positions, N)
    end

    password_chars = collect(password)# Наконец придаем буквам пароля новые индексы от их места в колонне
    password_mapping = Dict{Char, Int}()#  И вот только теперь привязываем к буквы пароля к индексам в новых колоннах
    for i in 1:N
        password_mapping[password_chars[i]] = i
    end

    sorted_password_chars = sort(password_chars) #сортировка по алфавиту, ничего особенного
    column_order = [password_mapping[c] for c in sorted_password_chars]

    # теперь считываем сообщение по порядку, который задали ранее в зависимости от букв пароля и их индексов
    ciphertext = ""
    for col in column_order
        for row in 1:N
            ciphertext *= big_grid_letters[row, col]
        end
    end

    return ciphertext
end

plaintext = "договор подписали"
password = "шифр"
ciphertext = fleissner_cipher(plaintext, password)
println(ciphertext)

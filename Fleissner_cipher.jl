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

    # Convert plaintext to an array of characters
    plaintext_chars = collect(plaintext)

    # Ensure plaintext length is exactly N^2
    total_cells = N^2
    if length(plaintext_chars) < total_cells
        padding_length = total_cells - length(plaintext_chars)
        plaintext_chars = vcat(plaintext_chars, ['я' for _ in 1:padding_length])
    elseif length(plaintext_chars) > total_cells
        plaintext_chars = plaintext_chars[1:total_cells]
    end

    # Initialize the big grid for letters
    big_grid_letters = Array{Char}(undef, N, N)

    # Define the initial hole positions for N=4 (standard Fleissner grille)
    hole_positions = [(1,1), (2,4), (3,3), (4,2)]

    # Function to rotate positions 90 degrees clockwise
    function rotate_positions(positions, N)
        rotated_positions = []
        for (i, j) in positions
            i_new = j
            j_new = N - i + 1
            push!(rotated_positions, (i_new, j_new))
        end
        return rotated_positions
    end

    index = 1  # Index for plaintext characters
    current_positions = hole_positions
    for rotation in 0:3
        for (i, j) in current_positions
            big_grid_letters[i, j] = plaintext_chars[index]
            index += 1
        end
        # Rotate positions for the next iteration
        current_positions = rotate_positions(current_positions, N)
    end

    # Map password letters to column indices
    password_chars = collect(password)

    # Create a mapping of password letters to column indices
    password_mapping = Dict{Char, Int}()
    for i in 1:N
        password_mapping[password_chars[i]] = i
    end

    # Sort the password letters alphabetically to get the column order
    sorted_password_chars = sort(password_chars)
    column_order = [password_mapping[c] for c in sorted_password_chars]

    # Extract the ciphertext by reading columns in the order determined by the password
    ciphertext = ""
    for col in column_order
        for row in 1:N
            ciphertext *= big_grid_letters[row, col]
        end
    end

    return ciphertext
end

# Example usage:
plaintext = "договор подписали"
password = "шифр"
ciphertext = fleissner_cipher(plaintext, password)
println(ciphertext)

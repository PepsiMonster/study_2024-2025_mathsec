function vigenere_cipher(plaintext, keyword)
    # Как и всегда, убираем пробелы, уменьшаем буквы
    plaintext = replace(plaintext, r"\s"=>"")
    plaintext = lowercase(plaintext)
    plaintext = replace(plaintext, r"ё"=>"е")  # как оказалось тут нужен весь алфавит, так что ё воспринимаем как е
    keyword = lowercase(keyword)
    keyword = replace(keyword, r"ё"=>"е")
    plaintext = replace(plaintext, r"[^а-я]" => "")# Опять потому что алфавит, убираем не русские буквы
    keyword = replace(keyword, r"[^а-я]" => "")   
    alphabet = ['а','б','в','г','д','е','ж','з','и','й','к','л','м','н','о',
                'п','р','с','т','у','ф','х','ц','ч','ш','щ','ъ','ы','ь','э','ю','я']# Вручную задаем алфавит
    N = length(alphabet)
    
    # Буквам придаем номер по алфавиту
    letter_to_index = Dict{Char, Int}()
    index_to_letter = Dict{Int, Char}()
    for (i, c) in enumerate(alphabet)
        letter_to_index[c] = i
        index_to_letter[i] = c
    end
    
    # делаем массив букв!
    plaintext_chars = collect(plaintext)
    keyword_chars = collect(keyword)
    
    # мы делаем пароль длины как сообщение
    keyword_repeated = Char[]
    while length(keyword_repeated) < length(plaintext_chars) # если он меньше
        append!(keyword_repeated, keyword_chars) # то просто добавляем сам пароль снова или его буквы, пока не хватит
    end
    keyword_repeated = keyword_repeated[1:length(plaintext_chars)]
    
    ciphertext = Char[]
    for i in 1:length(plaintext_chars)
        p_char = plaintext_chars[i]
        k_char = keyword_repeated[i]
        p_index = letter_to_index[p_char] # номера букв в алфатие для сообщения
        k_index = letter_to_index[k_char] # номера букв в алфатие для пароля
        cipher_index = (p_index + k_index - 2) % N + 1 #складываем индекс 2х букв, вычитаем 2 потому что они сами и смотрим чтобы
        c_char = index_to_letter[cipher_index]         #номер не был слишком большим 
        push!(ciphertext, c_char)
    end
    return join(ciphertext)
end

plaintext = "криптография крутая наука"
keyword = "математика"
ciphertext = vigenere_cipher(plaintext, keyword)
println(ciphertext)

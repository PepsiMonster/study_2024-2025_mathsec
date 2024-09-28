function route_cipher(text, m, n, keyword)
    # Для удобства в начале убираем пробелы и делаем буквы маленькими
    text = replace(text, r"\s"=>"")
    text = lowercase(text)
    
    # перекидываем буквы в новую переменную
    text_chars = collect(text)
    
    block_length = m * n #наш блок m*n
    
    # новую переменную из букв раскидываем по блоку
    blocks = [text_chars[i:min(i+block_length-1, end)] for i in 1:block_length:length(text_chars)]
    
    # Вот этот кусок для дополнительных букв, если наш комок букв не раскидывается ровно 
    if length(blocks[end]) < block_length
        padding_length = block_length - length(blocks[end])
        blocks[end] = vcat(blocks[end], ['я' for _ in 1:padding_length])
    end
    
    # Привязывает буквы ПАРОЛЯ к их номеру в русском алфавите
    function letter_position(letter)
        code = Int(letter)
        position = code - 1071 
        return position
    end
    
    keyword_chars = collect(keyword)
    keyword_positions = [letter_position(c) for c in keyword_chars]
    
    #Сортирует буквы (колонны соответсвенно будут дальше) по паролю в порядке возрастания их номера по алфавиту
    sorted_positions = sortperm(keyword_positions)
    column_order = sorted_positions
    cipher_text = ""
    
    # Супер цикл для каждого блока
    for block in blocks
        # Создаем матрицу m*n наполненную нашими буквами (undef - чтобы буквы, а не цифры)
        mat = Array{Char}(undef, m, n)
        index = 1
        for i in 1:m
            for j in 1:n
                mat[i, j] = block[index] #по порядку для каждой буквы проверяем ее индекс, смотрим по строке и столбцу
                index += 1               #и по итогу у нас новые буквы
            end
        end
    
        # Перемешиваем колонны в порядлке возрастания индекса букв в пароле
        for col in column_order
            for row in 1:m
                cipher_text *= mat[row, col]
            end
        end
    end
    
    return cipher_text
end

text = "нельзя недооценивать врагаврага"
m = 5 #нельзя сделать меньше 5х6, потому что 30 букв
n = 6 #если поменять кол-во букв, можно поиграть с размером матрицы, главное чтобы буквы ПОМЕЩАЛИСЬ
keyword = "кодово" #должно соответствовать нашему n
cipher_text = route_cipher(text, m, n, keyword)
println(cipher_text)

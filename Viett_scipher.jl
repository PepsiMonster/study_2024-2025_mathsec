function route_cipher(text, m, n, keyword)
    # Remove spaces and convert to lowercase
    text = replace(text, r"\s"=>"")
    text = lowercase(text)
    
    # Convert text to an array of characters
    text_chars = collect(text)
    
    block_length = m * n
    
    # Break text_chars into blocks
    blocks = [text_chars[i:min(i+block_length-1, end)] for i in 1:block_length:length(text_chars)]
    
    # Pad the last block if necessary with arbitrary letters (e.g., 'я')
    if length(blocks[end]) < block_length
        padding_length = block_length - length(blocks[end])
        blocks[end] = vcat(blocks[end], ['я' for _ in 1:padding_length])
    end
    
    # Map keyword letters to positions in the Russian alphabet
    function letter_position(letter)
        code = Int(letter)
        position = code - 1071  # 'а' is Unicode 1072
        return position
    end
    
    keyword_chars = collect(keyword)
    keyword_positions = [letter_position(c) for c in keyword_chars]
    
    # Get sorted order of the columns based on keyword letters
    sorted_positions = sortperm(keyword_positions)
    column_order = sorted_positions
    
    # Initialize cipher text
    cipher_text = ""
    
    # Process each block
    for block in blocks
        # Create m x n matrix and fill it row by row
        mat = Array{Char}(undef, m, n)
        index = 1
        for i in 1:m
            for j in 1:n
                mat[i, j] = block[index]
                index += 1
            end
        end
    
        # Read columns in the order defined by the keyword
        for col in column_order
            for row in 1:m
                cipher_text *= mat[row, col]
            end
        end
    end
    
    return cipher_text
end

# Example usage:
text = "нельзя недооценивать противника"
m = 5
n = 6
keyword = "пароль"
cipher_text = route_cipher(text, m, n, keyword)
println(cipher_text)

function vigenere_cipher(plaintext, keyword)
    # Remove spaces and convert to uppercase
    plaintext = replace(plaintext, r"\s"=>"")
    plaintext = lowercase(plaintext)
    plaintext = replace(plaintext, r"ё"=>"е")  # Replace 'Ё' with 'Е' if present
    keyword = lowercase(keyword)
    keyword = replace(keyword, r"ё"=>"е")
    
    # Remove any non-Russian letters
    plaintext = replace(plaintext, r"[^а-я]" => "")
    keyword = replace(keyword, r"[^а-я]" => "")
    
    # Define the Russian alphabet (excluding 'Ё', total 32 letters)
    alphabet = ['а','б','в','г','д','е','ж','з','и','й','к','л','м','н','о',
                'п','р','с','т','у','ф','х','ц','ч','ш','щ','ъ','ы','ь','э','ю','я']
    N = length(alphabet)
    
    # Map letters to indices
    letter_to_index = Dict{Char, Int}()
    index_to_letter = Dict{Int, Char}()
    for (i, c) in enumerate(alphabet)
        letter_to_index[c] = i
        index_to_letter[i] = c
    end
    
    # Convert plaintext and keyword to arrays of characters
    plaintext_chars = collect(plaintext)
    keyword_chars = collect(keyword)
    
    # Prepare the keyword to match the length of the plaintext
    keyword_repeated = Char[]
    while length(keyword_repeated) < length(plaintext_chars)
        append!(keyword_repeated, keyword_chars)
    end
    keyword_repeated = keyword_repeated[1:length(plaintext_chars)]
    
    # Build the cipher text
    ciphertext = Char[]
    for i in 1:length(plaintext_chars)
        p_char = plaintext_chars[i]
        k_char = keyword_repeated[i]
        # Find indices in the alphabet
        p_index = letter_to_index[p_char]
        k_index = letter_to_index[k_char]
        # Compute cipher index
        cipher_index = (p_index + k_index - 2) % N + 1
        c_char = index_to_letter[cipher_index]
        push!(ciphertext, c_char)
    end
    
    return join(ciphertext)
end

# Example usage:
plaintext = "криптография серьезная наука"
keyword = "математика"
ciphertext = vigenere_cipher(plaintext, keyword)
println(ciphertext)

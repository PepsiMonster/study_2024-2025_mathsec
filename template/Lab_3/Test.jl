# Русский алфавит 'Ё'
russian_letters = ['А','Б','В','Г','Д','Е','Ж','З','И','Й','К','Л','М',
                   'Н','О','П','Р','С','Т','У','Ф','Х','Ц','Ч','Ш','Щ',
                   'Ъ','Ы','Ь','Э','Ю','Я']

# 
function decrypt(ciphertext::String, key::String)
    # Convert to uppercase and filter non-alphabet characters
    ciphertext = filter(c -> c in russian_letters, uppercase(ciphertext))
    key = filter(c -> c in russian_letters, uppercase(key))
    
    # Map letters to numbers
    cipher_nums = [letter_to_num[c] for c in ciphertext]
    key_nums = [letter_to_num[c] for c in key]
    
    # Extend key to match ciphertext length
    m = length(cipher_nums)
    key_nums_extended = [key_nums[(i-1) % length(key_nums) + 1] for i in 1:m]
    
    # Perform decryption
    plaintext_nums = [(cipher_nums[i] - key_nums_extended[i]) % 32 for i in 1:m]
    plaintext_nums = [num == 0 ? 32 : num for num in plaintext_nums]
    
    # Map numbers back to letters
    plaintext = [num_to_letter[num] for num in plaintext_nums]
    return join(plaintext)
end
plaintext = "ПРИКАЗ"
key = "ГАММА"

ciphertext = encrypt(plaintext, key)
println("Plaintext: $plaintext")
println("Key: $key")
println("Ciphertext: $ciphertext")

decrypted_text = decrypt(ciphertext, key)
println("Decrypted text: $decrypted_text")
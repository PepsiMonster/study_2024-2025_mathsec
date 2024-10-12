
# Русский алфавит 'Ё'
russian_letters = ['А','Б','В','Г','Д','Е','Ж','З','И','Й','К','Л','М',
                   'Н','О','П','Р','С','Т','У','Ф','Х','Ц','Ч','Ш','Щ',
                   'Ъ','Ы','Ь','Э','Ю','Я']

# Каждой букве сопотавляем ее номер и наоборот с помощью цикла for
letter_to_num = Dict{Char, Int}()
num_to_letter = Dict{Int, Char}()

for (i, letter) in enumerate(russian_letters)
    letter_to_num[letter] = i
    num_to_letter[i] = letter
end

function encrypt(plaintext::String, key::String)    
    plaintext = filter(c -> c in russian_letters, uppercase(plaintext))# Убираем не буквы и делаем все буквы большими
    key = filter(c -> c in russian_letters, uppercase(key))
    
    
    plaintext_nums = [letter_to_num[c] for c in plaintext] # Сопосталяем буквам сообщению число
    key_nums = [letter_to_num[c] for c in key] #сопоставляем буквам ключа число
    
    
    m = length(plaintext_nums)
    key_nums_extended = [key_nums[(i-1) % length(key_nums) + 1] for i in 1:m] # Делаем длинну ключа и строки одинаковой
    
    cipher_nums = [(plaintext_nums[i] + key_nums_extended[i]) % 32 for i in 1:m] # Суммируем номера букв строки и ключа
    cipher_nums = [num == 0 ? 32 : num for num in cipher_nums]                   # Делим с остатком на 32
    
    cipher_text = [num_to_letter[num] for num in cipher_nums] # теперь в зависимости от новых индексов
    return join(cipher_text)                                  # делаем новые буквы
end



# Пример
plaintext = "ПРИВЕТ КАК ДЕЛА"
key = "ГАММА"

ciphertext = encrypt(plaintext, key)
println("Сообщение: $plaintext")
println("Ключ: $key")
println("Зашифрованное Сообщение: $ciphertext")

#decrypted_text = decrypt(ciphertext, key)
#println("Decrypted text: $decrypted_text")

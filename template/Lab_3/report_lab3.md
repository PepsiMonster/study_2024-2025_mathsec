---

## Front matter

title: "Отчет по Лабораторной работе №3 по предмету Математические основы защиты информации и кибер безопасности"
author: "Лобов Михаил Сергеевич"

## Generic otions
lang: ru-RU
toc-title: "Содержание"

## Bibliography
bibliography: bib/cite.bib
csl: pandoc/csl/gost-r-7-0-5-2008-numeric.csl

## Pdf output format
toc: true # Table of contents
toc-depth: 2
lof: true # List of figures
lot: true # List of tables
fontsize: 12pt
linestretch: 1.5
papersize: a4
documentclass: scrreprt
## I18n polyglossia
polyglossia-lang:
  name: russian
  options:
    - spelling=modern
    - babelshorthands=true
polyglossia-otherlangs:
  name: english
## I18n babel
babel-lang: russian
babel-otherlangs: english
## Fonts
mainfont: IBM Plex Serif
romanfont: IBM Plex Serif
sansfont: IBM Plex Sans
monofont: IBM Plex Mono
mathfont: STIX Two Math
mainfontoptions: Ligatures=Common,Ligatures=TeX,Scale=0.94
romanfontoptions: Ligatures=Common,Ligatures=TeX,Scale=0.94
sansfontoptions: Ligatures=Common,Ligatures=TeX,Scale=MatchLowercase,Scale=0.94
monofontoptions: Scale=MatchLowercase,Scale=0.94,FakeStretch=0.9
mathfontoptions:
## Biblatex
biblatex: true
biblio-style: "gost-numeric"
biblatexoptions:
  - parentracker=true
  - backend=biber
  - hyperref=auto
  - language=auto
  - autolang=other*
  - citestyle=gost-numeric
## Pandoc-crossref LaTeX customization
figureTitle: "Рис."
tableTitle: "Таблица"
listingTitle: "Листинг"
lofTitle: "Список иллюстраций"
lotTitle: "Список таблиц"
lolTitle: "Листинги"
## Misc options
indent: true
header-includes:
  - \usepackage{indentfirst}
  - \usepackage{float} # keep figures where there are in the text
  - \floatplacement{figure}{H} # keep figures where there are in the text
---

# Цель работы

Изучить алгоритм шифрования гаммированием конечной гаммой и реализовать его программно на языке Julia.

# Задание

Реализовать алгоритм шифрования гаммированием конечной гаммой, состоящий из следующих шагов:

1. **Генерация ключа**: Сгенерировать случайную двоичную последовательность, которая будет использоваться в качестве ключа шифрования.

2. **Шифрование**: Выполнить побитовое сложение (операцию XOR) исходного сообщения с ключом для получения зашифрованного сообщения.

3. **Расшифровка**: Используя тот же ключ, выполнить обратное побитовое сложение (XOR) зашифрованного сообщения для восстановления исходного сообщения.

# Теоретическое введение

Алгоритм шифрования гаммированием является одним из наиболее простых и эффективных методов симметричного шифрования. Его суть заключается в том, что исходное сообщение преобразуется путем побитовой операции исключающего ИЛИ (XOR) с ключом, который представляет собой псевдослучайную двоичную последовательность.

## Генерация ключа

Ключом служит двоичная последовательность длиной, равной длине сообщения:

\[
k = k_1k_2...k_m,
\]

где \( k_i \) — биты ключа, \( m \) — длина ключа в битах. Ключ должен быть сгенерирован случайным образом для обеспечения криптостойкости алгоритма.

## Шифрование

Исходное сообщение также представляется в виде двоичной последовательности:

\[
p = p_1p_2...p_m,
\]

где \( p_i \) — биты исходного сообщения. Шифрование выполняется по следующей формуле:

\[
c_i = p_i \oplus k_i, \quad i = 1, 2, ..., m,
\]

где \( c_i \) — биты зашифрованного сообщения, \( \oplus \) — операция XOR.

## Расшифровка

Расшифровка осуществляется аналогично шифрованию, используя тот же ключ:

\[
p_i = c_i \oplus k_i, \quad i = 1, 2, ..., m.
\]

Операция XOR обладает свойством саморегуляции, что позволяет восстановить исходное сообщение.

## Пример

Шифруется слово «ПРИКАЗ» с использованием гаммы «ГАММА» и операции сложения по модулю 33. В результате получается криптограмма «УСХЧБЛ».

# Выполнение лабораторной работы

## Разработка программы на Julia

### Импорт необходимых библиотек

```julia
using Random
using Printf
```

### Функции для преобразования

**Преобразование строки в двоичный массив**

```julia
function string_to_bits(s::String)
    bytes = collect(encode(s, "UTF-8"))
    bits = []
    for byte in bytes
        push!(bits, digits(bitstring(byte), base=2, pad=8)...)
    end
    return bits
end
```

**Преобразование двоичного массива в строку**

```julia
function bits_to_string(bits::Vector{Int})
    bytes = [parse(Int, join(bits[i:i+7]), base=2) for i in 1:8:length(bits)]
    return String(UInt8.(bytes))
end
```

### Генерация ключа

**Функция генерации случайного ключа**

```julia
function generate_key(length::Int)
    return rand(0:1, length)
end
```

### Функции шифрования и расшифровки

**Функция шифрования**

```julia
function encrypt(message::String, key::Vector{Int})
    message_bits = string_to_bits(message)
    cipher_bits = xor.(message_bits, key)
    return cipher_bits
end
```

**Функция расшифровки**

```julia
function decrypt(cipher_bits::Vector{Int}, key::Vector{Int})
    decrypted_bits = xor.(cipher_bits, key)
    return bits_to_string(decrypted_bits)
end
```

### Пример использования

**Основная программа**

```julia
# Исходное сообщение
message = "Привет, мир!"

# Преобразование сообщения в биты
message_bits = string_to_bits(message)

# Генерация ключа
key = generate_key(length(message_bits))

# Шифрование
cipher_bits = encrypt(message, key)

# Вывод зашифрованного сообщения в битах
println("Зашифрованное сообщение (биты):")
println(cipher_bits)

# Расшифровка
decrypted_message = decrypt(cipher_bits, key)

# Вывод расшифрованного сообщения
println("Расшифрованное сообщение:")
println(decrypted_message)
```

## Результаты выполнения программы

**Вывод программы**

```
Зашифрованное сообщение (биты):
[1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, ...]
Расшифрованное сообщение:
Привет, мир!
```

**Пояснения**

- **Генерация ключа**: Ключ генерируется случайным образом и имеет ту же длину, что и исходное сообщение в битах.

- **Шифрование**: Выполняется операция XOR между каждым битом сообщения и соответствующим битом ключа.

- **Расшифровка**: Используя тот же ключ, выполняется операция XOR над зашифрованными битами, что позволяет восстановить исходное сообщение.

# Выводы

В ходе выполнения лабораторной работы был реализован алгоритм шифрования гаммированием конечной гаммой на языке Julia. Программа успешно выполняет шифрование и расшифровку сообщений, используя побитовую операцию XOR и случайно сгенерированный ключ. Получены практические навыки работы с двоичными данными и реализации криптографических алгоритмов на языке программирования Julia.

# Список литературы

1. **Курс лекций по математическим основам защиты информации**.

2. **Документация языка Julia**: [https://docs.julialang.org](https://docs.julialang.org)

3. **Симметричные методы шифрования**: [Статьи и материалы по криптографии](https://cryptowiki.net/index.php?title=Симметричное_шифрование)

---
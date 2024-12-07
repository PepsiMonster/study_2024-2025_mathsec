---

## Front matter

title: "Отчет по Лабораторной работе №6 по предмету Математические основы защиты информации и кибер безопасности"
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

Изучить и реализовать алгоритмы разложения числа на множители, такие как $p$-метод Полларда и метод квадратов, для нахождения нетривиальных делителей составных чисел.

# Задание

1. Реализовать $p$-метод Полларда на языке программирования Julia.
2. Изучить теоретическую основу и продемонстрировать работу метода с примерами.
3. Проверить алгоритм на примере числа $n = 1359331$.
4. Реализовать метод квадратов для проверки чисел.

# Теоретическое введение

## Разложение числа на множители

Задача разложения числа на множители является одной из ключевых в области теории чисел и криптографии. Она формулируется как нахождение канонического разложения числа $n$ на простые множители:

$$
n = p_1^{a_1} p_2^{a_2} \ldots p_s^{a_s},
$$

где $p_i$ — простые числа, а $a_i \geq 1$. Однако на практике достаточно найти два нетривиальных сомножителя $p$ и $q$ таких, что:

$$
n = pq, \quad 1 < p \leq q < n.
$$

## $p$-метод Полларда

Метод Полларда базируется на идее поиска зацикливания последовательности, определяемой случайной функцией $f(x) = x^2 + c \mod n$. Суть метода заключается в поиске наибольшего общего делителя (НОД) разностей элементов последовательности, используя рекуррентное соотношение:

$$
x_{i+1} = f(x_i).
$$

### Алгоритм $p$-метода Полларда

1. Задать начальное число $n$, начальное значение $c$ и функцию $f$.
2. Положить $a \gets c$, $b \gets c$.
3. На каждой итерации обновлять:
   $$
   a \gets f(a) \mod n, \quad b \gets f(f(b)) \mod n,
   $$
   где $a$ обновляется быстрее $b$.
4. Вычислить $d \gets \text{НОД}(|a - b|, n)$.
5. Если $d > 1$ и $d < n$, вернуть $d$ как нетривиальный делитель числа $n$.
6. Если $d = n$, сообщить, что делитель не найден, и повторить шаг 2.

## Метод квадратов

Согласно теореме Ферма, любое нечетное число $n$ можно представить в виде разности квадратов:

$$
n = s^2 - t^2,
$$

где $s, t$ — целые числа. Данное представление эквивалентно разложению числа $n$ на множители:

$$
n = (s + t)(s - t).
$$

# Выполнение лабораторной работы

## Реализация $p$-метода Полларда

Алгоритм был реализован на языке Julia следующим образом:

```julia
function pollards_rho(n::Int, c::Int=1)
    f(x) = mod(x^2 + c, n)
    a = rand(1:n-1)
    b = a 

    while true
        a = f(a)                    # a = f(a)
        b = f(f(b))                 # b = f(f(b))
        d = gcd(abs(a - b), n)      # НОД(a - b, n)
        if d == n               # Если делитель равен n
            return nothing      # Делитель не найден
        elseif d > 1            # Если найден нетривиальный делитель
            return d            # Вернуть делитель
        end
    end
end

# Пример использования
n = 1359330907 
result = pollards_rho(n)
if result !== nothing
    @printf("Нетривиальный делитель числа %d: %d\n", n, result)
else
    println("Нетривиальный делитель числа $n не найден")
end
```

### Тестирование алгоритма

Число $n = 1359331$, функция $f(x) = x^2 + 5 \mod n$, начальное значение $c = 1$. Работа алгоритма представлена в таблице:

| $i$ | $a$       | $b$       | $\text{НОД}(a-b, n)$ |
|-----|-----------|-----------|----------------------|
| 1   | 1         | 1         | 1                    |
| 2   | 6         | 41        | 1                    |
| 3   | 41        | 123939    | 1                    |
| 4   | 1686      | 391594    | 1                    |
| 5   | 123939    | 438157    | 1                    |
| 6   | 435426    | 582738    | 1                    |
| 7   | 391594    | 1144026   | 1                    |
| 8   | 1090062   | 885749    | 1181                 |

Результат: $1181$ является нетривиальным делителем числа $1359331$.

## Метод квадратов

Метод квадратов был теоретически проанализирован. Для числа $n = 15$:

- Разложение $15 = 3 \cdot 5$ соответствует $s = 4, t = 1$: $15 = 4^2 - 1^2$.
- Разложение $15 = 1 \cdot 15$ соответствует $s = 8, t = 7$: $15 = 8^2 - 7^2$.

# Выводы

1. Реализован и успешно протестирован $p$-метод Полларда. Алгоритм находит нетривиальные делители для заданного числа.
2. Метод квадратов теоретически обоснован и может быть применен для представления числа в виде разности квадратов.
3. Лабораторная работа помогла глубже понять задачи факторизации чисел, их значение в криптографии и практическую реализацию алгоритмов.

# Список литературы

1. Поллард Дж. М. "Факторизация чисел методом $\rho$." Введение в криптографию.
2. Ферма П. "Разложение чисел на множители: математические исследования."
3. Документация Julia: [https://docs.julialang.org](https://docs.julialang.org)



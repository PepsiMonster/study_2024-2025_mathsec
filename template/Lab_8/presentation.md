---
marp: true
theme: gaia
paginate: true
size: 16:9
class: lead
backgroundColor: '#d8c5e1'
color: '#333333'
transition: 'slide'
math: mathjax
style: |
  h1 {
    font-family: 'Arial Black', sans;
    color:rgb(54, 38, 134);
  }
  p {
    font-size: 1.1em;
    line-height: 1.6;
  }
---


**ЛАБОРАТОРНАЯ РАБОТА №8**  
**Целочисленная арифметика многократной точности**  

В данной работе рассмотрим алгоритмы для выполнения арифметических операций с большими целыми числами. Будем считать, что число записано в *b*-ичной системе счисления, *b* — натуральное число, *b ≥ 2*. Натуральное *b*-разрядное число будем записывать в виде:

**u = u₁u₂...uₙ.**

---

### Алгоритм 1 (сложение неотрицательных целых чисел)

**Вход.** Два неотрицательных числа **u = u₁u₂...uₙ** и **v = v₁v₂...vₙ**; разрядность чисел *n*; основание системы счисления *b*.  
**Выход.** Сумма **w = w₀w₁...wₙ**, где **w₀** — цифра переноса — всегда равная 0 либо 1.

1. Присвоить **j := n, k := 0** (j идет по разрядам, k следит за переносом).  
2. Присвоить **wⱼ = (uⱼ + vⱼ + k) (mod b)**, где **wⱼ** — наименьший неотрицательный вычет в данном классе вычетов;  
   **k = ⌊(uⱼ + vⱼ + k) / b⌋.**  
3. Присвоить **j := j − 1**. Если **j > 0**, то возвращаемся на шаг 2; если **j = 0**, то присвоить **w₀ := k** и результат: **w**.

---

### Алгоритм 2 (вычитание неотрицательных целых чисел)

**Вход.** Два неотрицательных числа **u = u₁u₂...uₙ** и **v = v₁v₂...vₙ**, **u > v**; разрядность чисел *n*; основание системы счисления *b*.  
**Выход.** Разность **w = w₁w₂...wₙ = u − v.**

1. Присвоить **j := n, k := 0** (k — заем из старшего разряда).

2. Присвоить **wⱼ = (uⱼ − vⱼ + k) (mod b)**, где **wⱼ** — наименьший неотрицательный вычет в данном классе вычетов;  
   **k = ⌊(uⱼ − vⱼ + k) / b⌋.**

3. Присвоить **j := j − 1**. Если **j > 0**, то возвращаемся на шаг 2; если **j = 0**, то результат: **w**.

---

### Алгоритм 3 (умножение неотрицательных целых чисел столбиком)

**Вход.** Числа **u = u₁u₂...uₙ, v = v₁v₂...vₘ**; основание системы счисления *b*.  
**Выход.** Произведение **w = uv = w₁w₂...wₙ₊ₘ**.

---

<style>

  p, li {
    font-size: 0.9em;
    line-height: 1.4;
  }
  

  ul {
    padding-left: 20px;
  }
</style>

1. Выполнить присвоения:  
   **wₘ₊₁ := 0, wₘ := 0, ..., w₁ := 0**, **j := m**  
   (j перемещается по номерам разрядов числа **v** от младших к старшим).
2. Если **vⱼ = 0**, то присвоить **wⱼ := 0** и перейти на шаг 6.
3. Присвоить **i := n, k := 0** (Значение **i** идет по номерам разрядов числа **u**, **k** отвечает за перенос).
4. Присвоить  
   **t := uᵢ ⋅ vⱼ + wᵢ₊ⱼ + k, wᵢ₊ⱼ := t (mod b), k := ⌊t / b⌋**,  
   где **wᵢ₊ⱼ** — наименьший неотрицательный вычет в данном классе вычетов.
5. Присвоить **i := i − 1**. Если **i > 0**, то возвращаемся на шаг 4, иначе присвоить **wⱼ := k**.
6. Присвоить **j := j − 1**. Если **j > 0**, то вернуться на шаг 2. Если **j = 0**, то результат: **w**.

---

### Алгоритм 4 (быстрый столбик)

**Вход.** Числа **u = u₁u₂...uₙ, v = v₁v₂...vₘ**; основание системы счисления *b*.  
**Выход.** Произведение **w = uv = w₁w₂...wₙ₊ₘ**.

1. Присвоить **t := 0**.
2. Для **s от 0 до n + m − 1 с шагом 1** выполнить шаги 3 и 4.
3. Для **t = 0** до **n** выполнить присвоение  
   **t := t + uₙ₋ₛ₊ₜ ⋅ vₘ₋ₜ₊ₛ**.
4. Вычислить  
   **wₛ₊₁ := t (mod b), t := ⌊t / b⌋**,  
   где **wₛ₊₁** — наименьший неотрицательный вычет по модулю *b*.  
   Результат: **w**.

---

### Алгоритм 5 (деление многоразрядных целых чисел)

**Вход.** Числа **u = uₙ...u₁u₀, v = vₜ...v₁v₀**, **n ≥ t ≥ 1, vₜ ≠ 0**, разрядность чисел соответственно **n** и **t**.  
**Выход.** Частное **q = qₙ₋ₜ...q₀**, остаток **r = rₜ...r₀**.

---
<style>

  p, li {
    font-size: 0.8em;
    line-height: 1.4;
  }
  

  ul {
    padding-left: 20px;
  }
</style>

1. Для **j** от 0 до **n − t** присвоить **qⱼ := 0**.
2. Пока **u ≥ v bⁿ⁻ᵗ**, выполнять:  
   **qₙ₋ₜ := qₙ₋ₜ + 1, u := u − v bⁿ⁻ᵗ.**
3. Для **i := n, n − 1, ..., t + 1** выполнять пункты 3.1 – 3.4:  
   **3.1.** Если **uᵢ ≥ vₜ**, то присвоить  
   **qᵢ₋ₜ₋₁ := b − 1**,  
   иначе присвоить  
   **qᵢ₋ₜ₋₁ := ⌊(uᵢb + uᵢ₋₁) / vₜ⌋.**  

   **3.2.** Пока  
   **qᵢ₋ₜ₋₁(vₜb + vₜ₋₁) > uᵢb² + uᵢ₋₁b + uᵢ₋₂**,  
   выполнять  
   **qᵢ₋ₜ₋₁ := qᵢ₋ₜ₋₁ − 1.**

   **3.3.** Присвоить  
   **u := u − qᵢ₋ₜ₋₁v bⁱ⁻ᵗ⁻¹.**

   **3.4.** Если **u < 0**, то присвоить  
   **u := u + v bⁱ⁻ᵗ⁻¹, qᵢ₋ₜ₋₁ := qᵢ₋ₜ₋₁ − 1.**
4. **r := u.**  
Результат: **q и r.**

---

**Примеры результатов вычисления:**

Сложение:
u = 123456789012345
v = 987654321098765
w = 1111111110111110

Вычитание:
u = 987654321098765
v = 123456789012345
w = 864197532086420

Умножение столбиком:
u = 123456789012345
v = 678901234567890
w = 838102341346165530864197532086050

---
Быстрое умножение:
u = 123456789012345
v = 678901234567890
w = 838102341346165530864197532086050

Деление:
u = 1000000000000000
v = 250000000000000
q = 4
r = 0

Деление (Дополнительный Пример):
u = 1234567890123456789012345
v = 123456789012345
q = 10000000001000000000
r = 12345

---

### __Выводы__
В ходе данной лабораторной работы было рассмотрено 5 алгоритмов, обспечивающих более высокую производительность машинного сложения, вычитание, умножения и деления больших чисел. Данные алгоритмы были программно реализованы на языке ***Julia***. Данные программы могут быть использованы для работы с числами любой счетной системы (в частности десятичной) и превышающими размер стандартных типов данных. 
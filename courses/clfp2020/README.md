# Мова Common Lisp: вступ до функціонального програмування

У цьому курсі розглядаються основні принципи функціонального підходу
до програмування, його переваги та недоліки, а також елементи
математичного апарату, на якому він базується. В якості основного
інструменту використовуєтся мова програмування *Common Lisp*.




## Практика

Практичні завдання, передбачені у цьому курсі, оцінюються наступним
чином:

| Завдання              | Бал до 30.04.2020 | Бал з 1.05.2020 |
|-----------------------|-------------------|-----------------|
| Лабораторна робота №1 | 10                | 0               |
| Лабораторна робота №2 | 15                | 5               |
| Лабораторна робота №3 | 15                | 7               |
| Лабораторна робота №4 | 15                | 9               |
| Лабораторна робота №5 | 15                | 11              |
| Лабораторна робота №6 | 15                | 13              |
| РГР №1                | 15                | 15              |
| **Всього**            | **100**           | **60**          |


### Лабораторна робота №1 - підготовка середовища розробки

Однією з традиційних особливостей мов програмування з сімейства *Lisp*
є те, що практично всі компоненти сучасного інтергрованого середовища
розробки програмного забезпечення (*IDE*) є "вбудованими" в
компілятор. Типове середовище *Lisp* - це інтерактивний інструмент під
назвою **REPL** (*Read-Eval-Print Loop*), що може читати, компілювати
та виконувати код, введений користувачем, автоматично переходячи в
режим дебагу при виникненні помилки. Багато сучасних мов
програмування, зокрема *Python*, використовують спрощені версії
подібних середовищ для екпериментів та прототипування, але дуже мало з
них можуть навіть наблизитись за функціональністю до *REPL*-середовищ
популярних компіляторів *Common Lisp*, в першу чергу через систему
обробки помилок, що передбачена стандартом мови.

Дана лабораторна робота полягає у налаштуванні середовища *Common
Lisp*, що складається з компілятора, текстового редактора та адаптера
для взаємодії між редактором та компілятором. Ми використовуватимемо
відкритий компілятор **SBCL**, який на даний момент є найращим
безкоштовним компілятором *Common Lisp*, текстовий редактор **Emacs**,
який вже кілька десятиліть є одним з найпопулярніших текстових
редакторів у світі, та плагін для *Emacs* під назвою **SLIME**, який і
є адаптером між текстовим редактором та компілятором.

#### Встановлення програмного забезпечення

Для встановлення *SBCL* та *Emacs* 26.2 на операційну систему *Linux*
необхідно виконати наступні команди (приклади наведено для
дистрибутиву Ubuntu):

``` bash
# Додаткові пакети
sudo apt install git
# SBCL
sudo apt install sbcl
# Emacs
sudo apt-add-repository ppa:kelleyk/emacs
sudo apt update
sudo apt install emacs26
```

На *macOS* *Emacs* можна встановити, виконавши наступну команду:

``` bash
# SBCL
brew intall sbcl
# Emacs
brew cask install emacs
```

Для операційної системи *Windows* *SBCL* та *Emacs* можна завантажити
за посиланнями
http://prdownloads.sourceforge.net/sbcl/sbcl-2.0.0-x86-64-windows-binary.msi
та
https://ftp.gnu.org/gnu/emacs/windows/emacs-26/emacs-26.1-x86_64.zip
відповідно. Для запуску редактора необхідно виконати файл
`bin\runemacs.exe`. Зверніть увагу на те, що для налаштування адаптера
необхідно знати шлях, за яким було встановлено компілятор.

Після того, як втановлення *SBCL* та *Emacs* завершено, необхідно
встановити плагін *SLIME*. Це можна зробити самостійно відповідно до
[інструкцій](https://github.com/slime/slime), або скористатись файлом
`.emacs` у даній директорії, який необхідно розмістити у "домашній"
директорії на робочому комп'ютері (`/home/<username>/.emacs` на
*Linux*, `/Users/<username>/.emacs` на *macOS* та
`%HOMEPATH%\AppData\Roaming\.emacs` на *Windows*). У випадку з Windows
необхідно у цьому файлі замінити змінну `inferior-lisp-program` на
шлях, за яким було встановлено компілятор *SBCL*. Можна помітити, що
конфігурація та розширення (розробка плагінів) текстового редактора
*Emacs* здійснюється за допомогою діалекта *Lisp* під назвою *Emacs
Lisp* або *Elisp*.

При запуску *Emacs* встановить всі необхідні компоненти і відкриє файл
під назвою `*scratch*`, який є спеціальною "чернеткою" для нотаток та
налаштувань. Після цього можна потестувати налаштування середовища,
натиснувши комбінацію клавіш `Alt+x` для переходу в режим команд і
виконати команду `slime`, яка запустить компілятор *SBCL*, налаштує
адаптер та покаже рядок введення *REPL*:

``` cl
CL-USER>

```

У цьому вікні редактора можна безпосередньо вводити, редагувати,
компілювати та виконувати програмний код *Common Lisp*.

#### Docker

Всі описані вище кроки зібрані у вигляді рецепту Docker (файл
`Dockerfile` у даній директорії), тому за наявності налаштованого
середовища *Docker* можна просто зібрати *Docker*-образ та запустити
середовище *Common Lisp* у контейнері *Docker*:

``` bash
docker build -t lisp .
docker run -it --rm lisp emacs
```

#### Захист лабораторної роботи

Для захисту лабораторної роботи необхідно продемонструвати запуск та
зупинку робочого *REPL*-середовища, виконати кілька простих
арифметичних обчислень а також оголосити будь-яку арифметичну функцію
від 2-х і більше параметрів та, викликавши її, отримати очікуваний
результат.


### Лабораторна робота №2 - основи програмування мовою *Common Lisp*

У даній лабораторній роботі необхідно реалізувати 3 типи асоціативних
структур даних:

- `associative-list` - список, що містить `cons`-пари `(<ключ>
  . <значення>)` (приклад: `((:a . 1) (:b . 2) (:c . 3))`);
- `property-list` - список, що містить парну кількість елементів, де
  непарні елементи є ключами, а парні - значеннями (приклад: `(:a 1 :b
  2 :c 3)`);
- `binary-tree` - бінарне дерево пошуку, що в якості ключів
  використовує символи - їх можна порівнювати лексикографічно за
  допомогою функцій `string<`, `string>`
  [тощо](http://www.lispworks.com/documentation/HyperSpec/Body/f_stgeq_.htm).

Для кожної структури даних потрібно реалізувати 2 функції - додавання
нової асоціації та пошуку значення за ключем:

``` cl
;; Associative list
(defun associative-list-add (list key value)
  ...)

(defun associative-list-get (list key)
  ...)

;; Property list
(defun property-list-add (list key value)
  ...)

(defun property-list-get (list key)
  ...)

;; Binary list
(defun binary-tree-add (tree key value)
  ...)

(defun binary-tree-get (tree key)
  ...)
```

Функція додавання нової асоціації повинна повертати конструювати та
повертати нову структуру. Наприклад, для додавання нової пари `(ключ,
значення)` в асоціативний список необхідно присвоїти результат функції
якійсь змінній, інакше його буде втрачено:

``` cl
CL-USER> (let ((list '()))
           (setf (associative-list-add list :a 1))
           list)
((:a . 1))
```

Функція пошуку значення за ключем повинна повертати два значення - сам
елемент, що відповіє ключу, або `nil`, якщо такого ключа немає, та
маркер `t` або `nil`, що вказує на присутність чи відсутність ключа
відповідно (аналогічно до того, як працює функція пошуку в хеш-таблиці
`gethash`):

``` cl
CL-USER> (defvar *list* '())
*LIST*

CL-USER> (setf *list* (associative-list-add *list* :a 1))
((:a . 1))

CL-USER> (associative-list-get *list* :a)
1
T

CL-USER> (associative-list-get *list* :b)
NIL
NIL
```


#### Захист лабораторної роботи

Для захисту лабораторної роботи необхідно для кожної з реалізованих
структур даних створити змінну з порожньою структурою, додати кілька
елементів і здійснити пошук за існуючим та неіснуючим ключами. Окрім
цього необхідно продемонструвати створення непорожньої структури даних
(з одним-двома елементами) без використання функції додавання
асоціації для демонстрації розуміння спискової структури структури
(тавтологія невипадкова :)).



### Лабораторна робота №3 - рекурсивні оператори `map`, `filter` та `reduce`

Одним з найважливіших інструментів функціонального програмування є
*функції вищого порядку* - функції, що приймають інші функції в якості
аргументів, а також повертають функції як результат. Поширеним
застосуванням функцій вищого порядку є функції, що обходять структури
даних, які зберігають набори елементів (як впорядковані, та і
невпорядковані), певним чином застосовуючи функцію-аргумент до кожного
елемента у наборі і комбінуючи отримані значення. Набори даних
найчастіше представляють у вигляді списків та дерев, які описуються
рекурсивними математичними визначеннями, тому процедури, що здійснюють
обхід таких структур, легко реалізувати за допомогою рекурсії,
повторюючи рекурсивне визначення самої структури. Такі процедури часто
називають *рекурсивними операторами*. Найбільш відомими широкому
загалу рекурсивними операторами є оператори `map`, `filter` та
`fold`, які можна знайти в стандартних бібліотеках багатьох сучасних
мов програмування:

| Оператор | Common Lisp         | Python                   | Java                  | JavaScript   |
|----------|---------------------|--------------------------|-----------------------|--------------|
| `map`    | `mapcar f s`        | `map(f, s)`              | `Stream.map(f)`       | `.map(f)`    |
| `filter` | `remove-if-not f s` | `filter(p, s)`           | `Stream.filter(p)`    | `.filter(p)` |
| `fold`   | `reduce f s`        | `functools.reduce(f, s)` | `Stream.reduce(u, f)` | `.reduce(f)` |

Розглянемо варіанти цих функцій, що працюють зі списками:
  - функція `map` приймає аргументами функцію від одного аргумента <a href="https://www.codecogs.com/eqnedit.php?latex=F(x)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?F(x)" title="F(x)" /></a> та список

    > <a href="https://www.codecogs.com/eqnedit.php?latex=S&space;=&space;[s_1,&space;s_2,&space;...,&space;s_n]," target="_blank"><img src="https://latex.codecogs.com/gif.latex?S&space;=&space;[s_1,&space;s_2,&space;...,&space;s_n]," title="S = [s_1, s_2, ..., s_n]," /></a>

    і повертає результатом список

    > <a href="https://www.codecogs.com/eqnedit.php?latex=R&space;=&space;[F(s_1),&space;F(s_2),&space;...,&space;F(s_n)]," target="_blank"><img src="https://latex.codecogs.com/gif.latex?R&space;=&space;[F(s_1),&space;F(s_2),&space;...,&space;F(s_n)]," title="R = [F(s_1), F(s_2), ..., F(s_n)]," /></a>

    тобто список з такою ж кількістю елементів, як і вхідний список, але кожен елемент <a href="https://www.codecogs.com/eqnedit.php?latex=r_i" target="_blank"><img src="https://latex.codecogs.com/gif.latex?r_i" title="r_i" /></a> якого є значенням функції <a href="https://www.codecogs.com/eqnedit.php?latex=F(s_i)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?F(s_i)" title="F(s_i)" /></a> від відповідного елемента списка <a href="https://www.codecogs.com/eqnedit.php?latex=s" target="_blank"><img src="https://latex.codecogs.com/gif.latex?s" title="s" /></a>;

  - функція `filter` приймає аргументами предикат від одного аргумента <a href="https://www.codecogs.com/eqnedit.php?latex=P(x)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?P(x)" title="P(x)" /></a> та список

    > <a href="https://www.codecogs.com/eqnedit.php?latex=S&space;=&space;[s_1,&space;s_2,&space;...,&space;s_n]," target="_blank"><img src="https://latex.codecogs.com/gif.latex?S&space;=&space;[s_1,&space;s_2,&space;...,&space;s_n]," title="S = [s_1, s_2, ..., s_n]," /></a>

    і повертає результатом список

    > <a href="https://www.codecogs.com/eqnedit.php?latex=R&space;=&space;[s_i&space;|&space;P(s_i)&space;=&space;True]" target="_blank"><img src="https://latex.codecogs.com/gif.latex?R&space;=&space;[s_i&space;|&space;P(s_i)&space;=&space;True]" title="R = [s_i | P(s_i) = True]" /></a>

    тобто список, що містить лише ті елементи <a href="https://www.codecogs.com/eqnedit.php?latex=s_i" target="_blank"><img src="https://latex.codecogs.com/gif.latex?s_i" title="s_i" /></a> вхідного списка, значення предиката для яких <a href="https://www.codecogs.com/eqnedit.php?latex=P(s_i)&space;=&space;True" target="_blank"><img src="https://latex.codecogs.com/gif.latex?P(s_i)&space;=&space;True" title="P(s_i) = True" /></a> (у випадку *Common Lisp* - **не** `NIL`);

  - функція `fold` приймає аргументами функцію від двох аргументів <a href="https://www.codecogs.com/eqnedit.php?latex=F(a,&space;x)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?F(a,&space;x)" title="F(a, x)" /></a>, список

    > <a href="https://www.codecogs.com/eqnedit.php?latex=S&space;=&space;[s_1,&space;s_2,&space;...,&space;s_n]," target="_blank"><img src="https://latex.codecogs.com/gif.latex?S&space;=&space;[s_1,&space;s_2,&space;...,&space;s_n]," title="S = [s_1, s_2, ..., s_n]," /></a>

    та необов'язкове (опційне) початкове значення <a href="https://www.codecogs.com/eqnedit.php?latex=u" target="_blank"><img src="https://latex.codecogs.com/gif.latex?u" title="u" /></a>, і повертає результатом значення

    > <a href="https://www.codecogs.com/eqnedit.php?latex=r_n&space;=&space;F(...F(F(F(u,&space;s_1),&space;s_2),&space;s_3)...,&space;s_n)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?r_n&space;=&space;F(...F(F(F(u,&space;s_1),&space;s_2),&space;s_3)...,&space;s_n)" title="r_n = F(...F(F(F(u, s_1), s_2), s_3)..., s_n)" /></a>

    тобто результат послідовного застосування функції <a href="https://www.codecogs.com/eqnedit.php?latex=F(a,&space;x)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?F(a,&space;x)" title="F(a, x)" /></a> до попереднього проміжного значення <a href="https://www.codecogs.com/eqnedit.php?latex=r_i" target="_blank"><img src="https://latex.codecogs.com/gif.latex?r_i" title="r_i" /></a> та кожного елемента вхідного списку <a href="https://www.codecogs.com/eqnedit.php?latex=s_i" target="_blank"><img src="https://latex.codecogs.com/gif.latex?s_i" title="s_i" /></a>:

    > <a href="https://www.codecogs.com/eqnedit.php?latex=r_{i&plus;1}&space;=&space;F(r_i,&space;s_i)," target="_blank"><img src="https://latex.codecogs.com/gif.latex?r_{i&plus;1}&space;=&space;F(r_i,&space;s_i)," title="r_{i+1} = F(r_i, s_i)," /></a>

    де <a href="https://www.codecogs.com/eqnedit.php?latex=r_1&space;=&space;u" target="_blank"><img src="https://latex.codecogs.com/gif.latex?r_1&space;=&space;u" title="r_1 = u" /></a>, якщо <a href="https://www.codecogs.com/eqnedit.php?latex=u" target="_blank"><img src="https://latex.codecogs.com/gif.latex?u" title="u" /></a> наявне, або <a href="https://www.codecogs.com/eqnedit.php?latex=r_1&space;=&space;s_1" target="_blank"><img src="https://latex.codecogs.com/gif.latex?r_1&space;=&space;s_1" title="r_1 = s_1" /></a>.

Для того, щоб детальніше розібратись з роботою цих операторів, можна
поекспериментувати з стандартними функціями *Common Lisp*, що їх
реалізують (див. табличку вище).


#### Захист лабораторної роботи

Для захисту лабораторної роботи необхідно продемонструвати роботу всіх
трьох функцій, що описані вище, для випадків порожнього списку, списку
з одним елементом, та списку з будь-якою іншою кількістю елементів.




## Ресурси

Для поглибленого вивчення матеріалу, що розглядається в даному курсі,
рекомендую наступні ресурси:

1. [*Common Lisp
   Hyperspec*](http://www.lispworks.com/documentation/HyperSpec/Front/index.htm) -
   (майже) повний текст стандарту *Common Lisp* у відкритому
   доступі. Пошук по даному ресурсу можна здійснювати безпосередньо з
   *Emacs* (при ввімкненому режимі *SLIME*), за допомогою комбінації
   клавіш `C-c h` - сторінка з сайту буде відображена безпосередньо в
   текстовому редакторі.

2. [*Structure and Interpretation of Computer
   Programs*](https://www.youtube.com/watch?v=2Op3QLzMgSY) -
   відеозапис курсу лекцій, прочитаного Гелом Абельсоном та Джеральдом
   Джеєм Сасманом в Массачусетському технологічному інституті 1986
   року. Курс використовує мінімалістичний та елегантний діалект
   *Lisp* під назвою *Scheme* і до цього часу вважається одним з
   найкращих курсів про основи побудови комп'ютерних програм. Курс
   супроводжується книгою тих же авторів, що знаходиться у [відкритому
   доступі](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book.html).

3. [*Purely Functional Data
   Structures*](https://www.amazon.com/Purely-Functional-Data-Structures-Okasaki/dp/0521663504) -
   книга, що принципи та приклади ефективної побудови структур даних,
   використовуючи "чистий" функціональний підхід - операції, що
   повинні модифікувати такі структури, натомість повертають нові
   об'єкти, що дозволяє позбутися стану, прихованого у традиційних
   структурах даних (таких, що передбачають безпосередню модифікацію),
   і тому зберігає математичні властивості як функцій, що реалізують
   такі операції, так і самих структур.

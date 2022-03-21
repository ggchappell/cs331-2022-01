\ adv.fs  UNFINISHED
\ Glenn G. Chappell
\ 2022-03-21
\
\ For CS F331 / CSCE A331 Spring 2022
\ Code from 3/21 - Forth: Advanced Flow


cr cr
." This file contains sample code from March 21, 2022," cr
." for the topic 'Forth: Advanced Flow'." cr
." It will execute, but it is not intended to do anything" cr
." useful. See the source." cr
cr


\ ***** Parsing Words *****


\ Some Forth words have access to the code that comes after them. These
\ are called *parsing words*. Examples of parsing words that we have
\ seen include "see" and "to".

\ hello
\ Simple example word. Prints newline, a greeting, and another newline.
: hello  ( -- )
  cr
  ." Hello there!" cr
;

\ Try:
\   see hello


\ ***** Tokens *****


\ In Forth, a *token* is an integer that represents some entity.

\ ** Execution Tokens **

\ An *execution token* is a number that represents the code for some
\ executable word. When typing code interactively, get the execution
\ token for an executable word using the parsing word ' (single quote);
\ the next word should be the word whose execution token you want.

\ Try:
\   ' hello .
\   ' dup .
\   ' hello .

\ In a compiled context, ' should be replaced by ['] (single quote in
\ brackets).

\ print-hello-xt
\ Prints execution token for word "hello".
: print-hello-xt  ( -- )
  cr
  ['] hello . cr
;

\ Try:
\   print-hello-xt
\   ' hello .

\ The word "execute" takes an execution token, which it pops off the
\ data stack. It then executes the corresponding code.

\ Try:
\ 5 7 ' + execute .

\ This lets us pass a word to another word. Below is a word that takes
\ an execution token and calls the corresponding code with certain
\ parameters.

\ apply-to-5-7
\ Takes an execution token, which is popped. Executes the corresponding
\ code with 5 7 on the data stack. The "in1 ... inm" in the stack effect
\ below represent any other parameters the code to be executed might
\ have. The "out1 ... outn" are its results.
: apply-to-5-7  ( in1 ... inm xt -- out1 ... outn )
  { xt }
  5 7 xt execute
;

\ Try:
\   ' + apply-to-5-7 .
\   ' * apply-to-5-7 .

\ Now we can write "map", as we did in Haskell. We reuse words intsize,
\ print-array and set-array from alloc.fs. As before, sizei is the
\ number of items in an integer array, not the number of bytes required.

\ intsize
\ Assumed size of integer (bytes)
: intsize 8 ;

\ print-array
\ Prints items in given integer array, all on one line, blank-separated,
\ ending with newline.
: print-array  { addr sizei -- }
  sizei 0 ?do
      i intsize * addr + @ .
  loop
  cr
;

\ set-array
\ Sets values in given array. Array starts at addr and holds sizei
\ integers. Item 0 is set to start, item 1 to start+step, item 2 to
\ start+2*step, etc.
: set-array  { start step addr sizei -- }
  start { val }
  sizei 0 ?do
    val i intsize * addr + !
    val step + to val
  loop
;

\ NOTE on "throw". We will discuss the details of exception handling
\ later. For now, "throw" throws an exception when given a nonzero
\ parameter. When given zero, it does nothing. So we can do this:
\
\   sizei 0 < throw
\
\ And we can do this:
\
\   len allocate throw { addr }
\
\ Lastly instead of getting the error code from "free" and wondering
\ what to do with it
\
\   addr free { free-fail? }
\
\ we can do this:
\
\   addr free throw

\ map-array
\ Given an integer array, represented as pointer + number of items, and
\ an execution token for code whose effect is of the form ( a -- b ).
\ Does an in-place map, using the execution token as a function. That
\ is, for each item in the array, passes the item to this function,
\ replacing the array item with the result. Throws on bad array size.
: map-array  \ TODO: WRITE THIS!!!
;

\ square
\ Returns the square of its parameter. Example for use with map-array.
: square  { x -- x**2 }
  x x *
;

\ call-map
\ Creates an integer array holding the given number of items, filling it
\ with data, and calls map-array, passing "square", on this array. The
\ array items are printed before and after the map. Throws on failed
\ allocate/deallocate.
: call-map  { sizei -- }
  sizei intsize * allocate throw { arr }
                           \ Throw on failed allocate (see NOTE above)
  1 1 arr sizei set-array  \ Fill array: 1, 2, 3, ...
  cr
  ." Doing map-array with square" cr
  ." Values before map: " arr sizei print-array
  arr sizei ['] square map-array
  ." Values after map: " arr sizei print-array
  arr free throw           \ Throw on failed deallocate (see NOTE above)
;

\ Try:
\   18 call-map

\ ** Name Tokens **

\ A *name token* is a number that represents the name of some word.

\ Convert an execution token to a name token with ">name".
\ >name  ( xt -- nt )

\ Convert a name token to string with "name>string".
\ name>string  ( nt -- str-addr str-len )

\ print-name
\ Given the execution token for a word, prints a message giving the name
\ of the word, in quotes.
: print-name  \ TODO: WRITE THIS!!!
;

\ Try:
\   ' hello print-name


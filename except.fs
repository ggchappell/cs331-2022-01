\ except.fs  UNFINISHED
\ Glenn G. Chappell
\ 2022-03-23
\
\ For CS F331 / CSCE A331 Spring 2022
\ Code from 3/23 - Forth: Exceptions


cr cr
." This file contains sample code from March 23, 2023," cr
." for the topic 'Forth: Exceptions'." cr
." It will execute, but it is not intended to do anything" cr
." useful. See the source." cr
cr


\ Forth has exception handling. This works similarly to other PLs with
\ exceptions (C++, Python). When an exception is thrown, the currently
\ executing code is exited. If a handler is found, then this is
\ executed; otherwise, the program crashes.
\
\ However, since Forth has neither type checking nor an extensible type
\ system, different kinds of exceptions are not distinguished by type,
\ as they are in many other PLs. Instead the kind of exception is given
\ by an integer. Zero means "no exception". Values -255 through -1 are
\ reserved for certain predefined exceptions (on my version of Gforth,
\ -58 through -1 are used, with -255 through -59 being reserved for
\ future use). Values -4095 through -256 are assigned by the system. So
\ if you want to use your own exception numbers, these should be either
\ positive or less than -4095.


\ ***** throw *****


\ To throw an exception, use "throw".
\ throw  ( exception-code -- )
\ If the exception code is zero, then "throw" does nothing. Otherwise,
\ an exception with the given number is thrown. In the absence of a
\ handler (given by "catch" or try/restore/endtry -- discussed later),
\ this will crash the program.

\ Try:
\   42 throw
\   0 throw
\   -1 throw

\ When a program crashes due to an exception, the message printed will
\ generally look something like the following.
\
\   :4: error 42
\   42 >>>throw<<<
\   Backtrace:
\
\ If the exception was thrown by code in a file, then information about
\ the file is printed before the above.
\
\ On the first line above, the number between colons is a counter: 1 for
\ the first exception, 2 for the second, etc. The rest of that line is
\ an error-message string. We discuss how to set these later. If no
\ error message has been set, then the string printed is "error"
\ followed by the exception code, as in the above example.
\
\ The second line shows the code where the exception happened. The word
\ that produced the exception is shown by ">>> ... <<<".
\
\ The third line says "Backtrace:". On the lines following that are the
\ contents of the return stack, from top to bottom, showing what words
\ called what words.

: aa 88 throw ;
: bb aa ;
: cc bb ;
: dd cc ;

\ Try:
\   dd
\ Note the backtrace.

\ Error codes returned by words that do things like memory allocation or
\ file I/O are generally designed to be passed directly to "throw".
\ Typically, these will have an associated error-message string.

\ Try:
\   -2 allocate throw
\ Note the error-message string that is printed.

\ Exception code -1 has the error-message string "Aborted". So, if you
\ do not mind having such a general error message, you can pass a
\ Boolean returned by one of the comparison operators (value 0 or -1) to
\ "throw".

\ myval
\ A number to test.
: myval -42 ;

\ Try:
\   myval 0 < throw


\ ***** exception *****


\ To assocate an exception code to a given error-message string, pass
\ the string (address & length) to "exception". The return value is the
\ exception code, which will be in the range -4095 .. -256. Successive
\ calls to "exception" will return different codes.
\ exception  ( str-addr str-len -- exception-code )

\ Try:
\   s" A bad thing happened" exception throw
\ Note the error-message string that is printed.

\ Here is a word that may throw, using "exception" if it does.

\ mysqrt
\ Given an integer, returns the floor of its square root. Throws on a
\ negative parameter.
: mysqrt  ( x -- sqrt(x) )
  \ TODO: WRITE THIS!!!
;

\ Try:
\   40 mysqrt .
\   -40 mysqrt .


\ ***** catch *****


\ Use "catch" to catch an exception that might be thrown by some word.
\ As in other PLs, this includes exceptions thrown by other words that
\ it calls, if those exceptions have not been caught inside the word.
\
\ "catch" is similar to "execute": it takes an execution token, and then
\ it executes the code. However, it also catches exceptions. After the
\ word is executed:
\ - If no exception was thrown: push 0.
\ - If an exception was thrown: the stack has the same depth as before
\   "catch" was called. The top item (previously the execution token) is
\   replaced by the exception code. Any other items that were popped off
\   by execution are replaced by arbitrary data. Items lower on the
\   stack remain unchanged.
\
\ Note that, after "catch", the top of the stack is 0 if no exception
\ was thrown; it is the exception code (which is nonzero) if an
\ exception was thrown. So we can test whether an exception was thrown
\ with "if".
\
\ Exception-handling code is allowed to re-throw the exception, or a
\ different kind of exception (there is no special mechanism for this;
\ pass an exception code to "throw", as usual). If this is *not* done,
\ then exception-handling code should call "nothrow", which resets the
\ information stored about the exception, so it does not get mixed up
\ with that for later exceptions.
\ nothrow  ( -- )

\ call-mysqrt
\ Pass the given value to "mysqrt", catching any exception thrown and
\ printing the results (exception or not).
: call-mysqrt  { x -- }
  cr cr
  ." Passing " x . ." to mysqrt" cr
  x ['] mysqrt catch { exception-code }
  exception-code if
    \ An exception was thrown
    { dummy1 }  \ This line bascially functions as a "drop". "dummy1"
                \  corresponds to x, which was on the stack before
                \  "catch" (remember that, if an exception is thrown,
                \  then the stack depth after "catch" is the same as it
                \  was before "catch").
    ." Exception thrown; code: " exception-code . cr
    nothrow     \ Reset error handling (does not affect the stack)
                \ Do this if we do NOT re-throw
  else
    \ No exception was thrown
    { result }
    ." No exception thrown" cr
    ." Result: " result . cr
  endif
  cr
;

\ Try:
\   40 call-mysqrt
\   -40 call-mysqrt

\ Here is much the same idea as call-mysqrt, except that, if mysqrt
\ throws an exception, then we re-throw the same kind of exception.

\ call-mysqrt2
\ Pass the given value to "mysqrt", catching any exception thrown and
\ printing the results (exception or not). If an exception is thrown,
\ then we re-throw the same kind of exception.
: call-mysqrt2  { x -- }
  cr cr
  ." Passing " x . ." to mysqrt" cr
  x ['] mysqrt catch { exception-code }
  exception-code if
    \ An exception was thrown
    { dummy1 }  \ This line bascially functions as a "drop". "dummy1"
                \  corresponds to x, which was on the stack before
                \  "catch" (remember that, if an exception is thrown,
                \  then the stack depth after "catch" is the same as it
                \  was before "catch").
    ." Exception thrown; code: " exception-code . cr
    exception-code throw
                \ Re-throw the exception
  else
    \ No exception was thrown
    { result }
    ." No exception thrown" cr
    ." Result: " result . cr
  endif
  cr
;

\ Try:
\   40 call-mysqrt2
\   -40 call-mysqrt2


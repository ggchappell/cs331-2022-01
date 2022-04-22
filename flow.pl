% flow.pl  UNFINISHED
% Glenn G. Chappell
% 2022-04-22
%
% For CS F331 / CSCE A331 Spring 2022
% Code from 4/22 - Prolog: Flow of Control


% ***** Preliminaries *****


% Output atom (think: string): write(ATOM)
% Output newline: nl
% Both always succeed.

% hello_world/0
% Print hello-world message.
hello_world :- write('Hello, world!'), nl.

% Try:
%   ?- hello_world.

% read/1 reads a Prolog term (which must end with a period!) from the
% standard input and unifies it with the argument. Output from write/1
% that is done before read/1 may not appear unless the standard output
% is flushed. This can be done with flush/0.

% Try:
%   ?- write('Type a number followed by dot: '), flush, read(X).

% true/0 - always succeeds
% fail/0 - never succeeds

% Try:
%   ?- true.
%   ?- fail.


% ***** Basic Repetition *****


% ***** Encapsulated Flow *****


% ***** Cut *****


% "!" (read as "cut")
% - Always succeeds.
% - Once a cut has been done:
%   - Backtracking past the cut is not allowed, for the current goal.
%   - Included in this: use of another definition for the current goal
%     is not allowed.




% Here is our "gcd" predicate from simple.pl:
gcd(0, B, B).
gcd(A, B, C) :- A > 0, BMA is B mod A, gcd(BMA, A, C).


% ***** Other *****


"=========================================================================
" ZX Spectrum BASIC syntax
"=========================================================================

if exists("b:current_syntax")
  finish
endif

"-------------------------------------------------------------------------
" Comments
"-------------------------------------------------------------------------

syntax match zxbComment "\c\<REM\>.*$"

"-------------------------------------------------------------------------
" Strings
"-------------------------------------------------------------------------

syntax region zxbString start=+"+ skip=+""+ end=+"+

"-------------------------------------------------------------------------
" Line numbers
"-------------------------------------------------------------------------

syntax match zxbLineNumber "^\s*\d\+"

"-------------------------------------------------------------------------
" Numbers
"-------------------------------------------------------------------------

syntax match zxbNumber "\<\d\+\>"

"-------------------------------------------------------------------------
" Flow control
"-------------------------------------------------------------------------

syntax keyword zxbFlow
    \ IF THEN ELSE
    \ FOR TO STEP NEXT
    \ GO TO GOTO
    \ GO SUB GOSUB
    \ RETURN
    \ STOP CONTINUE
    \ RUN
    \ PAUSE

"-------------------------------------------------------------------------
" Variables / assignment
"-------------------------------------------------------------------------

syntax keyword zxbStatement
    \ LET
    \ DIM
    \ DEF FN
    \ READ
    \ DATA
    \ RESTORE

"-------------------------------------------------------------------------
" Screen & text
"-------------------------------------------------------------------------

syntax keyword zxbScreen
    \ PRINT
    \ INPUT
    \ LPRINT
    \ LLIST
    \ LIST
    \ CLS
    \ AT
    \ TAB
"-------------------------------------------------------------------------
" Screen colours / attributes
"-------------------------------------------------------------------------

syntax keyword zxbColour
    \ INK
    \ PAPER
    \ BORDER
    \ FLASH
    \ BRIGHT
    \ INVERSE
    \ OVER

"-------------------------------------------------------------------------
" Graphics
"-------------------------------------------------------------------------

syntax keyword zxbGraphics
    \ PLOT
    \ DRAW
    \ CIRCLE

"-------------------------------------------------------------------------
" Sound
"-------------------------------------------------------------------------

syntax keyword zxbSound BEEP

"-------------------------------------------------------------------------
" Memory / machine
"-------------------------------------------------------------------------

syntax keyword zxbMachine
    \ PEEK
    \ POKE
    \ USR
    \ RANDOMIZE
    \ CLEAR
    \ NEW
    \ CONT
    \ COPY

"-------------------------------------------------------------------------
" Tape / files
"-------------------------------------------------------------------------

syntax keyword zxbStorage
    \ LOAD
    \ SAVE
    \ VERIFY
    \ MERGE
    \ ERASE
    \ CAT
    \ FORMAT
    \ MOVE

syntax match zxbStorage "\<OPEN\s*#\>"
syntax match zxbStorage "\<CLOSE\s*#\>"

"-------------------------------------------------------------------------
" Functions
"-------------------------------------------------------------------------

syntax keyword zxbFunction
    \ ABS
    \ ASN
    \ ACS
    \ ATN
    \ COS
    \ SIN
    \ TAN
    \ EXP
    \ INT
    \ LN
    \ SGN
    \ SQR
    \ CODE
    \ CHR$
    \ STR$
    \ VAL
    \ VAL$
    \ LEN
    \ SCREEN$
    \ ATTR
    \ POINT
    \ PI
    \ RND
    \ INKEY$

"-------------------------------------------------------------------------
" Operators
"-------------------------------------------------------------------------

syntax keyword zxbOperator
    \ AND
    \ OR
    \ NOT

"-------------------------------------------------------------------------
" Binary literals
"-------------------------------------------------------------------------

syntax keyword zxbBinaryKeyword BIN

syntax match zxbBinary "\<BIN\s\+\zs[01]\+\>"

highlight default link zxbBinaryKeyword Keyword
highlight default link zxbBinary Number

"-------------------------------------------------------------------------
" Line references
"-------------------------------------------------------------------------

syntax match zxbLineRef "\<GOTO\s\+\zs\d\+\>"
syntax match zxbLineRef "\<GOSUB\s\+\zs\d\+\>"
syntax match zxbLineRef "\<RESTORE\s\+\zs\d\+\>"
syntax match zxbLineRef "\<RUN\s\+\zs\d\+\>"

highlight default link zxbLineRef Underlined

"-------------------------------------------------------------------------
" Highlight groups
"-------------------------------------------------------------------------

highlight default link zxbComment      Comment
highlight default link zxbString       String
highlight default link zxbNumber       Number
highlight default link zxbLineNumber   LineNr

highlight default link zxbFlow         Conditional
highlight default link zxbStatement    Statement
highlight default link zxbScreen       Identifier
highlight default link zxbColour       Special
highlight default link zxbGraphics     Keyword
highlight default link zxbSound        Special
highlight default link zxbMachine      PreProc
highlight default link zxbStorage      Type
highlight default link zxbFunction     Function
highlight default link zxbOperator     Operator

let b:current_syntax = "zxbasic"

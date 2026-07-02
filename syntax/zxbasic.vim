"=========================================================================
" ZX Spectrum BASIC syntax
"=========================================================================

if exists("b:current_syntax")
  finish
endif

"-------------------------------------------------------------------------
" Comments
"-------------------------------------------------------------------------

syntax region zxbComment start="\c\<REM\>" end="$"

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
" Screen attributes
"-------------------------------------------------------------------------

syntax keyword zxbColour
    \ INK
    \ PAPER
    \ BORDER
    \ FLASH
    \ BRIGHT
    \ OVER
    \ INVERSE

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

syntax keyword zxbSound
    \ BEEP

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
" Math functions
"-------------------------------------------------------------------------

syntax keyword zxbMathFunction
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
    \ PI
    \ RND

"-------------------------------------------------------------------------
" String functions
"-------------------------------------------------------------------------

syntax keyword zxbStringFunction
    \ CHR$
    \ STR$
    \ VAL$
    \ SCREEN$
    \ INKEY$

"-------------------------------------------------------------------------
" General functions
"-------------------------------------------------------------------------

syntax keyword zxbFunction
    \ CODE
    \ VAL
    \ LEN
    \ ATTR
    \ POINT

"-------------------------------------------------------------------------
" Operators
"-------------------------------------------------------------------------

syntax keyword zxbOperator
    \ AND
    \ OR
    \ NOT

"-------------------------------------------------------------------------
" Highlight groups
"-------------------------------------------------------------------------
highlight zxbComment guifg=#666666 gui=italic
highlight zxbLineNumber guifg=#505050

highlight default link zxbNumber           Number

highlight default link zxbFlow             Conditional
highlight default link zxbStatement        Statement
highlight default link zxbScreen           Identifier

highlight default link zxbColour           Special
highlight default link zxbGraphics         Keyword
highlight default link zxbSound            Special

highlight default link zxbMachine          PreProc
highlight default link zxbStorage          Type

highlight default link zxbMathFunction     Function
highlight default link zxbStringFunction   Function
highlight default link zxbFunction         Function

highlight default link zxbOperator         Operator

let b:current_syntax = "zxbasic"

function! CSyntaxPlus()
   syn keyword Boolean         nullptr TRUE FALSE
   syn keyword Statement       namespace stderr stdin stdout new this delete

   syn match  _Block    "[{}]"
   syn match  _IfBlock  "[()]"
   syn match  _Bracket  "[\[\]]"
   syn match  _Operator display "[-+&|<>=!*\/~.,;:%&^?]" contains=cComment,cCommentL
   syn match  _Pointer  display "\w\+\s*->"  contains=_Operator
   syn match  _Struct   display "\w\+\s*[.]" contains=_Operator
   syn match  _Func     display "\w\+\s*("   contains=_IfBlock

   hi link _Operator Operator
   hi link _Bracket  Constant
   hi link _Func     Function
   hi link _IfBlock  String
   hi link _Pointer  Type
   hi link _Struct   _Pointer
   hi link _Block    Constant
endfunction

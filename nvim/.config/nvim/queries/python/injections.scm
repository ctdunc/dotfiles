;extends
(call
  (identifier) @name (#eq? @name clientside_callback) 
  (argument_list 
    ((string (string_content) 
	     @injection.content 
	     (#set! injection.include-children)
	     (#set! injection.language "javascript")))
	)
)


; Module docstring
(module . (
	expression_statement (
		string (string_content) @injection.content 
		(#set! injection.language "markdown"))
	)
      )

; Class docstring
(class_definition
  body: (block . (
	expression_statement (
		string (string_content) @injection.content (#set! injection.language "rst")
	))
	)
)

; Function/method docstring
(function_definition
  body: (block . (expression_statement (string) @comment)))

; Attribute docstring
((expression_statement (assignment)) . (expression_statement (string) @comment))

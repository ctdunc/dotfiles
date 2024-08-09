;extends
;(assignment
;  left: (identifier) @_id 
;  right: (string) @injection.content
;  (#match? @_id "query")
;  (#offset! @injection.content 0 4 0 -3)
;  (#set! injection.include_children)
;  (#set! injection.language "sql")
;)

;(string (
;         [(string_content) @injection.content 
;         (#match? @injection.content "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
;         (_) @_nothing
;        ]
;    )
;        (#set! injection.combine)
;        (#set! injection.language "sql")
;)
;((string (
;  (string_start) 
;  . (string_content) @_s (#match? @_s "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
;)) [(string_content)] @injection.content) (#set! injection.combined) (#set! injection.language "sql"))
;(string (
;  (string_start)
;  . (string_content) @_s 
;)) [(string_content)] @injection.content
;(#match? @_s "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
;(#set! injection.language "sql")
;((string (
;  (string_content)+ @s (#match? @s "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
;)) [(string_content)] @injection.content (#set! injection.combine) (#set! injection.language "sql"))
;((string) @injection.content 
;  (#set! injection.language "sql")
;)
;([
;  (string_content)
;  ] @injection.content
; (#match? @injection.content "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
;(#set! injection.language "sql"))
;(((string (string_content)+ @first_str)
;(#match? @first_str"(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
;) (string_content) @injection.content (#set! injection.language "sql"))
;((string (string_content)+ @first_str)
;(#match? @first_str "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
;([(string_content)])) @injection.content
;(#set! injection.include-children)
;(#set! injection.language "sql")
;(string (string_content)+ @first_str)
;(#match? @first_str "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
;(string_content) @injection.content (#set! injection.language "sql")

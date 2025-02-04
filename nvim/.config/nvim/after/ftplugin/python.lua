require("otter").activate(
  { "javascript", "typescript", "js", "ts" },
  true,
  true,
  '(call(identifier) @name (#eq? @name clientside_callback) (argument_list ((string (string_content) @injection.content (#set! injection.include-children)(#set! injection.language "javascript")))))'
)

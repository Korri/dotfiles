folder = ARGV[0]

regex = %r{
  (
    Layout/(?:
      FirstArgumentIndentation |
      FirstArrayElementLineBreak |
      FirstHashElementLineBreak |
      FirstMethodArgumentLineBreak |
      MultilineArrayLineBreaks |
      MultilineHashKeyLineBreaks |
      MultilineMethodArgumentLineBreaks
    ):\n\ {2}Exclude:
    (\n\ {4}-\ '(?!#{folder}).+)* # Lines unrelated to current folder
  )
  (\n\ {4}-\ '#{folder}.+)+ # Lines related to current folder
}xo

puts "Removing todos for #{folder}"

text = File.read('.rubocop_todo.yml')
puts "Removing #{text.scan(regex).size} matches"
result = text.gsub(regex, '\1')
File.write('.rubocop_todo.yml', result)


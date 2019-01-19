function print_matrix(name, rows, collums, environment)
  rows = (rows or 1) - 1
  collums = (collums or 1) - 1
  name = name or 'x'
  environment = environment or 'bmatrix'
  begining = [[\begin{]]..environment..[[}]]
  ending = [[\end{]]..environment..[[}]]

  s = ''
  for i = 0, rows, 1 do
    for j = 0, collums, 1 do
      s = s .. name..'_{'
      if rows ~= 0 then
        s = s .. i
      end
      if collums ~= 0 then
        s = s .. j
      end
      s = s .. '}'
      if j == collums then
        if i ~= rows then
          s = s .. [[ \\]]
        end
      else
        s = s .. ' &'
      end
    end
  end
  s = begining .. s .. ending
  tex.print(s)
end

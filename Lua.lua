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

function cimg(caption, img, tikz, tikzOptions, source, label, placement)
  if not img then resize = true end

  caption = caption or 'NO CAPTION'
  img = img or 'images/Placeholder.png'
  tikz = tikz or ''
  tikzOptions = tikzOptions or ''
  source = source or 'own graphic'
  labelCmd = ''
  if label then labelCmd = [[\label{]]..label..[[}]] end
  placement = placement or 'ht'

  resizeCmd=''
  if resize then resizeCmd=[[\resizebox{5cm}{5cm}]] end
  s = [[
  	\begin{figure}[]]..placement..[[]
  	\begin{center}]]
    ..resizeCmd..[[{
    	\begin{tikzpicture}[thick,>=stealth',]]..tikzOptions..[[]
    		\node (img) at (0,0) {\includegraphics{]]..img..[[}};
    		]]..tikz..[[
    	\end{tikzpicture}
    }
  	\end{center}

  	\caption{]]..caption..[[}
  	\figsource{]]..source..[[}
    ]]..labelCmd..[[

  	\end{figure}
    ]]
    tex.print(s:gsub('\n', ' '))
end

function python_config()
  local f = io.open('files/pythonPackages.txt')

  tex.print([===[\begin{tabular}[| r | l || r | l |]
                 \hline]===])
  i = 0
  for line in io.lines(f) do
    local p = line:gsub('\n', ' ')
    p = p:gsub('%s+', ' & ')
    i = i + 1
    if i % 2 == 0 and i ~= 0 then
      p = p:gsub(1, -3)..[[\\ ]]
    end
    tex.print(p)
  end
  tex.print([[\hline
              \end{tabular}]])
end

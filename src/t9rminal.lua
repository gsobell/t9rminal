#!/usr/bin/env lua

--[[
t9rminal - keypad input for POSIX terminals
Copyright (C) 2024 gsobell

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/.
--]]

keypad = {
  [0] = { " " },
  { "" },
  { "a", "b", "c" },
  { "d", "e", "f" },
  { "g", "h", "i" },
  { "j", "k", "l" },
  { "m", "n", "o" },
  { "p", "q", "r", "s" },
  { "t", "u", "v" },
  { "w", "x", "y", "z" },
}

function get_executables()
  local all_paths = os.getenv("PATH")
  local paths = {}
  local executables = {}
  if all_paths then
    for path in all_paths:gmatch("[^:]+") do
      table.insert(paths, path)
    end
    for _, path in ipairs(paths) do
      local files = {}
      local cmd = 'ls -p "' .. path .. '"'
      local handle = io.popen(cmd)
      if handle then
        for fileName in handle:lines() do
          if fileName ~= "." and fileName ~= ".." then
            table.insert(files, fileName)
          end
        end
        handle:close()
      else
        print("Error: Failed to open directory " .. path)
      end
      for _, file in ipairs(files) do
        local filename = file:match("^.+/(.+)$") or file
        table.insert(executables, filename)
      end
    end
  else
    print("Error: PATH environment variable not found.")
  end
  return executables
end

--for _, exe in ipairs(executables) do
--  print(exe)
--end

function print_2d_table(table)
  for _, _ in ipairs(table) do
    for _, value in ipairs(table) do
      print(tostring(value))
    end
  end
end

function print_table(table)
  for _, value in ipairs(table) do
    print(value)
  end
end

function starts_with(stem, collection)
  for _, s in ipairs(collection) do
    if s:sub(1, #stem) == stem then
      return true
    end
  end
  return false
end

function add_to(letter)
  if not next(possible) then
    possible = keypad[letter]
  else
    possible = add_letter(letter)
  end
  print_2d_table(possible)
end

function add_letter(letter)
  local combined = {}
  for i, to_add in ipairs(keypad[letter]) do
    for j, stem in ipairs(possible) do
      local a = tostring(stem) .. tostring(to_add)
      if starts_with(a, executables) then
        table.insert(combined, a)
      end
    end
  end
  return combined
end

function main()
  user_in = ""
  possible = {}
  executables = get_executables()
  while true do
    io.write("Input single digit: ")
    old, user_in = user_in, io.read()
    print("Possible arguments:")
    add_to(tonumber(user_in:sub(1, 1)))
    user_in = old .. user_in
    print("User input: " .. user_in)
  end
end

main()

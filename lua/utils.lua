---
-- Module containing some general utility functions used in many places in httptables.
--
-- NOTE: Before implementing a function here, consider if it will be used in many places
-- across httptables. If not, a local function in the appropriate module is prefered.
--

local type = type
local pairs = pairs
local tostring = tostring


local _M = {}

--- Calculates a table size.
-- All entries both in array and hash part.
-- @param t The table to use
-- @return number The size
function _M.table_size(t)
  local res = 0
  if t then
    for _ in pairs(t) do
      res = res + 1
    end
  end
  return res
end

--- Merges two table together.
-- A new table is created with a non-recursive copy of the provided tables
-- @param t1 The first table
-- @param t2 The second table
-- @return The (new) merged table
function _M.table_merge(t1, t2)
  local res = {}
  for k,v in pairs(t1) do res[k] = v end
  for k,v in pairs(t2) do res[k] = v end
  return res
end

--- Checks if a value exists in a table.
-- @param arr The table to use
-- @param val The value to check
-- @return Returns `true` if the table contains the value, `false` otherwise
function _M.table_contains(arr, val)
  if arr then
    for _, v in pairs(arr) do
      if v == val then
        return true
      end
    end
  end
  return false
end

--- Checks if a table is an array and not an associative array.
-- *** NOTE *** string-keys containing integers are considered valid array entries!
-- @param t The table to check
-- @return Returns `true` if the table is an array, `false` otherwise
function _M.is_array(t)
  if type(t) ~= "table" then return false end
  local i = 0
  for _ in pairs(t) do
    i = i + 1
    if t[i] == nil and t[tostring(i)] == nil then return false end
  end
  return true
end

--- Deep copies a table into a new table.
-- Tables used as keys are also deep copied, as are metatables
-- @param orig The table to copy
-- @return Returns a copy of the input table
function _M.deep_copy(orig)
  local copy
  if type(orig) == "table" then
    copy = {}
    for orig_key, orig_value in next, orig, nil do
      copy[_M.deep_copy(orig_key)] = _M.deep_copy(orig_value)
    end
    setmetatable(copy, _M.deep_copy(getmetatable(orig)))
  else
    copy = orig
  end
  return copy
end

--- Check if IP is private.
-- @param addr ip string
-- @return Returns `true` if ip is private, `false` otherwise
function _M.is_private_ip(addr)
    ip_sum = 0
    ip_count = 3
    for ip_i in string.gmatch(addr, [[%d+]]) do
        ip_sum = ip_sum + math.pow(256, ip_count) * ip_i
        ip_count = ip_count - 1
    end
    if ip_sum >= 0x7f000000 and ip_sum <= 0x7fffffff or -- 127.0.0.0 ~ 127.255.255.255
        ip_sum >= 0x0a000000 and ip_sum <= 0x0affffff or -- 10.0.0.0 ~ 10.255.255.255
        ip_sum >= 0xac100000 and ip_sum <= 0xac1fffff or -- 172.16.0.0 ~ 172.31.255.255
        ip_sum >= 0xc0a80000 and ip_sum <= 0xc0a8ffff then   -- 192.168.0.0 ~ 192.168.255.255
        return true
    else
        return false
    end
end

return _M

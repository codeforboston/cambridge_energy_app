def island_counter(map)
  islands = 0
  if map == nil || map.length == 0
    return 0
  end
  m = map.length # number of rows
  n = map[0].length # number of columns

  for i in 0..m-1 do
    for j in 0..n-1 do
      if map[i][j] == 1
        mark_island(map, m, n, i, j)
        islands += 1
      end
    end
  end
  return islands
end

def mark_island(map, m, n, i, j)
  q = []
  q.push([i,j])
  while !q.empty? do
    item = q.pop()
    x = item[0]
    y = item[1]
    if map[x][y] == 1
      map[x][y] = 2
      push_if_valid(q, m, n, x-1, y)
      push_if_valid(q, m, n, x, y-1)
      push_if_valid(q, m, n, x+1, y)
      push_if_valid(q, m, n, x, y+1)
    end
  end
end

def push_if_valid(q, m, n, x, y)
  if x>=0 && x<m && y>=0 && y<n
    q.push([x,y])
  end
end

island_map = [[0,1,0,1,0],[0,0,1,1,1],[1,0,0,1,0],[0,1,1,0,0],[1,0,1,0,1]]

puts island_counter(island_map)






function reverseWords(arr):
   # reverse all characters:
   n = length(arr)
   mirrorReverse(arr, 0, n-1)

   # reverse each word:
   wordStart = null
   for i from 0 to n-1:
      if (arr[i] == " "):
         if (wordStart != null):
            mirrorReverse(arr, wordStart, i-1)
            wordStart = null
      else if (i == n-1):
         if (wordStart != null):
            mirrorReverse(arr, wordStart, i)
      else:
         if (wordStart == null):
            wordStart = i

# helper function - reverses the order of items in arr
# please note that this is language dependent:
# if are arrays sent by value, reversing should be done in place
function mirrorReverse(arr, start, end):
   tmp = null
   while (start < end):
      tmp = arr[start]
      arr[start] = arr[end]
      arr[end] = tmp
      start++
      end--


      hired.com
vettery.com
underdog.io
whitetruffle.com
untapt.com
interviewbit.com

arr = [some nonnegative integers]

find_me = an integer

def diff_number(arr, n)
   if arr.length >= maximum_integer
      nil
   end

   max = 0

   arr.each do |element|
      if element > max
         max = element
   end

   max + 1
end

o(logn) O(n) o(nlogn)
#####

def get_another_number(arr)
  tracker = {}

  arr.each do |elem|
    tracker[elem] = true
  end

  n = 0
  loop do
    return n unless tracker[n]
    n += 1
  end
  nil
end

function getAnotherNumber(arr):
   n = length(arr)
   if (n == MAX_INT+1): # all non-negative integers are in arr
      return null
   arr2 = []
   for i from 0 to n:
      arr2[i] = 0
   for i from 0 to n-1:
      num = arr[i]
      arr2[num % (n+1)] = 1
   for i from 0 to n:
      if arr2[i] == 0:
         return i

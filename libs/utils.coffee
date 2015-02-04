exports.indexof =  (arr, obj)->
  index = -1
  keys = Object.keys(obj)
  result = arr.filter (doc, idx)->
    matched = 0

    i = keys.length - 1
    while i > 0
      if (doc[keys[i]] == obj[keys[i]])
        matched++
        if (matched == keys.length)
          index = idx
          return idx
      i--
  return index

exports.findByParam = (arr, obj, cb)->
  index = exports.indexof(arr, obj)
  if (~index && typeof cb == 'function')
    return cb(undefined, arr[index])
  
  if (~index && !cb)
    return arr[index]
  
  if (!~index && typeof cb == 'function')
    return cb('not found')

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


exports.getFormatedUrl = (domain)->
  regx = /(http(s?)\:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}((\S)*)$/i
  if !domain
    return null
  domain = domain.toLowerCase()
  url = domain.match(regx)
  if !url
    return null

  return url[0]

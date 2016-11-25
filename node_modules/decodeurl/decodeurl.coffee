iconv = require 'iconv-lite'
jschardet = require 'jschardet'
us = require 'underscore'

to_chinese = (buff) ->
  _every_is_chinese = (str) ->
    # the CJK unicode refer to http://www.unicode.org/Public/5.0.0/ucd/Unihan.html
    unicode = us.map [0...str.length], (i) ->
      str.charCodeAt(i)
    us.every unicode, (u) ->
      result = us.some [
        0x00 <= u <= 0xFF        # ASCII and common Latin
        0x2000 <= u <= 0x206F    # General Punctuation
        0x3400 <= u <= 0x4DB5    # U+3400..U+4DB5 CJK Unified Ideographs Extension A
        0x4E00 <= u <= 0x9FBB    # U+4E00..U+9FBB CJK Unified Ideographs
        0xF900 <= u <= 0xFA2D    # U+F900..U+FA2D CJK Compatibility Ideographs
        0xFA30 <= u <= 0xFA6A    # U+FA30..U+FA6A CJK Compatibility Ideographs
        0xFA70 <= u <= 0xFAD9    # U+FA70..U+FAD9 CJK Compatibility Ideographs
        0x20000 <= u <= 0x2A6D6  # U+20000..U+2A6D6 CJK Unified Ideographs Extension B
        0x2F800 <= u <= 0x2FA1D  # U+2F800..U+2FA1D  CJK Compatibility Supplement
        0xFF00 <= u <= 0xFFEF    # FF00-FFEF: 全角ASCII、全角中英文标点、半宽片假名、半宽平假名、半宽韩文字母
        0x2E80 <= u <= 0x2EFF    # CJK部首补充：2E80-2EFF
        0x3000 <= u <= 0x303F    # CJK标点符号：3000-303F
        0x31C0 <= u <= 0x31EF    # CJK笔划：31C0-31EF
        u in [0x2018, 0x2019, 0x201D, 0x201D] #  UCS quote: http://www.cl.cam.ac.uk/~mgk25/ucs/quotes.html
      ]
      # console.log "u=#{u}, result=#{result}"
      return result
    

  detect_encoding = jschardet.detect buff
  if detect_encoding?.confidence >= 0.98 and iconv.encodingExists(detect_encoding.encoding)
    # console.log detect_encoding
    return iconv.decode(buff, detect_encoding.encoding)

  str = iconv.decode(buff, 'utf-8') 
  # console.log "utf-8: #{str}"
  return str if _every_is_chinese(str)

  str = iconv.decode(buff, 'gbk') 
  # console.log "gbk=#{str}"
  return str if _every_is_chinese(str)

  return null

module.exports = decodeurl = (str) ->
  r = /(%[0-9A-Fa-f]{2})+/g
  url_hex_parts = []
  while m = r.exec(str)
    url_hex_parts.push m[0]
   
  for hex in url_hex_parts
    buff = new Buffer(hex.replace(/%/g, ''), 'hex')
    decoded_str = to_chinese(buff)

    if decoded_str
      str = str.replace hex, decoded_str

  return str

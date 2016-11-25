decode_url = require '../decodeurl.coffee'




# a = "http://www.baidu.com/s?wd=%E4%BE%9B%E5%BA%94%E9%93%BE%E7%BD%91%E7%BB%9C%E8%A7%84%E5%88%92%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90%3A%E6%90%9C%E9%9B%86%E6%9F%90%E5%AE%B6%E4%BC%81%E4%B8%9A%E4%BE%9B%E5%BA%94%E9%93%BE%E7%BD%91%E7%BB%9C%E8%A7%84%E5%88%92%E6%A1%88%E4%BE%8B%2C%E5%88%86%E6%9E%90%E4%BE%9B%E5%BA%94%E9%93%BE%E7%BD%91%E7%BB%9C%E8%A7%84%E5%88%92%E5%AF%B9%E4%BC%81&pn=90&oq=%E4%BE%9B%E5%BA%94%E9%93%BE%E7%BD%91%E7%BB%9C%E8%A7%84%E5%88%92%E6%A1%88%E4%BE%8B%E5%88%86%E6%9E%90%3A%E6%90%9C%E9%9B%86%E6%9F%90%E5%AE%B6%E4%BC%81%E4%B8%9A%E4%BE%9B%E5%BA%94%E9%93%BE%E7%BD%91%E7%BB%9C%E8%A7%84%E5%88%92%E6%A1%88%E4%BE%8B%2C%E5%88%86%E6%9E%90%E4%BE%9B%E5%BA%94%E9%93%BE%E7%BD%91%E7%BB%9C%E8%A7%84%E5%88%92%E5%AF%B9%E4%BC%81&tn=98050039_dg&ie=utf-8&rsv_page=1"
# a = "http://www.baidu.com/s?wd=%E5%B8%B8%E8%8C%82%E5%BE%95&pn=260&oq=%E5%B8%B8%E8%8C%82%E5%BE%95&ie=utf-8&rsv_idx=1&f=8&rsv_bp=1&tn=baidu"
# a = "http%3A%2F%2Fwww.tushucheng.com%2Faw%2Fbook%2F4851503.html&referer=&d=1414570350875&default HTTP/1.1"
# a = "http://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=1&rsv_idx=1&tn=baidu&wd=9787508340906&bs=%E5%86%9C%E7%94%B5%E4%B8%89%E5%A4%A7%E8%A7%84%E7%A8%8B%E5%9F%B9%E8%AE%AD%E6%95%99%E7%A8%8B&d=1414633933172&default HTTP/1.1"
# a = "14.145.252.120 - - [30/Oct/2014:10:01:59 +0800] \"GET /log/detail.html?url=http://www.tushucheng.com/book/2821259.html&referer=http://www.baidu.com/s?wd=%E6%8E%A8%E8%8D%90%20%E7%AE%A1%E7%90%86%E6%B3%95%E5%88%99%20%E4%B9%A6&pn=30&oq=%E6%8E%A8%E8%8D%90%20%E7%AE%A1%E7%90%86%E6%B3%95%E5%88%99%20%E4%B9%A6&tn=site888_pg&ie=utf-8&d=1414634756343&type=DT&detailPage&bookId=2821259&userid=0 HTTP/1.1\" 200 0 \"http://www.tushucheng.com/book/2821259.html\" \"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0)\""
# a = """
# 14.145.252.120 - - [30/Oct/2014:10:01:59 +0800] "GET /log/detail.html?url=http%3A%2F%2Fwww.tushucheng.com%2Fbook%2F2821259.html&referer=http%3A%2F%2Fwww.baidu.com%2Fs%3Fwd%3D%25E6%258E%25A8%25E8%258D%2590%2520%25E7%25AE%25A1%25E7%2590%2586%25E6%25B3%2595%25E5%2588%2599%2520%25E4%25B9%25A6%26pn%3D30%26oq%3D%25E6%258E%25A8%25E8%258D%2590%2520%25E7%25AE%25A1%25E7%2590%2586%25E6%25B3%2595%25E5%2588%2599%2520%25E4%25B9%25A6%26tn%3Dsite888_pg%26ie%3Dutf-8&d=1414634756343&type=DT&detailPage&bookId=2821259&userid=0 HTTP/1.1" 200 0 "http://www.tushucheng.com/book/2821259.html" "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0)"
# """
# a = """
# GET /log/detail.html?url=http%3A%2F%2Fwww.tushucheng.com%2Fbook%2F2821259.html&referer=http%3A%2F%2Fwww.baidu.com%2Fs%3Fwd%3D%25E6%258E%25A8%25E8%258D%2590%2520%25E7%25AE%25A1%25E7%2590%2586%25E6%25B3%2595%25E5%2588%2599%2520%25E4%25B9%25A6%26pn%3D30%26oq%3D%25E6%258E%25A8%25E8%258D%2590%2520%25E7%25AE%25A1%25E7%2590%2586%25E6%25B3%2595%25E5%2588%2599%2520%25E4%25B9%25A6%26tn"
# """
# # a = """
# # GET /log/detail.html?url=http%3A%2F%2Fwww.tushucheng.com%2Fbook%2F2821259.html&referer=http%3A%2F%2Fwww.baidu.com%2Fs%3Fwd%3D%25E6"
# # """
# # console.log "+++"+a+"+++"
# a = """
# 101.226.89.123 - - [30/Oct/2014:12:11:27 +0800] "GET /log/detail.html?url=http://www.tushucheng.com/book/4902457.html&referer=http://www.sogou.com/sogou?pid=Af99046&query=%D4%DAfldlc%CC%F5%BC%FE%CF%C2%B9%CD%D6%F7%A1%A2%B9%A4%B3%CC%CA%A6%BC%B0%B3%D0%B0%FC%C9%CC%B5%C4%C8%A8%C1%A6%D3%EB%D6%B0%D4%F0&p=50040111&oq=&ri=-2&d=1414640594837&type=DT&detailPage&bookId=4902457&userid=0 HTTP/1.1" 200 0 "http://www.tushucheng.com/book/4902457.html" "Mozilla/4.0"
# """
a = """
60.2.52.18 - - [30/Oct/2014:13:38:04 +0800] "GET /log/detail.html?url=http%3A%2F%2Fwww.tushucheng.com%2Faw%2Fbook%2F1806088.html&referer=http%3A%2F%2Fm.sp.sm.cn%2Fs%3Fq%3D%25E5%25B9%25B3%25E9%259D%25A2%25E4%25B8%258E%25E5%259B%259E%25E8%25BD%25AC%25E4%25BD%2593%25E7%259B%25B8%25E4%25BA%25A4%25EF%25BC%2588%25E7%25BB%25AD%25EF%25BC%25896%25E5%25AE%258C%25E6%2588%2590%25E4%25BF%25AF%25E8%25A7%2586%25E5%259B%25BE%25EF%25BC%258C%25E5%25B9%25B6%25E4%25BD%259C%25E5%25B7%25A6%25E8%25A7%2586%25E5%259B%25BE%26uc_param_str%3Ddnntnwvepffrgibijbpr%26from%3Ducframe%26by%3Dsubmit%26snum%3D0&d=1414647480564&default HTTP/1.1" 200 0 "http://www.tushucheng.com/aw/book/1806088.html" "Mozilla/5.0 (Linux; U; Android 4.3; zh-CN; R831S Build/JLS36C) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 UCBrowser/9.9.6.495 U3/0.8.0 Mobile Safari/533.1"
"""
# a = """
# 60.2.52.18 - - [30/Oct/2014:13:38:04 +0800] "GET /log/detail.html?url=http%3A%2F%2F
# """

a = """
112.64.235.87 - - [30/Oct/2014:22:16:54 +0800] "GET /book/2870444.html HTTP/1.1" 200 33784 "http://www.sogou.com/sogou?ie=utf-8&pid=sogou-clse-a495eebbfa243b79-0002&query=%E2%80%9C%E4%B8%AD%E5%9B%BD%E7%9A%84%E6%91%A9%E5%B0%94%E6%A0%B9%E2%80%9D%E7%BE%8E%E7%A7%B0%E7%9A%84%E9%81%97%E4%BC%A0%E5%AD%A6%E5%AE%B6" "Mozilla/4.0"
"""
a = """
%CA%C0%BC%CD%CA%FD%D1%A7%BD%CC%D3%FD%D0%C5%CF%A2%BB%AF%BE%AB%C6%B7%BD%CC%B2%C4%A1%A4%B4%F3%D1%A7%CA%FD%D1%A7%C1%A2%CC%E5%BB%AF%BD%CC%B2%C4%3A%A1%B6%B8%DF%B5%C8%CA%FD%D1%A7%28%CF%C2%B2%E1%29%A1%B7%D1%A7%CF%B0%B8%A8%B5%BC%D3%EB%CF%B0%CC%E2%BD%E2%B4%F0%28%C0%ED%B9%A4%C0%E0%29
"""
# a = "%CC%F5%BC%FE%CF%C2%B9%CD%D6%F7%A1%A2%B9%A4%B3%CC%CA%A6%BC%B0%B3%D0%B0%FC%C9%CC%B5%C4%C8%A8%C1%A6%D3%EB%D6%B0%D4%F0"
# a = """
# 180.153.163.211 - - [31/Oct/2014:09:56:11 +0800] "GET /book/4975493.html HTTP/1.1" 200 27820 "http://www.sogou.com/sogou?oq=&query=%E5%AE%AB%E2%80%A2%E5%9F%8E%E2%80%94%E2%80%94%E5%86%99%E7%BB%99%E5%AD%A9%E5%AD%90%E7%9A%84%E7%B4%AB%E7%A6%81%E5%9F%8E&pid=AQxRG-0000&ri=-2&page=2&duppid=1&ie=utf8&p=99350103&dp=1" "Mozilla/4.0"
# """

# a = """
# %C3%F7%B4%FA%A1%B0%D3%F1%CC%C3%B4%BA%A1%B1%D4%DA%ED
# """
# a = """
#  %E5%AE%AB%E2%80%A2%E5%9F%8E%E2%80%94%E2%80%94%E5%86%99%E7%BB%99%E5%AD%A9%E5%AD%90%E7%9A%84%E7%B4%AB%E7%A6%81%E5%9F%8E
#  """
# a = """
# %E4%B8%BA%E7%88%B1%E7%96%AF%E7%8B%82%E2%80%94%E2%80%94%E8%8B%8F%E6%A0%BC%E5%85%B0%E5%A5%B3%E7%8E%8B%E7%8E%9B%E4%B8%BD%C2%B7%E6%96%AF%E5%9B%BE%E4%BA%9A%E7%89%B9%E4%BC%A0
# """
a = '%CE%DE'
console.log decode_url decode_url(a)

import http from 'k6/http'

export default function () {
  let cookies = {
    name: 'value1',
    name2: 'value2',
  }
  let res = http.get('http://httpbin.org/cookies', { cookies: cookies })
  // Since the cookies are set as "request cookies" they won't be added to VU cookie jar
  let vuJar = http.cookieJar()
  let cookiesForURL = vuJar.cookiesForURL(res.url)
}

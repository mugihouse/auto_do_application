document.addEventListener('DOMContentLoaded', () => {
  //csrf-token取得
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  const liffId = gon.liff_id
  // liff関連のlocalStorageのキーのリストを取得
  const getLiffLocalStorageKeys = (prefix) => {
    const keys = []
    for (var i = 0; i < localStorage.length; i++) {
      const key = localStorage.key(i)
      if (key.indexOf(prefix) === 0) {
        keys.push(key)
      }
    }
    return keys
  }
  // 期限切れのIDTokenをクリアする
  const clearExpiredIdToken = (liffId) => {
    const keyPrefix = `LIFF_STORE:${liffId}:`
    const key = keyPrefix + 'decodedIDToken'
    const decodedIDTokenString = localStorage.getItem(key)
    if (!decodedIDTokenString) {
      return
    }
    const decodedIDToken = JSON.parse(decodedIDTokenString)
    // 有効期限をチェック
    if (new Date().getTime() > decodedIDToken.exp * 1000) {
      const keys = getLiffLocalStorageKeys(keyPrefix)
      keys.forEach(function (key) {
        localStorage.removeItem(key)
      })
    }
  }

  const main = async (liffId) => {
    clearExpiredIdToken(liffId)
    // LIFFのメソッドを実行できるようにする
    liff
      .init({
        liffId: liffId,
        withLoginOnExternalBrowser: true
      })
    // 初期化後の処理設定
    liff
      .ready.then(() => {
        if (!liff.isLoggedIn()) {
          liff.login();
        } else {
          const idToken = liff.getIDToken()
          const body = `idToken=${idToken}`
          const request = new Request('/users', {
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
              'X-CSRF-Token': token
            },
            method: 'POST',
            body: body
          })

          fetch(request)
            .then(response => response.json())
            .then(data => {
              data_id = data
            })
            .then(() => {
              window.location = '/after_login'
            })
        }
      })
  }
  main(liffId)
});

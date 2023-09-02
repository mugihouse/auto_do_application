document.addEventListener('DOMContentLoaded', () => {
  //csrf-token取得
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  // LIFFのメソッドを実行できるようにする
  liff
    .init({
      liffId: gon.liff_id,
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
})

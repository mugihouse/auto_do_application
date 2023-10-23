module ApplicationHelper
  def default_meta_tags
    {
      site: 'AutoDo',
      title: 'LINEでタスクを自動配信するtodoアプリ',
      reverse: true,
      charset: 'utf-8',
      description: 'LINEを使用してタスクを毎日1つ自動配信します。タスクを事前に登録しておけば、その中から1つをピックアップします。',
      keywords: 'タスク管理,todo管理,todoアプリ',
      canonical: request.original_url,
      separator: '|',
      icon: {
        href: image_url('favicon.ico')
      },
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        local: 'ja-JP'
      },
      # Twitter用の設定
      twitter: {
        card: 'summary_large_image',
        image: image_url('ogp.png')
      }
    }
  end
end

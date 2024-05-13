import { webview } from '@kit.ArkWeb';
import { CommonTitle } from './commons/PageCommonView';
import { promptAction, router } from '@kit.ArkUI';


@Entry
@Component
struct PageArticalDetail {
  linkUrl: string = 'www.example.com';
  mTitle: string = '详情页';
  webviewController: webview.WebviewController = new webview.WebviewController();

  aboutToAppear(): void {
    let params: object = router.getParams()
    let url: string = params['linkUrl']
    let title: string = params['title']
    if (title) {
      this.mTitle = title


    }

    this.linkUrl = url

  }

  onPageShow(): void {

  }

  build() {

    Column() {

      CommonTitle({ mTitle: this.mTitle })
      // 组件创建时，加载www.example.com
      Web({ src: this.linkUrl, controller: this.webviewController })

    }
    .width('100%')
    .height("100%")

  }
}
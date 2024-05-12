import { webview } from '@kit.ArkWeb';
import { CommonTitle } from './commons/PageCommonView';
import { promptAction, router } from '@kit.ArkUI';
import Logger from '../utils/Logger';

@Entry
@Component
struct PageArticalDetail {
  linkUrl: string = 'www.example.com';
  webviewController: webview.WebviewController = new webview.WebviewController();

  aboutToAppear(): void {
    let params: object = router.getParams()
    let url: string = params['linkUrl']

    this.linkUrl = url

  }

  onPageShow(): void {

  }

  build() {

    Column() {

      CommonTitle()
      // 组件创建时，加载www.example.com
      Web({ src: this.linkUrl, controller: this.webviewController })

    }
    .width('100%')
    .height("100%")

  }
}
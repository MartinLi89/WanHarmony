import { router } from '@kit.ArkUI'

@Component
struct CommonTitle {
  mTitle: string = "我的title"

  build() {
    Row() {
      Image($r("sys.media.ohos_ic_back"))
        .size({
          width: 20,
          height: 20
        })
        .onClick(() => {

          router.back()
        })
      Text(this.mTitle).layoutWeight(1).height("100%").textAlign(TextAlign.Center).fontSize(24)
        .fontWeight(FontWeight.Bold)
      Blank().width(20)
    }
    .width("100%")
    .height(40)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .padding(6)

  }
}

export {
  CommonTitle
}
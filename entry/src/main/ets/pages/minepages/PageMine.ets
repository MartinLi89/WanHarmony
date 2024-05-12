import { router } from '@kit.ArkUI';

@Preview
@Component
export default struct PageMine {
  @State message: string = 'Hello World';
  @StorageLink("mLoginStatus") @Watch("onLoginStatusChange") mLoginStatus: boolean = false

  // @State mLoginStatus: boolean = false

  onLoginStatusChange() {

  }

  login() {

    if (this.mLoginStatus) {
      this.mLoginStatus = false
    } else {
      router.pushUrl({
        url: 'pages/minepages/PageLoginAccount'  // 一定是个Page
      })
    }

  }

  build() {
    Column() {


      Column() {

        Image($r("app.media.user_head"))
          .width("20%")
          .margin({ top: 100 })
          .aspectRatio(1)
          .fillColor(this.mLoginStatus ? Color.White : Color.Gray)

        Text('用户信息')
        Column() {
          Row() {
            Text("匿名未登录")
          }

          Row() {
            Text("VIP6")
          }

          Row() {
            Text("新人王")
          }

        }.layoutWeight(1).width("100%")


        Button(this.mLoginStatus ? "退出登录" : "登录")
          .width(180)
          .height(40)
          .margin({ bottom: 100 })
          .type(ButtonType.Normal)
          .border({
            radius: 5
          })
          .onClick(() => this.login())
      }
      .layoutWeight(1)
      .width("100%")
      .justifyContent(FlexAlign.Center)

    }.width('100%')
    .height('100%')
    .backgroundColor('#E67C92')
    .justifyContent(FlexAlign.Center)
  }
}


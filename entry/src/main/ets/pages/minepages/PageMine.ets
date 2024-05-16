import { router } from '@kit.ArkUI';
import { common, UIAbility, Want } from '@kit.AbilityKit';

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

  async jump2MeiTUanDemo() {

    try {


      let want: Want = {
        deviceId: "",
        bundleName: 'com.example.wanharmony',

        abilityName: "MeiTuanDemoAbility"
      };

      (getContext(this) as common.UIAbilityContext).startAbility(want)


      console.info(`explicit start ability succeed`);
    } catch (error) {
      console.info(`explicit start ability failed with ${error.code}`);
    }
  }

  async jump2Keyboard() {

    try {


      let want: Want = {
        deviceId: "",
        bundleName: 'com.example.wanharmony',

        abilityName: "KeyboardDemo"
      };

      (getContext(this) as common.UIAbilityContext).startAbility(want)


      console.info(`explicit start ability succeed`);
    } catch (error) {
      console.info(`explicit start ability failed with ${error.code}`);
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

        Button("美团Demo")
          .width(180)
          .height(40)
          .margin({ bottom: 10 })
          .type(ButtonType.Normal)
          .border({
            radius: 5
          })
          .onClick(() => this.jump2MeiTUanDemo())

        Button("输入框demo")
          .width(180)
          .height(40)
          .margin({ bottom: 10 })
          .type(ButtonType.Normal)
          .border({
            radius: 5
          })
          .onClick(() => this.jump2Keyboard())


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


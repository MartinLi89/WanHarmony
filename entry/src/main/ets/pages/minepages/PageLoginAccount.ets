import { promptAction, router } from '@kit.ArkUI';
import { CommonTitle } from '../commons/PageCommonView';

@Extend(TextInput)
function inputStyle() {
  .placeholderColor("#99182431")
  .backgroundColor("#FFFFFF")
  .caretColor("#007dff")
  .height(48)
  .fontSize(16)
  .padding({
    left: 12,
    right: 12
  })
}

@Extend(Text)
function blueTextStyle() {
  .fontColor("#007dff")
  .fontSize("14fp")
  .fontWeight(FontWeight.Medium)
  .margin({
    left: 12,
    right: 12
  })
}

@Entry
@Component
struct PageLoginAccount {
  //账号密码
  @State mAccount: string = '';
  @State mPassword: string = '';
  //当前是否正在登录
  @State isLogining: boolean = false;
  //全局登录状态
  @StorageLink("mLoginStatus") mLoginStatus: boolean = false

  aboutToAppear(): void {


  }

  /**
   * 登录过程中的遮罩层
   */
  @Builder
  logingLayout() {

    Column() {

    }
    .justifyContent(FlexAlign.Center)
    .width("100%")
    .height("100%")
    .backgroundColor("#182431")
    .opacity(0.2)

    LoadingProgress()
      .color("#ff0925ea")
      .width("30%")
  }

  build() {
    //整体布局思路
    //title
    //logo
    //说明
    //账号
    //分割线
    //密码
    //登录方式变化，忘记密码
    // 登录按钮
    //注册按钮
    Stack({ alignContent: Alignment.Center }) {

      Column() {
        CommonTitle({ mTitle: "登录" })
        Column({ space: 20 }) {


          Image($r("app.media.app_icon")).width(78).height(78).margin({
            top: 20,
            bottom: 20
          })
          Text("登录账号，解锁更多功能").fontSize(16)
            .fontColor("#99182431")


          Column() {
            TextInput({
              placeholder: "请输入账号",
              text: $$this.mAccount //双向绑定输入的数据
            })
              .maxLength(20)
              .inputStyle()// .onChange((value: string) => {
                //   this.mAccount = value;
                // })
              .stateStyles({
                //状态属性， 属性三兄弟之一，@style @extend stateStyles
                focused: {
                  .borderColor("#007dff")
                  .borderWidth(3)
                  .borderRadius({
                    topLeft: 12,
                    topRight: 12
                  })
                },
                normal: {
                  .borderWidth(0)
                }
              })

            Line()
              .width("100%")
              .height(0.5)
              .backgroundColor("#0d000000")
              .margin({
                left: 12,
                right: 12
              })
            TextInput({ placeholder: "密码", text: $$this.mPassword })
              .maxLength(20)
              .type(InputType.Password)
              .inputStyle()// .onChange((value: string) => {
                //   this.mPassword = value;
                // })
              .stateStyles({
                focused: {
                  .borderColor("#007dff")
                  .borderWidth(3)
                  .borderRadius({
                    bottomLeft: 12,
                    bottomRight: 12

                  })
                },
                normal: {
                  .borderWidth(0)
                }
              })
          }
          .padding({
            top: 4,
            bottom: 4
          })
          .width("100%")
          .backgroundColor("#ffffff")
          .borderRadius(12)


          Row() {
            Text("使用短信登录").blueTextStyle()
              .onClick(() => {
                promptAction.showToast({ message: "不可能，绝对不可能" })
              })
            Text("忘记密码").blueTextStyle()
              .onClick(() => {
                promptAction.showToast({ message: "你再想想" })
              })
            Text("清空账号密码").blueTextStyle()
              .onClick(() => {
                this.clearAccount();
              })
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width("100%")
          .margin({
            top: 12
          })

          Blank()

          Button("登录")
            .width("80%")
            .height(40)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .enabled(this.checkLoginOk(this.mAccount, this.mPassword))
            .backgroundColor(this.checkLoginOk(this.mAccount, this.mPassword) ? "#007dff" : "#66007dff")
            .fontColor(this.checkLoginOk(this.mAccount, this.mPassword) ? Color.White : "#66ffffff")
            .onClick(() => {

              this.requestLogin();

            })


          Button("注册")
            .width("80%")
            .height(40)
            .fontColor(Color.White)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .backgroundColor("#007dff")
            .margin({
              bottom: 40
            })


        }
        .layoutWeight(1)
        .padding({
          left: 20,
          right: 20
        })
        .justifyContent(FlexAlign.Center)

      }
      .width('100%')
      .height("100%")
      .backgroundColor("#f1f3f5")
      .padding({
        left: 12,
        right: 12,
        bottom: 24
      })


      //遮罩层
      if (this.isLogining) {
        this.logingLayout()
      }
    }.width("100%").height("100%")

  }

  //发起登录
  private requestLogin() {
    this.isLogining = true;
    setTimeout(() => {
      //假装登录成功了
      this.mLoginStatus = true;
      this.isLogining = false;
      this.clearAccount();
      router.back();
    }, 3000);
  }

  private clearAccount() {
    this.mAccount = "";
    this.mPassword = "";
  }

  private checkLoginOk(account: string, password: string): boolean {
    return account !== '' && password !== ''
  }
}



import { KeyboardAvoidMode, window } from '@kit.ArkUI';

@Entry
@Component
struct PageKeyboardDemo {
  @State message: string = 'Hello World';

  aboutToAppear(): void {

    //键盘避让，只有真机才有效
    this.getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE)
  }

  build() {

    Column() {
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .layoutWeight(1)//必须有这种填充剩余区域的，才可以避让，不然无法避让
      //键盘避让，只有真机才有效
      TextInput({ placeholder: "输入框" }).width("100%").height(80)

    }
    .width('100%').height('100%')

  }
}
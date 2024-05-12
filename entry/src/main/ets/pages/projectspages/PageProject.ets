import NetworkApi from '../../networks/NetworkApi';
import Logger from '../../utils/Logger';
import { Pager } from '../homepages/Beans';
import { promptAction } from '@kit.ArkUI';
import inspector from '@ohos.arkui.inspector'

@Entry
@Component
struct PageProject {
  @State message: string = 'Hello World';
  @State mPapgers: Array<Pager> = []

  build() {
    Column() {
      List() {
        ForEach(this.mPapgers, (item: Pager) => {
          ListItem() {
            Column() {


              Text(item.title).width("100%").height(60)
              Image(item.envelopePic).width("100%")

              Text(item.desc).width("100%").height(60)

            }
          }

        })
      }.divider({
        strokeWidth: 2,
        color: "#ff616e61"
      })

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#E67C92')
    .justifyContent(FlexAlign.Center)

  }

  // onMeasure自定义组件确定尺寸时，将该自定义组件的节点信息和尺寸范围通过onMeasureSize传递给该开发者
  // 不允许在onMeasureSize函数中改变状态变量。
  // onMeasureSize(selfLayoutInfo: GeometryInfo, children: Measurable[], constraint: ConstraintSizeOptions): SizeResult {
  //
  //   return {width:100,height:200}
  // }

  ///onLayout
  // onPlaceChildren(selfLayoutInfo: GeometryInfo, children: Layoutable[], constraint: ConstraintSizeOptions): void {
  // }

  //组件布局绘制完成回调的句柄，包含了申请句柄时的首次查询结果。
  // listener: inspector.ComponentObserver = inspector.createComponentObserver('IMAGE_ID')

  aboutToAppear(): void {
    this.getInitData()


    // let onLayoutComplete: () => void = (): void => {
    //   // do something here
    // }
    // let onDrawComplete: () => void = (): void => {
    //   // do something here
    // }
    // let offLayoutComplete: () => void = (): void => {
    //   // do something here
    // }
    // let offDrawComplete: () => void = (): void => {
    //   // do something here
    // }
    // let FuncLayout = onLayoutComplete // bind current js instance
    // let FuncDraw = onDrawComplete // bind current js instance
    // let OffFuncLayout = offLayoutComplete // bind current js instance
    // let OffFuncDraw = offDrawComplete // bind current js instance
    //
    // this.listener.on('layout', FuncLayout)
    // this.listener.on('draw', FuncDraw)

    // 通过句柄向对应的查询条件取消注册回调，由开发者自行决定在何时调用。
    // this.listener.off('layout', OffFuncLayout)
    // this.listener.off('draw', OffFuncDraw)

  }

  async getInitData() {

    try {

      let result: Array<Pager> = await NetworkApi.getInstance().getFrashProject()

      this.mPapgers = result


    } catch (error) {
      Logger.info("resultttt", "result==>" + error)
      promptAction.showToast({ message: "请求出错了" })
    }


  }
}

export {
  PageProject
}
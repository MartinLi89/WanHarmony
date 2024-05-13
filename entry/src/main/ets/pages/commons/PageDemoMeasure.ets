import inspector from '@ohos.arkui.inspector'
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct PageDemoMeasure {
  @State message: string = 'Hello World';

  build() {

    Column() {

      CustomLayout({ builder: this.ColumnChildren })

    }
    .width('100%')
    .height('100%').justifyContent(FlexAlign.Start).alignItems(HorizontalAlign.Start)

  }

  @Builder
  ColumnChildren() {
    ForEach([1, 2, 3], (index: number) => { //暂不支持lazyForEach的写法
      Text('S' + index)
        .fontSize(30)
        .width(50)
        .height(50)
        .borderWidth(2)
      // .backgroundColor("#00ff00")
      // .offset({ x: 10, y: 20 })
    })
  }

  // onMeasure自定义组件确定尺寸时，将该自定义组件的节点信息和尺寸范围通过onMeasureSize传递给该开发者
  // 不允许在onMeasureSize函数中改变状态变量。
  // onMeasureSize(selfLayoutInfo: GeometryInfo, children: Measurable[], constraint: ConstraintSizeOptions): SizeResult {
  //
  //   return {width:500,height:2000}
  // }

  ///onLayout
  // onPlaceChildren(selfLayoutInfo: GeometryInfo, children: Layoutable[], constraint: ConstraintSizeOptions): void {
  // }


  //组件布局绘制完成回调的句柄，包含了申请句柄时的首次查询结果。
  listener: inspector.ComponentObserver = inspector.createComponentObserver('IMAGE_ID')

  aboutToAppear(): void {


    let onLayoutComplete: () => void = (): void => {
      // do something here
      console.log("lssyyy onLayoutComplete")
    }
    let onDrawComplete: () => void = (): void => {
      // do something here
      console.log("lssyyy onDrawComplete")
    }
    let offLayoutComplete: () => void = (): void => {
      // do something here
      console.log("lssyyy offLayoutComplete")
    }
    let offDrawComplete: () => void = (): void => {
      // do something here
      console.log("lssyyy offDrawComplete")
    }
    let FuncLayout = onLayoutComplete // bind current js instance
    let FuncDraw = onDrawComplete // bind current js instance
    let OffFuncLayout = offLayoutComplete // bind current js instance
    let OffFuncDraw = offDrawComplete // bind current js instance

    this.listener.on('layout', FuncLayout)
    this.listener.on('draw', FuncDraw)

    // 通过句柄向对应的查询条件取消注册回调，由开发者自行决定在何时调用。
    // this.listener.off('layout', OffFuncLayout)
    // this.listener.off('draw', OffFuncDraw)

  }
}

@Component
struct CustomLayout {
  @Builder
  doNothingBuilder() {
  };

  @BuilderParam builder: () => void = this.doNothingBuilder;
  @State startSize: number = 1;
  result: SizeResult = {
    width: 0,
    height: 0
  };

  onPlaceChildren(selfLayoutInfo: GeometryInfo, children: Array<Layoutable>, constraint: ConstraintSizeOptions) {

    console.log("lssyyy onPlaceChildren")


    let pos = 0;
    children.forEach((child) => {

      //子组件的排版
      child.layout({ x: 10, y: pos })
      pos += child.measureResult.height;
    })
  }

  onMeasureSize(selfLayoutInfo: GeometryInfo, children: Array<Measurable>, constraint: ConstraintSizeOptions): SizeResult {

    console.log("lssyyy onMeasureSize")

    let size = 100; //宽度
    children.forEach((child) => {
      //子控件的宽高
      //子组件测量宽高
      let result: MeasureResult = child.measure({ minHeight: size, minWidth: size, maxWidth: size, maxHeight: size })
      size = result.width + 10
      ;
    })
    this.result.width = 1;
    this.result.height = 10;
    return this.result;
  }

  build() {
    this.builder()
  }
}
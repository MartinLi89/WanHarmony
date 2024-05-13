import inspector from '@ohos.arkui.inspector'
import { promptAction } from '@kit.ArkUI';
import curves from '@ohos.curves';
@Entry
@Component
struct PageDemoMeasure {
  @State positionX: number = 100;
  @State positionY: number = 100;
  diameter: number = 50;

  build() {
    Column() {
      Row() {
        Circle({ width: this.diameter, height: this.diameter })
          .fill(Color.Blue)
          .position({ x: this.positionX, y: this.positionY })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Move) {
              // 跟手过程，使用responsiveSpringMotion曲线
              animateTo({ curve: curves.responsiveSpringMotion() }, () => {
                // 减去半径，以使球的中心运动到手指位置
                this.positionX = event.touches[0].screenX - this.diameter / 2;
                this.positionY = event.touches[0].screenY - this.diameter / 2;
                console.info(`move, animateTo x:${this.positionX}, y:${this.positionY}`);
              })
            } else if (event.type === TouchType.Up) {
              // 离手时，使用springMotion曲线
              animateTo({ curve: curves.springMotion() }, () => {
                this.positionX = 100;
                this.positionY = 100;
                console.info(`touchUp, animateTo x:100, y:100`);
              })
            }
          })
      }
      .width("100%").height("80%")
      .clip(true) // 如果球超出父组件范围，使球不可见
      .backgroundColor(Color.Orange)

      Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Start, justifyContent: FlexAlign.Center }) {
        Text("拖动小球").fontSize(16)
      }
      .width("100%")

      Row() {
        Text('点击位置: [x: ' + Math.round(this.positionX) + ', y:' + Math.round(this.positionY) + ']').fontSize(16)
      }
      .padding(10)
      .width("100%")
    }.height('100%').width('100%')
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
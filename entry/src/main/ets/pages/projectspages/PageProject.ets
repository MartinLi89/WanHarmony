import NetworkApi from '../../networks/NetworkApi';
import Logger from '../../utils/Logger';
import { Pager } from '../homepages/Beans';
import { curves, promptAction } from '@kit.ArkUI';
import inspector from '@ohos.arkui.inspector'

@Entry
@Component
struct PageProject {
  @State message: string = 'Hello World';
  @State mPapgers: Array<Pager> = []

  build() {
    Column() {

      DemoStack({ mPapgers: this.mPapgers })

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#E67C92')
    .justifyContent(FlexAlign.Center)
    .clip(true)

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

@Component
struct DemoStack {
  @Link mPapgers: Array<Pager>
  @State mPoint: number[] = [0, 0]
  @State flag: boolean = false
  @State positionX: number = 0;
  @State positionY: number = 0;
  diameter: number = 50;

  build() {


    Stack() {


      if (this.mPapgers) {

        ForEach(this.mPapgers, (item: Pager, index: number) => {

          MyDragCard({
            mPager: item,
            // mPoint: this.mPoint,
            flag: index === this.mPapgers.length - 1,
            positionX: this.positionX,
            positionY: this.positionY,
            index: index
          })

        })

        // List() {
        //   ForEach(this.mPapgers, (item: Pager, index: number) => {
        //     ListItem() {
        //
        //       MyDragCard({
        //         mPager: item,
        //         mPoint: this.mPoint,
        //         flag: index === this.mPapgers.length-1,
        //         positionX: this.positionX,
        //         positionY: this.positionY,
        //         index: index
        //       })
        //     }
        //   })
        // }

      }

    }.width("100%").height("100%")
    .onAreaChange((old, newValue) => {
      if (this.mPoint[0] === 0) {
        this.mPoint[0] = newValue.width as number / 2 * 0.3
        this.mPoint[1] = newValue.height as number / 2 * 0.3
        this.positionX = this.mPoint[0];
        this.positionY = this.mPoint[1];
      }
    })
    .clip(false) //如果超出父组件的范围时，希望子组件完整的显示，那么可以设置父组件的clip属性为false，使父组件不对子组件产生裁剪

  }

  @State translateX: number = 0

  private jumpWithSpeed(speed: number) {
    this.translateX = -1;
    animateTo({ duration: 2000, curve: curves.springCurve(speed, 1, 1, 1.2) }, () => {
      // 以指定初速度进行x方向的平移的弹簧动画
      this.translateX = 0;
    })
  }
}


@Component
struct MyDragCard {
  mPager: Pager = new Pager()
  mPoint: number[] = [0, 0]
  flag: boolean = false
  @Prop positionX: number
  @Prop positionY: number
  diameter: number = 50;
  index: number = 0

  build() {
    Stack({ alignContent: Alignment.Center }) {

      Image(this.mPager?.envelopePic)
        .width("100%")
        .height("100%")
        .borderRadius(20)
      Column() {
        Text(this.mPager?.title)
          .width("100%")
          .height(60)
          .textAlign(TextAlign.Center)
          .backgroundColor(Color.Yellow)
          .borderRadius({ topLeft: 20, topRight: 20 })

        Text(this.mPager?.desc).width("100%").height(60)
          .backgroundColor(Color.Yellow)
          .borderRadius({ bottomLeft: 20, bottomRight: 20 })
      }.width("100%")
      .height("100%")
      .justifyContent(FlexAlign.SpaceBetween)
      .borderRadius(20)

    }
    .width(this.flag ? "60%" : "70%")
    .height(this.flag ? "60%" : "70%")
    .backgroundColor(Color.White)
    .borderRadius(20)
    .borderWidth(2)
    .borderColor("#00ff00")
    .position({ x: this.positionX, y: this.positionY }) //卡片当前位置

    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Move) {
        // 跟手过程，使用responsiveSpringMotion曲线
        animateTo({ curve: curves.responsiveSpringMotion() }, () => {

          this.positionX = event.touches[0].windowX ;
          this.positionY = event.touches[0].windowY  ;
        })

      } else if (event.type === TouchType.Up) {
        // 离手时，使用springMotion曲线，卡片复归
        animateTo({ curve: curves.springMotion() }, () => {
          this.positionX = this.mPoint[0];
          this.positionY = this.mPoint[1];
        })
      }
    })
    .clip(true)
    .onAreaChange((old, newValue) => {
      if (this.mPoint[0] === 0) {
        if (this.flag) {
          this.mPoint[0] = newValue.width as number / 2 * 0.4
          this.mPoint[1] = newValue.height as number / 2 * 0.4

        } else {
          this.mPoint[0] = newValue.width as number / 2 * 0.3
          this.mPoint[1] = newValue.height as number / 2 * 0.3
        }
        this.positionX = this.mPoint[0];
        this.positionY = this.mPoint[1];

      }
    })
  }
}

export {
  PageProject
}
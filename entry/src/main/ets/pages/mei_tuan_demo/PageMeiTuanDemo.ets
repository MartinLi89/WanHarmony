import { Category } from './models/MeiTuanBeans';
import { getData } from './network/Api';
import PageMtBody from './PageMtBody';
import PageMtPopUpCart from './PageMtPopUpCart';
import PageMtTiTle from './PageMtTiTle';
import PageMyFloatFoot from './PageMyFloatFoot';
import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct PageMeiTuanDemo {
  @State
  list: Category[] = []
  @Provide //需要多层观察
  showCart: boolean = false
  @State
  topMargin: number = 0

  @State
  bottomMargin: number = 0

  async aboutToAppear() {
    this.list = await getData()

    //设置当前页面的沉浸式
    window.getLastWindow(getContext())
      .then(win => {
        //获取顶部statusbar大小
        const windowVisable = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM).visible

        //顶部高度
        const topHeight = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM).topRect.height
        const bottomHeight = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR).topRect.height
        console.info(topHeight +'bottomHeight===>'+bottomHeight+ 'windowVisable==>' + windowVisable);

        //1vp=3px，此处返回的时 px，但是设置时，用的确实vp，所以需要除以3进行转换
        this.topMargin = topHeight/3
        this.bottomMargin=bottomHeight


        //隐藏状态栏和底部导航栏
        // return win.setWindowSystemBarEnable([])
        //好像两个 方法都可以设置
        return win.setWindowLayoutFullScreen(true)
      })
      .then(() => {
        //查看下结果
        window.getLastWindow(getContext()).then(win => {
          const windowVisable = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM).visible
          console.info('windowVisable==>' + windowVisable);
        })

      })
      .catch((error: BusinessError) => {
        console.error('Failed to set the system bar to be invisible. Cause:' + JSON.stringify(error));
      })


  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        PageMtTiTle()
        PageMtBody({
          list: this.list
        })
          .layoutWeight(1)

      }.width("100%")
      .height("100%")


      if (this.showCart) {
        PageMtPopUpCart()
      }

      PageMyFloatFoot()


    }.width("100%")
    .height("100%")
    .padding({
      top: this.topMargin,
      bottom:this.bottomMargin
    })


    // .backgroundColor(Color.Red)
    //沉浸式方法3
    .expandSafeArea([SafeAreaType.SYSTEM],[SafeAreaEdge.TOP,SafeAreaEdge.BOTTOM])
  }
}
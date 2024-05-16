import { Category } from './models/MeiTuanBeans';
import { getData } from './network/Api';
import PageMtBody from './PageMtBody';
import PageMtPopUpCart from './PageMtPopUpCart';
import PageMtTiTle from './PageMtTiTle';
import PageMyFloatFoot from './PageMyFloatFoot';

@Entry
@Component
struct PageMeiTuanDemo {
  @State
  list: Category[] = []
  @Provide//需要多层观察
  showCart: boolean = false


  async aboutToAppear(){
    this.list = await getData()
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

    // .backgroundColor(Color.Red)
  }
}
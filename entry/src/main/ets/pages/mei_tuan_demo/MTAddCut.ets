import { CartStore } from './MeiTuanUtils/CartStore'
import { FoodItem } from './models/MeiTuanBeans'

@Preview
@Component
struct MTAddCut {
  // @Prop 无法使用修饰符，因为外侧传参的地方，无法被 observed
  food: FoodItem = new FoodItem()
  //绑定整体展示数据
  @StorageLink('cart_list')
  cartList: FoodItem[] = []
  @State
  messageCount: string = "0"

  getCount() {

    const index = this.cartList.findIndex((listItem: FoodItem) => listItem.id === this.food.id)
    if (index >= 0) {
      let listItemsss: FoodItem = this.cartList[index]
      if (listItemsss) {
        this.messageCount = listItemsss.count + ""
      } else {
        this.messageCount = "0"
      }
    } else {
      this.messageCount = "0"
    }


    // this.messageCount = listItem?.count + "" || "0"
  }

  build() {
    Row({ space: 8 }) {
      Row() {
        Image($r('app.media.ic_screenshot_line'))
          .width(10)
          .aspectRatio(1)
      }
      .width(16)
      .aspectRatio(1)
      .justifyContent(FlexAlign.Center)
      .backgroundColor($r("app.color.white"))
      .borderRadius(4)
      .border({ width: 0.5, color: $r("app.color.main_color") })

      .onClick(() => {
        if (Number(this.messageCount) <= 0) {
          return
        }

        CartStore.addCut(this.food, false)
        this.getCount()
      })
      .enabled(Number(this.messageCount) > 0)
      .visibility(Number(this.messageCount) <= 0 ? Visibility.Hidden : Visibility.Visible)

      //展示选中数量
      Text(this.messageCount)
        .fontSize(14)
      Row() {
        Image($r('app.media.ic_public_add_filled'))
          .width(10)
          .aspectRatio(1)

      }
      .width(16)
      .aspectRatio(1)
      .justifyContent(FlexAlign.Center)
      .backgroundColor($r("app.color.main_color"))
      .borderRadius(4)
      .onClick(() => {
        CartStore.addCut(this.food)
        this.getCount()
      })
    }
    .onAreaChange(() => {
      this.getCount()

    })
  }
}

export default MTAddCut
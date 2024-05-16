import { FoodItem } from './models/MeiTuanBeans'
import PageFoodItem from './PageFoodItem'
import PageMtPopUpItem from './PageMtPopUpItem'

@Preview
@Component
export default struct PageMtPopUpCart {
  @Consume('showCart')
  showCart: boolean
  @StorageLink('cart_list')
  cartList: FoodItem[] = []

  build() {
    Column() {
      Blank()
        .backgroundColor('rgba(0, 0, 0, 0.7)')
        .onClick(() => {
          this.showCart = false
        })
      Column() {
        Row() {
          Text('购物车')
          Text('清空购物车')
            .fontColor($r('app.color.search_back_color'))
        }
        .width('100%')
        .padding(20)
        .justifyContent(FlexAlign.SpaceBetween)

        Divider().strokeWidth(1)

        List({ space: 20 }) {
          ForEach(this.cartList, (food: FoodItem) => {
            PageMtPopUpItem({
              food: food
            })
          })
        }
        .padding({
          top: 10,
          left: 20,
          right: 20,
          bottom: 120
        })
      }
      .width('100%')
      .backgroundColor($r('app.color.white'))
    }
    .width('100%')
    .height('100%')
  }
}
import { promptAction } from '@kit.ArkUI'
import { FoodItem } from './models/MeiTuanBeans'

@Preview
@Component
export default struct PageMyFloatFoot {


  @Consume('showCart')
  showCart:boolean

  @StorageLink('cart_list')
  cartList:FoodItem[] = []

  build() {

    //两层 row，外层控制位置，内层控制形状
    Row() {
      Row() {

        Badge({
          value: this.cartList.length.toString(),//展示用户选中了多少种类的菜单
          position: BadgePosition.Right,
          style: { badgeSize: 18, badgeColor: '#FA2A2D' }
        }) {
          Image($r('app.media.ic_public_cart'))
            .width(48)
            .height(60)
            .position({
              y: -10
            })
        }
        .margin({
          left: 20,
          right: 10
        })

        .onClick(() => {
          this.showCart = !this.showCart
        })

        //   价格
        Column() {
          // span  imageSpan
          Text() {
            Span('￥')
              .fontSize(12)
            Span('0.00')
              .fontSize(24)
          }
          .fontColor($r('app.color.white'))

          Text('预计配送费 ￥5')
            .fontColor($r('app.color.search_font_color'))
            .fontSize(14)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)


        //   结算
        Text('去结算')
          .height(50)
          .width(100)
          .backgroundColor($r('app.color.main_color'))
          .textAlign(TextAlign.Center)
          .fontWeight(FontWeight.Bold)
          .borderRadius({
            topRight:25,
            bottomRight:25
          })

      }
      .width('100%')
      .height(50)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .backgroundColor($r('app.color.bottom_back'))
      .borderRadius(25)
      .clip(false)

    }
    .width("100%")

    .padding(20)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)

  }
}
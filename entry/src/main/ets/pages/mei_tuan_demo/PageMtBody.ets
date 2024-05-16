import { Category, FoodItem } from './models/MeiTuanBeans'
import PageFoodItem from './PageFoodItem'

@Preview
@Component
export default struct PageMtBody {
  @Prop
  list: Category[] = []
  @State
  activeIndex: number = 0

  build() {
    Row() {
      Scroll() {
        Column() {
          //左侧布局
          ForEach(this.list, (item: Category, index: number) => {
            Text(item.name)
              .height(50)
              .width('100%')
              .textAlign(TextAlign.Center)
              .fontSize(14)
              .backgroundColor(this.activeIndex === index ? $r('app.color.white') : $r('app.color.left_back_color'))
              .onClick(() => {
                this.activeIndex = index
              })
          })
        }
        .height('100%')
        .width(90)
        .backgroundColor($r('app.color.left_back_color'))
      }

      //右侧列表
      List() {
        if (this.list.length > 0) {
          ForEach(this.list[this.activeIndex].foods, (item: FoodItem) => {
            ListItem() {
              PageFoodItem({
                item: item
              })
            }
          })
        } else {
          ListItem() {
            Text('暂无商品上架~')
          }
        }
      }.layoutWeight(1)
      .padding({
        bottom: 60
      })
    }
    .alignItems(VerticalAlign.Top)
    .height('100%')
  }
}
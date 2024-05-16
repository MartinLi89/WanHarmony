import { FoodItem } from './models/MeiTuanBeans'
import MTAddCut from './MTAddCut'

@Component
struct PageMtPopUpItem {
  food:FoodItem = new FoodItem()
  build() {
    Row() {
      Image(this.food.picture)
        .width(60)
        .aspectRatio(1)
        .borderRadius(8)
      Column({ space: 5 }) {
        Text(this.food.name)
          .fontSize(14)
          .textOverflow({
            overflow: TextOverflow.Ellipsis
          })
          .maxLines(2)
        Row() {
          Text() {
            Span('¥ ')
              .fontColor($r("app.color.font_main_color"))
              .fontSize(10)
            Span(this.food.price.toString())
              .fontColor($r("app.color.font_main_color"))
              .fontWeight(FontWeight.Bold)
          }
          MTAddCut({
            food:this.food
          })
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 10, right: 10 })
    }
    .alignItems(VerticalAlign.Top)
  }
}
export default PageMtPopUpItem
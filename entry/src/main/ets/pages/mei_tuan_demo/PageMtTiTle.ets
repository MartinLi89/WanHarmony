@Preview
@Component
export default struct PageMtTiTle {
  /**
   *
   * @param active 是否为选中页
   * @param title 名称
   * @param subTitle 子标题
   */
  @Builder
  NavItem(active: boolean, title: string, subTitle?: string) {
    Column() {
      Text() {
        Span(title)
        if (subTitle) {
          Span(' ' + subTitle)
            .fontSize(10)
            .fontColor(active ? $r("app.color.black") : $r("app.color.un_select_color"))
        }
      }.layoutWeight(1)
      .fontColor(active ? $r("app.color.black") : $r("app.color.un_select_color"))
      .fontWeight(active ? FontWeight.Bold : FontWeight.Normal)

      //底部指示器
      Text()
        .height(1)
        .width(20)
        .margin({ left: 6 })
        .backgroundColor(active ? $r("app.color.select_border_color") : 'transparent')
    }
    .width(73)
    .alignItems(HorizontalAlign.Start)
    .padding({ top: 3 })
  }

  build() {
    Row() {
      Row() {
        this.NavItem(true, '点菜')
        this.NavItem(false, '评价', '1796')
        this.NavItem(false, '商家')
        Row() {
          Image($r('app.media.ic_public_search'))
            .width(14)
            .aspectRatio(1)
            .fillColor($r("app.color.search_font_color"))
          Text('请输入菜品名称')
            .fontSize(12)
            .fontColor($r("app.color.search_back_color"))
        }
        .backgroundColor($r("app.color.search_back_color"))
        .height(25)
        .borderRadius(13)
        .padding({ left: 5, right: 5 })
        .layoutWeight(1)

      }
      .height(40)
      .width('100%')
      .padding({ left: 15, right: 15 })
      .border({ width: { bottom: 0.5 }, color: $r("app.color.top_border_color") })
    }
  }
}
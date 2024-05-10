const tabBarHeight: number = 60

interface HomeItemInterface {

  mName: string
  mRes: ResourceStr

}

export class HomeItem implements HomeItemInterface {
  mName = ""
  mRes = $r("app.media.mine")

  constructor(flags: HomeItem) {
    this.mName = flags.mName
    this.mRes = flags.mRes

  }
}


@Entry
@Component
struct Index {
  @State currentIndex: number = 2
  private controller: TabsController = new TabsController()
  private mHomeList: Array<HomeItemInterface> = [
    { mName: "首页", mRes: $r("app.media.home") } as HomeItemInterface,
    { mName: "体系", mRes: $r("app.media.frame") } as HomeItemInterface,
    { mName: "导航", mRes: $r("app.media.navigation") } as HomeItemInterface,
    { mName: "项目", mRes: $r("app.media.progress") } as HomeItemInterface,
    { mName: "我的", mRes: $r("app.media.mine") } as HomeItemInterface,
  ]

  aboutToAppear(): void {


  }

  @Builder
  tabBuilder(title: string, tabUrl: ResourceStr, targetIndex: number) {
    Column() {
      Image(tabUrl)
        .width("100%")
        .height("100%")
        .size({
          width: 28,
          height: 28
        })
        .fillColor(this.currentIndex === targetIndex ? $r("app.color.main") : $r("app.color.navi_tab_unselect"))

      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
        .fontSize(11)
        .margin({ top: 6 })


    }
    .width('100%')
    .height(tabBarHeight)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  tabContentBuilder(index: number) {
    if (index === 0) {

      Column() {
        Text('首页的内容')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#00CB87')
      .justifyContent(FlexAlign.Center)
    } else if (index === 1) {

      Column() {
        Text('体系的内容')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#007DFF')
      .justifyContent(FlexAlign.Center)
    } else if (index === 2) {
      Column() {
        Text('导航的内容')
      }.width('100%')
      .height('100%')
      .backgroundColor('#FFBF00')
      .justifyContent(FlexAlign.Center)

    } else if (index === 3) {
      Column() {
        Text('项目的内容')
      }.width('100%')
      .height('100%')
      .backgroundColor('#E67C92')
      .justifyContent(FlexAlign.Center)

    } else if (index === 4) {
      Column() {
        Text('我的内容')
      }.width('100%')
      .height('100%')
      .backgroundColor('#E67C92')
      .justifyContent(FlexAlign.Center)

    }


  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, controller: this.controller, index: $$this.currentIndex }) {

        ForEach(this.mHomeList, (item: HomeItemInterface, index: number) => {
          TabContent() {
            this.tabContentBuilder(index)
          }.tabBar(this.tabBuilder(item.mName, item.mRes, index))
        })
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .barWidth("100%")
      .barHeight(tabBarHeight)
      .animationDuration(0)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .width("100%")
      .height("100%")
      .backgroundColor('#F1F3F5')
      .scrollable(true)

    }.width('100%').height("100%")
  }
}



import PageHomeTabLayout from './homepages/PageHomeTabLayout';
import PageMine from './minepages/PageMine'
import { PageNavi } from './navipages/PageNavi';
import { PageProject } from './projectspages/PageProject';
import { PageFrameTree } from './treepages/PageFrameTree';

const tabBarHeight: number = 60

AppStorage.setOrCreate("mLoginStatus", false);

interface HomeItemInterface {

  mName: string
  mRes: ResourceStr

}

export class HomeItem implements HomeItemInterface {
  mName = ""
  mRes: ResourceStr = $r("app.media.mine")

  constructor(flags: HomeItemInterface) {
    this.mName = flags.mName
    this.mRes = flags.mRes
  }
}


@Entry
@Component
struct Index {
  @State mCurrentIndex: number = 3
  @StorageLink("mLoginStatus") mLoginStatus: boolean = false
  private mController: TabsController = new TabsController()
  private mHomeList: Array<HomeItemInterface> = [
    { mName: "首页", mRes: $r("app.media.home") } as HomeItemInterface,
    { mName: "知识体系", mRes: $r("app.media.frame") } as HomeItemInterface,
    { mName: "导航", mRes: $r("app.media.navigation") } as HomeItemInterface,
    { mName: "项目", mRes: $r("app.media.progress") } as HomeItemInterface,
    { mName: "我的", mRes: $r("app.media.mine") } as HomeItemInterface
  ]

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
        .fillColor(this.mCurrentIndex === targetIndex ? $r("app.color.main") : $r("app.color.navi_tab_unselect"))

      Text(title)
        .fontColor(this.mCurrentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
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
      PageHomeTabLayout()
    } else if (index === 1) {
      PageFrameTree()
    } else if (index === 2) {
      PageNavi()
    } else if (index === 3) {
      PageProject()
    } else if (index === 4) {
      PageMine()
    }


  }

  build() {
    Column() {
      //layout + 底部tabbarUI
      Tabs({ barPosition: BarPosition.End, index: $$this.mCurrentIndex, controller: this.mController }) {

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
        this.mCurrentIndex = index
      })
      .width("100%")
      .height("100%")
      .backgroundColor('#F1F3F5')
      .scrollable(true)

    }.width('100%').height("100%")
  }
}



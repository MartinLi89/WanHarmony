import NetworkApi from '../../networks/NetworkApi';
import Logger from '../../utils/Logger';
import { Navi, Pager } from '../homepages/Beans';
import { promptAction, router } from '@kit.ArkUI';
import CommonValues from '../commons/CommonValues';

@Component
struct PageNavi {
  @State message: string = 'Hello World';
  @State @Watch("onDataChange") mNaviList: Array<Navi> = [];
  @State mArticals: Array<Pager> = []

  onDataChange() {
    if (this.mNaviList && this.mNaviList.length > 0
      && this.mNaviList[0].articles) {

      this.mArticals = this.mNaviList[0].articles

    }

  }

  build() {

    Column() {
      Row() {


        List() {
          //左侧布局
          ForEach(this.mNaviList, (item: Navi) => {

            ListItem() {

              Text(item.name).layoutWeight(1).height(60).onClick(() => {
                if (item.articles) {

                  this.mArticals = item.articles
                }
              })
            }
          })
        }.width("26%")

        Line()
        //右侧布局
        Flex({ wrap: FlexWrap.Wrap, direction: FlexDirection.Row }) {

          ForEach(this.mArticals, (item: Pager) => {


            Text(item.title)
              .height(40)
              .padding(4)
              .margin(4)
              .backgroundColor(this.getRandomColor())
              .borderRadius(4)
              .onClick(() => {
                if (item.link === CommonValues.LOCAL_PAGE) {

                  getContext().eventHub.emit(CommonValues.LOCAL_PAGE)

                } else {
                  //打开对应的资源文章
                  router.pushUrl({
                    url: "pages/PageArticalDetail",
                    params: {
                      linkUrl: item.link,
                      title: "导航推荐"

                    }
                  })

                }


              })

          })

        }.layoutWeight(1).height("100%")


        // List() {
        //   ForEach(this.mArticals, (item: Pager) => {
        //
        //     ListItem() {
        //
        //       Text(item.title).layoutWeight(1).height(60)
        //     }
        //   })
        // }.layoutWeight(1).height("100%")

      }
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFBF00')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
  }

  aboutToAppear(): void {
    this.getInitData()
  }

  async getInitData() {

    try {

      let result: Array<Navi> = await NetworkApi.getInstance().getNavi()
      let currentFirst = new Navi()
      currentFirst.name = '随机妹子图'

      let localPage = new Pager()


      localPage.title = "随机妹子图"
      localPage.link = CommonValues.LOCAL_PAGE
      currentFirst.articles = new Array<Pager>()
      currentFirst.articles.unshift(localPage)

      result.unshift(currentFirst)
      this.mNaviList = result


    } catch (error) {
      Logger.info("resultttt", "result==>" + error)
      promptAction.showToast({ message: "请求出错了" })
    }


  }

  getRandomColor(): string {
    let letters = "0123456789ABCDEF";
    let color = "#";
    for (let i = 0; i < 6; i++) {
      color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
  }
}

export {
  PageNavi

}
import NetworkApi from '../../networks/NetworkApi';
import Logger from '../../utils/Logger';
import { BannerBean, HomeArticleList, Pager } from './Beans';
import { promptAction } from '@kit.ArkUI';

@Preview
@Component
export default struct PageHomeTabLayout {
  @State message: BannerBean[] = [];
  @State papers: Array<Pager> = [] as Pager[];
  private swiperController: SwiperController = new SwiperController()

  @Builder
  getPagerLayout(item: Pager) {
    Column() {


      Text("文章标题：" + item.title)
        .height(40)
        .width("100%")
        .maxLines(2)
      Row() {
        Text("作者:" + item.author)
          .height(20)
        // let publishTime: string = this.getDataTime(item.publishTime)
        Text(this.getDataTime(item.publishTime))
          .height(20)

      }
      .height(20)
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)

    }
    .width("100%")
    .height(60)
    .onClick(()=>{
      promptAction.showToast({ message: item.link })

    })

  }

  build() {
    Column() {
      Swiper(this.swiperController) {
        ForEach(this.message, (item: BannerBean) => {
          Image(item.imagePath)
            .width("100%")
            .objectFit(ImageFit.Contain)
        })
      }
      .loop(true)
      .autoPlay(true)
      .interval(1000)

      // Text(this.papers[0]?.title)
      //   .width("100%")
      //   .height(60)


      List({ space: 10 }) {
        ForEach(this.papers, (item: Pager) => {
          ListItem() {

            this.getPagerLayout(item)
          }
        })

      }.layoutWeight(1)
      .width("100%")
      .divider({
        strokeWidth: 2,
        color: "#00ffff"

      })

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#00CB87')
    .justifyContent(FlexAlign.Center)
  }

  aboutToAppear(): void {
    this.initDataRequest()


  }

  async initDataRequest() {

    try {

      // this.message = await NetworkApi.getInstance().getBanner()
      // this.papers = await NetworkApi.getInstance().getArticle()


      Promise.all([NetworkApi.getInstance().getBanner(), NetworkApi.getInstance().getArticle()])
        .then((values: [Array<BannerBean>, Array<Pager>]) => {
          this.message = values[0]
          this.papers = values[1]
        })
    } catch (error) {
      Logger.info("resultttt", "result==>" + error)
      promptAction.showToast({ message: "请求出错了" })
    }

  }

  getDataTime(publishTime: number | undefined): string {

    let time: Date
    if (publishTime) {

      time = new Date(publishTime)
      return "发布时间：" + time.toDateString()
    }
    time = new Date()
    return time.toString()

  }
}



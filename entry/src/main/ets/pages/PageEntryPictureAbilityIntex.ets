import NetworkApi from '../networks/NetworkApi';
import Logger from '../utils/Logger';
import { promptAction } from '@kit.ArkUI';
import { CommonTitle } from './commons/PageCommonView';

@Entry
@Component
struct PageEntryPictureAbilityIntex {
  @State message: string = 'Hello World';
  @State girls: string[] = []

  build() {
    Column() {
      CommonTitle({mTitle:"妹子"})
      if (this.girls) {





        // Image("https://i.33xp.cn/loading__imgapi.cn__/__imgapi.cn__14.gif")
        //   .width("100%")
        //   .height(80)

        List() {
          ForEach(this.girls, (item: string) => {
            ListItem() {
              Stack({alignContent:Alignment.TopStart}){

                Image(item)
                  .height(80)
                  .width("100%")
                    // .sourceSize({
                    //   width:100,
                    //   height:60
                    //
                    // })
                  .aspectRatio(1)
                  .fitOriginalSize(false)//设置图片的显示尺寸是否跟随图源尺寸。
                  .autoResize(true)//设置图片解码过程中是否对图源自动缩放
                  .onComplete(()=>{

                  })
                  .onError((error)=>{

                    Logger.info("PageEntry", "result==>" + JSON.stringify(error))
                    promptAction.showToast({message:error.message})
                  })


                Text(item.replace(/%20/g,' '))
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold).opacity(0.6)

              }


            }
          })
        }
        .layoutWeight(1).width("100%")
        .divider({
          strokeWidth:1,
          color:"#00ff00"
        })
      }
    }
    .width('100%').height('100%')

  }

  aboutToAppear(): void {
    this.getInitData()
  }

  async getInitData() {

    try {

      this.girls = await NetworkApi.getInstance().getGirls()


    } catch (error) {
      Logger.info("resultttt", "result==>" + error)
      promptAction.showToast({ message: "请求出错了" })
    }


  }
}
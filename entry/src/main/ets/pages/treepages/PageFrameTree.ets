import NetworkApi from '../../networks/NetworkApi';
import { promptAction, router } from '@kit.ArkUI';
import Logger from '../../utils/Logger';
import { Pager, Tree } from '../homepages/Beans';
import { ifaa } from '@kit.OnlineAuthenticationKit';

@Component
export struct PageFrameTree {
  @State mMessage: string = 'PageFrameTree';
  @State @Watch("onDataChange") mTreeList: Array<Tree> = []
  @State mCurrentSelectItem: Tree = {}
  @State mArticalTree: Tree = {}
  @State mBindSheet: boolean = false

  @Builder
  getTreeItemLayout(currentList: Array<Tree>, isFirst: boolean) {

    if (currentList) {
      List() {
        ForEach(currentList, (item: Tree) => {
          ListItem() {

            Text(item.name)
              .width("100%")
              .height(40)
              .backgroundColor(isFirst ? "#ff4e79e6" : "#ffedd36f")
              .maxLines(2)
              .onClick(() => {
                this.mCurrentSelectItem = item


                this.mMessage = item.name as string
              })
          }

        })

      }.layoutWeight(1)
      .height("100%")
      .divider({
        strokeWidth: 2,
        color: "#44444f"

      })

    }
  }

  onDataChange() {
    if (this.mTreeList && this.mTreeList.length > 0
      && this.mTreeList[0].children) {

      this.mCurrentSelectItem = this.mTreeList[0]
      this.mMessage = this.mTreeList[0].name as string
    }

  }

  build() {
    Column() {
      if (this.mCurrentSelectItem) {

        Text(this.mMessage).maxLines(1)
      }
      Row() {

        //左边的列表
        if (this.mTreeList && this.mTreeList.length > 0) {

          this.getTreeItemLayout(this.mTreeList, true)

        }
        //右侧选中的列表
        if (this.mCurrentSelectItem.children && this.mCurrentSelectItem.children.length > 0) {
          Line().width(0.5).height('100%').backgroundColor("#ff707570")

          // this.getTreeItemLayout(this.currentSelectItem.children, false)


          if (this.mCurrentSelectItem.children) {
            List() {
              ForEach(this.mCurrentSelectItem.children, (item: Tree) => {
                ListItem() {

                  Text(item.name)
                    .width("100%")
                    .height(40)
                    .backgroundColor(false ? "#ff4e79e6" : "#ffedd36f")
                    .maxLines(2)
                    .onClick(() => {

                      this.mMessage += item.name as string
                      this.mMessage += (item.articleList ? item.articleList.length : 0)
                      this.mBindSheet = true
                      this.mArticalTree = item


                    })
                }
              })
            }.layoutWeight(1)
            .height("100%")
            .divider({
              strokeWidth: 2,
              color: "#ff9a8733"

            })
          }
        }


      }.width("100%").layoutWeight(1)

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#007DFF')
    .justifyContent(FlexAlign.Center)
    .bindSheet($$this.mBindSheet, this.getSheetBuilder(), {
      showClose: false,
      height: '70%'
    })
  }

  @Builder
  getSheetBuilder() {
    // 坑点 bindSheet的内容最外层需要用原生组件才可以
    Column() {

      Text(this.mArticalTree.name).maxLines(1).width("100%").textAlign(TextAlign.Center).margin({bottom:10})
      List() {
        ForEach(this.mArticalTree.articleList, (item: Pager) => {
          ListItem() {
            Text(item.title).maxLines(1).width("100%")
              .onClick(()=>{

              //打开对应的资源文章
              router.pushUrl({
                url: "pages/PageArticalDetail",
                params: {
                  linkUrl:item.link

                }
              })

            })

          }
        })


      }.divider({strokeWidth:2,color:"#ff737873"})

    }.width("100%").height("100%")

  }

  aboutToAppear(): void {
    this.getInitData()
  }

  async getInitData() {

    try {

      let result: Array<Tree> = await NetworkApi.getInstance().getTree()

      this.mTreeList = result


      let treeList: Array<Tree> = result.filter(this.myFilter)
      this.mTreeList = treeList


    } catch (error) {
      Logger.info("resultttt", "result==>" + error)
      promptAction.showToast({ message: "请求出错了" })
    }


  }

  /**
   * 过滤有文章的 tree
   * @param item
   * @returns
   */
  myFilter(item: Tree) {
    if (item.children) {
      for (let i = 0; i < item.children.length; i++) {
        let length = item.children[i]?.articleList?.length
        if (length) {

          return length > 0
        }
      }


      return false
    }

    return false
  }
}
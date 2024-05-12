import NetworkApi from '../../networks/NetworkApi';
import { promptAction } from '@kit.ArkUI';
import Logger from '../../utils/Logger';
import { Tree } from '../homepages/Beans';
import { CommonTitle } from '../commons/PageCommonView';

@Component
export struct PageFrameTree {
  @State message: string = 'PageFrameTree';
  @State treeList: Array<Tree> = []
  @State subTreeList: Array<Tree> = []

  @Builder
  getTreeItemLayout(currentList: Array<Tree>) {

    if (currentList) {
      List() {
        ForEach(currentList, (item: Tree) => {
          ListItem() {

            Text(item.name).width("100%").height(40).backgroundColor("#0ff00f").onClick(() => {


              if (item.children && item.children.length > 0) {
                this.subTreeList = []

                setTimeout(()=>{

                  this.subTreeList = item.children as  Array<Tree>

                  promptAction.showToast({ message: "first name=>" + JSON.stringify( this.subTreeList[0].name) })
                },20)

              } else {
                this.subTreeList = []
              }
            })
          }

        })

      }.layoutWeight(1).height("100%")

    }
  }

  build() {
    Column() {
      if (this.treeList && this.treeList.length > 0) {

        Text(this.treeList[0].name)
      }
      Row() {
        if (this.treeList && this.treeList.length > 0) {

          this.getTreeItemLayout(this.treeList)
        }
        if (this.subTreeList && this.subTreeList.length > 0) {
          this.getTreeItemLayout(this.subTreeList)
        }


      }.width("100%").layoutWeight(1)

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#007DFF')
    .justifyContent(FlexAlign.Center)
  }

  aboutToAppear(): void {
    this.getInitData()
  }

  async getInitData() {

    try {

      let result: Array<Tree> = await NetworkApi.getInstance().getTree()
      this.treeList = result

    } catch (error) {
      Logger.info("resultttt", "result==>" + error)
      promptAction.showToast({ message: "请求出错了" })
    }


  }
}
import { FoodItem } from '../models/MeiTuanBeans'

//初始化数据
PersistentStorage.persistProp('cart_list', [])

/**
 *  用于全局缓存 用户点单数据
 */
export class CartStore {
  /**
   * 开发中最好也有相关流程图：
   *  公司使用confluence，代码中写行注释，贴个流程图进去，后续离职了，其他人想看文档，也可以看到对应的逻辑
   * 养成良好习惯吧
   * 相关逻辑流程图 https://www.processon.com/v/664b56e2cfe67e27899ea4f1?cid=664b530ca1817e73519e426e
   * 这个工具没有idea智能呀，文档都无法自动识别，期待后续改进

   * {@link <a href=" https://www.processon.com/v/664b56e2cfe67e27899ea4f1?cid=664b530ca1817e73519e426e">逻辑流程图</a>}
   * @param food
   * @param flag
   */
  static addCut(food: FoodItem, flag: boolean = true) {
    // 1.读一下存储购物车列表
    const list = AppStorage.get<FoodItem[]>('cart_list')!
    // list.findIndex((listItem:FoodItem)=>{
    //    return  listItem.id === food.id
    // })
    // 2.从列表里面查有没有
    const index = list.findIndex((listItem: FoodItem) => listItem.id === food.id)
    if (flag) {
      //   3.1+
      if (index < 0) {
        //   4.1是首次添加
        // food.count//原来是库存的意思
        food.count = 1 //重新赋值，代表的是购物车的数量
        list.unshift(food)
      } else {
        //   4.2添加数量
        list[index].count++
        // 强制让第一层变化一下
        list.splice(index, 1, list[index])
      }
    } else {
      //  3.2 -
      //   默认为是大于0的，因为减到0的时候，我就不让减号出现了
      list[index].count--
      if (list[index].count === 0) {
        list.splice(index, 1)
      } else {
        list.splice(index, 1, list[index])
      }
    }
    // 5.更新一下
    AppStorage.setOrCreate('cart_list', list)
  }
}
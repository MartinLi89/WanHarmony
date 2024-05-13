export default class HttpInfos {
  /**
   *  服务器地址
   */
  static readonly SERVER: string = 'https://www.wanandroid.com';
  /**
   * {
   "data": [
   {
   "desc": "我们支持订阅啦~",
   "id": 30,
   "imagePath": "https://www.wanandroid.com/blogimgs/42da12d8-de56-4439-b40c-eab66c227a4b.png",
   "isVisible": 1,
   "order": 2,
   "title": "我们支持订阅啦~",
   "type": 0,
   "url": "https://www.wanandroid.com/blog/show/3352"
   },
   {
   "desc": "",
   "id": 6,
   "imagePath": "https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png",
   "isVisible": 1,
   "order": 1,
   "title": "我们新增了一个常用导航Tab~",
   "type": 1,
   "url": "https://www.wanandroid.com/navi"
   },
   {
   "desc": "一起来做个App吧",
   "id": 10,
   "imagePath": "https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png",
   "isVisible": 1,
   "order": 1,
   "title": "一起来做个App吧",
   "type": 1,
   "url": "https://www.wanandroid.com/blog/show/2"
   }
   ],
   "errorCode": 0,
   "errorMsg": ""
   }
   */
  static readonly BANNER: string = this.SERVER + "/banner/json"
  static readonly ARTICLE: string = this.SERVER + "/article/list/0/json"
  static readonly TREE: string = this.SERVER + "/tree/json"
  static readonly NAVI: string = this.SERVER + "/navi/json"
  static readonly FRASH_PROJECTS: string = this.SERVER + "/article/listproject/0/json"
  //picture server
  static readonly PictureSERVER: string = 'https://imgapi.cn';
  static readonly PictureGirls: string = this.PictureSERVER + "/cos.php?return=jsonpro"
  // static readonly PictureGirls: string = "https://imgapi.cn/loading.php?return=jsonpro"
  /**
   * 成功code
   */
  static readonly SUCCESS_CODE: number = 200;
  /**
   * 请求超时
   */
  static readonly CONNECT_TIMEOUT: number = 50000;
  static readonly READ_TIMEOUT: number = 50000;
}
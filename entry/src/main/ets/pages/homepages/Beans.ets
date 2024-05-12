/**
 * 通用的请求数据格式
 */
class CommontRequest <T> {
  data: T | null = null
  errorCode: number = -1
  errorMsg: string = "未知"
}

/**
 * 轮播图数据
 */
class BannerBean {
  desc?: string
  id?: number
  imagePath?: string
  isVisible?: number
  order?: number
  title?: string
  type?: number
  url?: string
}

/**
 * 首页文章列表
 */
class HomeArticleList {
  curPage?: number
  datas: Pager[] = []
  offset?: number
  over?: boolean
  pageCount?: number
  size?: number
  total?: number
}


/**
 * 除了文字标题，链接，其他字段都可能为null
 */
class Pager {
  adminAdd?: boolean
  apkLink?: string
  audit?: number
  author?: string
  canEdit?: boolean
  chapterId?: number
  chapterName?: string
  collect?: boolean
  courseId?: number
  desc?: string
  descMd?: string
  envelopePic?: string
  fresh?: boolean
  host?: string
  id?: number
  isAdminAdd?: boolean
  link?: string
  niceDate?: string
  niceShareDate?: string
  origin?: string
  prefix?: string
  projectLink?: string
  publishTime?: number
  realSuperChapterId?: number
  selfVisible?: number
  shareDate?: number
  shareUser?: string
  superChapterId?: number
  superChapterName?: string
  tags?: Tag[]
  title?: string
  type?: number
  userId?: number
  visible?: number
  zan?: number

  public  getDataTime(): string {

    let time: Date
    if (this.publishTime) {

      time = new Date(this.publishTime)
      return time.toDateString()
    }
    time = new Date()
    return time.toString()

  }
}

 class Tree {
  articleList?: Array<Pager>
  author?: string
  children?: Array<Tree>
  courseId?: number
  cover?: string
  desc?: string
  id?: number
  lisense?: string
  lisenseLink?: string
  name?: string
  order?: number
  parentChapterId?: number
  type?: number
  userControlSetTop?: boolean
  visible?: number
}


class Tag {
  tag: string = ""
}

export {
  CommontRequest, BannerBean, Tag, Pager, HomeArticleList,Tree
}
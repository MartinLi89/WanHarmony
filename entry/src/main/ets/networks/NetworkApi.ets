import { http } from '@kit.NetworkKit'
import { BannerBean, CommontRequest, HomeArticleList, Pager } from '../pages/homepages/Beans'
import Logger from '../utils/Logger'
import HttpInfos from './HttpInfos'
import { hilog } from '@kit.PerformanceAnalysisKit'


class NetworkApi {
  private static INSTANCE: NetworkApi

  private constructor() {
  }

  static getInstance(): NetworkApi {
    if (NetworkApi.INSTANCE === undefined) {
      NetworkApi.INSTANCE = new NetworkApi()
    }
    return NetworkApi.INSTANCE

  }

  async getRequest(url: string) {
    if (!url) {

      return
    }

    let request = http.createHttp();
    let options = {
      method: http.RequestMethod.GET,
      header: { 'Content-Type': 'application/json' },
      readTimeout: HttpInfos.READ_TIMEOUT,
      connectTimeout: HttpInfos.CONNECT_TIMEOUT
    } as http.HttpRequestOptions;
    let urlss: string = HttpInfos.SERVER + url

    await request.request(urlss, options, (error, result) => {

      Logger.info("resultttt", "result==>" + result ? JSON.stringify(result.result ? result.result : "{}") : "")
      Logger.info("resultttt", "error==>" + error ? JSON.stringify(error) : "")


    })
  }

  async getBanner() {


    return new Promise<BannerBean[]>((resolve, reject) => {

      let request = http.createHttp();
      let options = {
        method: http.RequestMethod.GET,
        header: { 'Content-Type': 'application/json' },
        readTimeout: HttpInfos.READ_TIMEOUT,
        connectTimeout: HttpInfos.CONNECT_TIMEOUT
      } as http.HttpRequestOptions;
      let urlss: string = HttpInfos.BANNER

      request.request(urlss, options, (error, response) => {
        if (response) {


          let resultBean: CommontRequest<BannerBean[]> = JSON.parse(response.result as string)


          resolve(resultBean.data as BannerBean[])
        }
        if (error) {
          reject(error)
        }

      })

    })
  }

  async getArticle() {


    return new Promise<Pager[]>((resolve, reject) => {

      let request = http.createHttp();
      let options = {
        method: http.RequestMethod.GET,
        header: { 'Content-Type': 'application/json' },
        readTimeout: HttpInfos.READ_TIMEOUT,
        connectTimeout: HttpInfos.CONNECT_TIMEOUT
      } as http.HttpRequestOptions;
      let urlss: string = HttpInfos.article

      request.request(urlss, options, (error, response) => {
        if (response) {

          console.log("lsyyy response 0002result header ==>" + JSON.stringify(response.header))

          let resultBean: CommontRequest<HomeArticleList> = JSON.parse((response.result as string))

          let result: Pager[] = filterBean(resultBean)
          resolve(result)
        }
        if (error) {
          reject(error)
        }

      })
    })
  }
}


export default NetworkApi

function filterBean(resultBean: CommontRequest<HomeArticleList>): Pager[] {
  let homeArticles: HomeArticleList = resultBean.data as HomeArticleList

  // Logger.info("resultttt", "filterBean result==>" )
  // Logger.info("resultttt", "filterBean result==>" + JSON.stringify(resultBean))


  hilog.info(0xFF00, "lsyyy", '%{public}s', JSON.stringify(resultBean));

  let papers: Pager[] = homeArticles.datas

  // let papers: Pager[] =article.datas
  // let title: string = papers[0].title as string
  Logger.info("resultttt", "filterBean result==>" + papers[0].title)

  return papers
}

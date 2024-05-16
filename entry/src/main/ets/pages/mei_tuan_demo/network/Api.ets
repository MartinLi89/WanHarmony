import { http } from '@kit.NetworkKit'
import { Category } from '../models/MeiTuanBeans'


/**
 * 养成习惯，获取点菜数据 PageMeiTuanDemo.ets使用
 */
export const getData = async () => {
    const req = http.createHttp()
    const res = await req.request('https://zhousg.atomgit.net/harmonyos-next/takeaway.json')
    return JSON.parse(res.result as string) as Category[]
}
import cryptoFramework from "@ohos.security.cryptoFramework"
import { buffer } from '@kit.ArkTS'

/**
 * 官方文档
 * https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/huks-overview-0000001496554665-V2
 */
export default class Md5Utils {
  private static INSTANCE: Md5Utils

  private constructor() {
  }

  static getInstance(): Md5Utils {
    if (Md5Utils.INSTANCE === undefined) {
      Md5Utils.INSTANCE = new Md5Utils()
    }
    return Md5Utils.INSTANCE

  }

  // 明文 计算MD5特征值
  getMd5(source: string): Promise<string> {
    return new Promise<string>((resolve, reject) => {
      let mD5Reader = cryptoFramework.createMd("MD5");

      //如果 文件很大，比如是一个10G的字节流，可以多次使用 mD5Reader.update
      // mD5Reader.update({data: this.stringToUint8Array(分段1)})
      // mD5Reader.update({data: this.stringToUint8Array(分段2)})
      // mD5Reader.update({data: this.stringToUint8Array(分段3)})
      // mD5Reader.update({data: this.stringToUint8Array(分段4)})


      let ready = mD5Reader.update({
        data: this.stringToUint8Array(source)
      })



      ready.then(() => {
        //DataBlob
        let PromiseMdDigest = mD5Reader.digest()
        return PromiseMdDigest
      }).then((mdOutput) => { //DataBlob
        let mdtString = this.uint8ArrayToHexString(mdOutput.data);
        resolve(mdtString)
      })
        // .catch(() => {
        //   reject()
        // })
    })


  }

  // turn string into uint8Arr
  stringToUint8Array(str: string) {

    let arr: number[] = [];
    for (let i = 0, j = str.length; i < j; ++i) {
      arr.push(str.charCodeAt(i));
    }
    let tmpUint8Array = new Uint8Array(arr);
    return tmpUint8Array;
  }

  /**
   * uint8Array 转换为 hex字符串
   * @param uint8Array
   * @returns
   */
  uint8ArrayToHexString(uint8Array: Uint8Array) {
    // 使用Array.from和toString转换每个字节为16进制并连接
    return Array.from(uint8Array).map(byte => byte.toString(16).padStart(2, '0')).join('');
  }
}




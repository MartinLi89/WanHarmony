export default class CommonValues {
  static readonly LOCAL_PAGE: string = "local_page1"
}




class TextTS {
  a: string = "1"
  b: string = "2"
  c: string = "3"
}

//1 Partial <Type>新定义 一个类型，将所有属性变为可选的类
type PartialTextTs = Partial<TextTS>
let test2: TextTS = {
  //报错 ,说明属性必填
  a:  "1",
  b:  "2",
  c:  "3"
}
let test1: PartialTextTs = {
  //正常，说明属性可选
}
//1.1 Required
type Person =  Required<TextTS>
let test3: Person = {
  a : "1",
  b : "2",
  c : "3"

}


//2Readonly <Type> 新定义 一个类型， 将所有属性变为只读的类
type ReadonlyTextTs = Readonly<TextTS>
let testReadonly: ReadonlyTextTs = {
  a: "1",
  b: "2",
  c: "3"
}
let test12: TextTS = {
  a: "1",
  b: "2",
  c: "3"
}
// testReadonly.a = "f" //报错，说明只读
test12.a = "f"

//3
// Pick<Type,Keys>  新定义 一个类型 从Type类型中，选择需要的keys，构成新的类型

interface TextInterface {
  a: string
  b: string
  c: string

}

//鸿蒙中不可用，会报错
// type PickObj =  Pick<TextInterface, 'a'|'b'>
//这样写不报错
interface PickObj extends Pick<TextInterface, 'a' | 'b'> {}
let test111 :PickObj={a :"1",b:"1"}


//4  新定义 一个类型属性键为Keys，属性类型为Type，构成新的类型
type MyRecordObj = Record<"aaaa", number>
let value: MyRecordObj = {
  "aaaa": 1

}

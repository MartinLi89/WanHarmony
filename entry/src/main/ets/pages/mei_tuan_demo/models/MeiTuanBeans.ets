// 只需要当类型使用，不需要去new(不需要使用observed)
export class Category {
  tag: string = ''
  name: string = ''
  foods: FoodItem[] = []
}

export class FoodItem {
  id: number = 0
  name: string = ''
  like_ratio_desc: string = ''
  month_saled: number = 0
  unit: string = ''
  food_tag_list: string[] = []
  price: number = 0
  picture: ResourceStr = ''
  description: string = ''
  tag: string = ''
  count: number = 0
}
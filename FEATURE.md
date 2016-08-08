# Feature

* lamda
  
  支持用户自定义mark的来源方式，使用lua的loadstring实现
  
* 加载配置

  支持多种方式加载配置(json格式)，local、redis、http、etcd，同时允许一种生效。
  
* 优化规则查找方式

  首先需按优先级来分别查找不同类型的规则，其次，每种规则使用mark当做key来hash存储

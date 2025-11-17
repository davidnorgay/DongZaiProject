void main(){
  var a=10;//var是动态类型，可赋值任意类型,但不可任意变换类型
  const pi=3.14;
  final time=DateTime.now();
  String content="我要在${time}输出$a";
  int b=20;
  num c=1.5;
  double d=1.5;
  double e=b.toDouble();
  int f=d.toInt();//结果为1
  bool isTrue=true;

  dynamic g;//dynamic是动态类型，可赋值任意类型,可任意变换类型
  g=10;
  g='hello';
  g=true;
  g=[];
  g={};

  List student=['张三','李四','王五'];
  student.add('赵六');
  student.addAll(['王二','麻子']);
  student.remove('王二');
  student.removeLast();
  student.removeRange(0, 2);//删掉0,1索引项
  print(student);
  
  //List.forEach(() {});
  student.forEach((item) {
    print(item);
  });

  //List.every(() {});判断list中是否所有元素都满足条件
  print(student.every((item) {
    return item.toString().startsWith('张');//判断是否每一个元素都以“张”开头（先把元素类型转换为String）
  }));

  //List.where(() {});筛选符合条件的元素并返回一个类似List的对象，可通过toList()方法转换为List
  print(student.where((item) {
    return item.toString().startsWith('王');//筛选以“王”开头的元素
  }).toList());

  print(student.length);
  print(student.last);
  print(student.first);
  print(student.isEmpty);

  Map dict={'name':'张三','age':18};

  dict.forEach((key,value) {
    print('key=$key,value=$value');
  });

  dict.addAll({'height':175,'weight':70});

  print(dict.containsKey('name'));//判断是否包含键为‘name’的项

  dict.remove('name');//删除键为‘name’的项

  dict.clear();//清空

  String? str;
  if(str==null){//判断字符串是否为空
    print('str is null');}

  String? str2=null;//加上?表示str2可能为空
  str2?.startsWith('a');//客观判断str2是否为空，为空则不执行后面的语句
  str2='hello';
  str2!.startsWith('a');//忽视报错，主观认为str2非空
  str2=null;
  String str3=str2??'default';//如果str2不为空，则返回str2，否则返回‘default’
  print(str3);
}

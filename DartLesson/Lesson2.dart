void main(){

  double a=10.5;
  int b=a~/2;//取整

  getValue(){//未声明返回类型函数，默认返回dynamic类型
    return 10;
  }

  b=getValue();
  print(a);

  String combine(String a,[String? b,String? c]){//可选参数，可选参数必须放在最后
    return a+(b??'')+(c??'');//??是三目运算符，当b为null时，返回空字符串
  }
  print(combine('hello'));

  String combine2(String name,{int? age=20,String? sex}){//命名参数，命名参数必须放在最后
    return 'name=$name,age=$age,sex=$sex';
  }
  print(combine2('张三',age:18,sex:'男'));

    Function test=(){//匿名函数变量test
      print("test");
    };

    void Ontest(Function test){//函数类型作为参数
      test();
    }

    Ontest(test);

    int add(int a,int b)=>a+b;//箭头函数,当函数体只有一行时，可以省略{}和return

    person p=person(name:'张三',age:18,sex:'男');//构造函数，可选参数必须放在最后
    person  p2=person.init(name:'李四',age:19,sex:'女');//命名构造函数，可选参数必须放在最后

    p.study();

    student p3=student(name:'王五',age:20,sex:'男');//子类构造函数，可选参数必须放在最后，必须使用super调用父类构造函数
    p3.study();

    List<int> list=[1,2,3,4,5];//List类型,List类型是一个泛型，尖括号中指定元素类型

    Future f=Future(() {
      return "hello";//Future是一个异步操作，返回一个Future对象，当异步操作完成时，会调用then方法
    });
    f.then((value) {
      print(value);
    });

    Future f2=Future(() {
      throw Exception();//Future是一个异步操作，返回一个Future对象，当异步操作完成时，会调用then方法
    });
    f.catchError((error) {
      print("Erroe!");
    });

}
  T getValue<T>(T value){
    return value;
  }
class person{
      String? name="";
      int? age=0;
      String? sex="";
      String? _password="";//私有属性，只能在类内部访问

      person({String? name,int? age,String? sex}){//构造函数，可选参数必须放在最后
        this.name=name;
        this.age=age;
        this.sex=sex;
      }
      person.init({String? name,int? age,String? sex}){//命名构造函数，可选参数必须放在最后
        this.name=name;
        this.age=age;
        this.sex=sex;
      }
      person.myInit({String? name,int? age,String? sex});
      
      void _setPassword(String password){//私有方法，只能在类内部访问
        this._password=password;
      }

      void study(){
        print("a");
      }

      void _mystudy(){//私有方法，只能在类内部访问
        print("c");
      }
}
class student extends person{//继承，子类可以访问父类的公有属性和方法，不能访问私有属性和方法，但是可以通过super关键字访问父类的公有属性和方法
  student({String? name,int? age,String? sex}):super(name:name,age:age,sex:sex);//子类构造函数，可选参数必须放在最后，必须使用super调用父类构造函数
  @override//重写父类方法
  void study(){
    super.study();//调用父类study方法
    super._mystudy();//调用父类_mystudy方法
    print("b");
  }
}

mixin Base{//混入，混入可以在多个类中使用，不能被实例化，只能被继承
  void sing(String? name){
    print("我是$name");
  }
}
class singer with Base{//混入，混入可以在多个类中使用，不能被实例化，只能被继承
  int? age;
  singer({int? age}):age=age;
}



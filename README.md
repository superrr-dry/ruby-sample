# README

## 参考URL
* アプリ立ち上げ(コピペだとapiモードになるため注意)<br>
　https://zenn.dev/toono_f/scraps/e7346c6e90c35b

* todoアプリ作成<br>
  https://elekibear.com/20221110_01#google_vignette

## Link
- [README](#readme)
  - [参考URL](#参考url)
  - [Link](#link)
    - [SOLID原則](#solid原則)
      - [単一責任原則](#単一責任原則)
      - [開放閉鎖原則](#開放閉鎖原則)
      - [リスコフの置換原則](#リスコフの置換原則)
      - [インターフェイス分離原則 (Interface Segregation Principle)](#インターフェイス分離原則-interface-segregation-principle)
      - [依存性逆転原則](#依存性逆転原則)
    - [GoF](#gof)
      - [Singleton](#singleton)
      - [FactoryMethod](#factorymethod)
      - [Decorator](#decorator)
      - [Observer](#observer)

### SOLID原則

#### 単一責任原則
railsのMVCがこれを支持してる

#### 開放閉鎖原則
Decorator パターンや Concernsを使うのがいいかも
```ruby
# app/decorators/user_decorator.rb
class UserDecorator
  def initialize(user)
    @user = user
  end

  def full_name
    "#{@user.first_name} #{@user.last_name}"
  end
end
```

#### リスコフの置換原則
親クラスをオーバーライドすればいける
```ruby
class Animal
  def make_sound
    "Some generic animal sound"
  end
end

class Dog < Animal
  def make_sound
    "Woof!"
  end
end

class Cat < Animal
  def make_sound
    "Meow!"
  end
end
```
#### インターフェイス分離原則 (Interface Segregation Principle)
Rubyでは明示的なインターフェースが無いため、mix-in（モジュールの使用）でこの原則を適用できる。

```ruby
module Walkable
  def walk
    puts "I can walk"
  end
end

module Swimmable
  def swim
    puts "I can swim"
  end
end

class Human
  include Walkable
  include Swimmable
end
```

もしくは、NotImplementedErrorを使うのもあり。<br>
下記参考URL<br>
https://qiita.com/developer-kikikaikai/items/b1e2bd1c2bbc223de534

#### 依存性逆転原則
呼び出しもと
```ruby
# app/services/payment_processor.rb
class PaymentProcessor
  def initialize(payment_gateway)
    @payment_gateway = payment_gateway
  end

  def process(amount)
    @payment_gateway.process_payment(amount)
  end
end

# app/services/stripe_payment_gateway.rb
class StripePaymentGateway
  def process_payment(amount)
    # Stripeでの支払い処理
  end
end

# app/services/paypal_payment_gateway.rb
class PaypalPaymentGateway
  def process_payment(amount)
    # PayPalでの支払い処理
  end
end

```
呼び出し先
```ruby
# StripePaymentGatewayのインスタンスを作成
stripe_gateway = StripePaymentGateway.new

# PaymentProcessorのインスタンスを作成し、StripePaymentGatewayのインスタンスを渡す
processor = PaymentProcessor.new(stripe_gateway)

# PaymentProcessorのprocessメソッドを呼び出す
# 内部でStripePaymentGatewayのprocess_paymentメソッドが呼ばれる
processor.process(100)
```

### GoF
有名どころだけピックアップ<br>
気分が乗ったら他も調べる

#### Singleton
rubyにSingletonのモジュールがある<br>
・module<br>
https://docs.ruby-lang.org/ja/latest/class/Singleton.html
<br>・使い方<br>
https://qiita.com/YumaInaura/items/b26b4fe589405948da4b


#### FactoryMethod
ActiveRecordの#createメソッドや#newメソッドが該当する
```ruby
class User < ApplicationRecord
  def self.create_guest
    create(name: "Guest")
  end
end
```

#### Decorator
railsにdelegateメソッドがある<br>
https://railsguides.jp/active_support_core_extensions.html#delegate

#### Observer
Action Cableを使うのがいいっぽい<br>
https://railsguides.jp/action_cable_overview.html
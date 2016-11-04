<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [PHP](#php)
  - [書き途中](#%E6%9B%B8%E3%81%8D%E9%80%94%E4%B8%AD)
  - [注意事項](#%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A0%85)
  - [Validation List](#validation-list)
  - [Validation Source](#validation-source)
    - [Laravel](#laravel)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

PHP framework
===

## 書き途中

LaravelのカスタムValidationの言及中。来週更にblash upするけど、今週はここまでという意味を込めてpushする。

## 注意事項

```
フレームワークの用意したクラスを直接呼ぶのは原則NGである。
理由はシンプルで直接呼ぶとclass variable, functionを修正したい際にフレームワーク自体に手を加える必要性が発生し、
フレームワークのバージョンアップ作業時に大きな負債となる。
そもそもcomposerでフレームワークを管理している以上フレームワーク自体に手を入れる事はできない。
                                                                                         KazuakiM
```

## Validation List

|         | [Laravel](http://laravel.jp/)                                                            | [FuelPHP](http://fuelphp.jp/)                                               | [CodeIgniter](http://codeigniter.jp/)                                                    |
| :------ | :--------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------- |
| Version | [4.2](http://readouble.com/laravel/4/2/0/ja/quick.html)                                  | [1.8](http://fuelphp.jp/docs/1.8/)                                          | [2.0.3](http://codeigniter.jp/user_guide_ja/index.html)                                  |
| List    | [List](http://readouble.com/laravel/4/2/0/ja/validation.html#available-validation-rules) | [List](http://fuelphp.jp/docs/1.8/classes/validation/validation.html#rules) | [List](http://codeigniter.jp/user_guide_ja/libraries/form_validation.html#rulereference) |

## Validation Source

### [Laravel](http://laravel.jp/)
* Base class file
> ```bash
> vendor/laravel/framework/src/Illuminate/Validation/Validator.php
> ```

* [Validatorクラスを拡張する](http://readouble.com/laravel/4/2/0/ja/validation.html#custom-validation-rules)
> [laravel4 綺麗なcontrollerとcustomValidate - Qiita](http://qiita.com/ytake/items/f45c9a6e17daa12828f2)  
> [laravel4 CustomValidator - Qiita](http://qiita.com/MasatoYoshioka@github/items/64784c986e9e54b0d404)  
> I don't execute there.
>
> Add extensions directory
> ```bash
> $ cd /laravel/project/path
> $ mkdir -p app/extensions/validates/rules
> ```
> composer.json
> ```json
> {
>     "autoload": {
>         "psr-4": {
>             "Application\\": "app"
>         }
>     },
>     "autoload-dev": {
>         "psr-4": {
>             "__Test\\": "app/tests"
>         }
>     }
> }
> ```
> app/extensions/validates/rules/User.php
> ```php
> <?php
> namespace Extensions\Validates\Rules;
> trait User
> {
>     const USERNAME = 'アカウント名';
>     const PASSWORD = 'パスワード';
>     const EMAAIL   = 'メールアドレス';
>     public $userValidateRules = [
>         'username' => 'required',
>         'password' => 'required',
>         'email'    => 'required|email'
>     ];
>     public $userValidateMessages = [
>         'username.required' => self::USERNAME.'を入力してください',
>         'password.required' => self::PASSWORD.'を入力してください',
>         'email.required'    => self::EMAAIL.  'を入力してください',
>         'email.email'       => self::EMAAIL.  'を正しく入力してください'
>     ];
> }
> ```
> app/controller/ExampleController.php
> ```php
> <?php
> class UserController extends \BaseController
> {
>     const _CREATE_USER_KEY = '_create_user:';
>     use Extensions\Validate\Rule\User;
>     ...
>     ...
> }
> ```
> app/extensions/validates/CustomValidator.php
> ```php
> <?php
> namespace Extensions\Validations;
> use Illuminate\Validation\Validator;
> class CustomValidator extends Validator
> {
>     public function validateFoo($attribute, $value, $parameters) //{{{
>     {
>         return $value == 'foo';
>     } //}}}
> }
> ```
> app/extensions/validate/CustomServiceProvider.php
> ```php
> <?php
> namespace Extensions\Validations;
> use Illuminate\Support\ServiceProvider;
> class CustomServiceProvider extends ServiceProvider
> {
>     public function register() {}
>     public function boot() //{{{
>     {
>         $this->app->validator->resolver(function( $translator, $data, $rules, $messages = []) {
>             return new \Extensions\Validates\CustomValidator($translator, $data, $rules, $messages);
>         });
>     } //}}}
> }
> ```

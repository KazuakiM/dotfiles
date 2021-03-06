<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [PHP de facto standard](#php-de-facto-standard)
  - [php.ini ディレクティブ](#phpini-%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%86%E3%82%A3%E3%83%96)
  - [Exception](#exception)
  - [関数の引数](#%E9%96%A2%E6%95%B0%E3%81%AE%E5%BC%95%E6%95%B0)
  - [Enum](#enum)
  - [assert()](#assert)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

PHP de facto standard
===

## [php.ini ディレクティブ](http://php.net/manual/ja/ini.php)

[コア php.ini ディレクティブに関する説明](http://php.net/manual/ja/ini.core.php)

## [Exception](http://php.net/manual/ja/spl.exceptions.php)

|     |     |     |     |                                                                                                                                   |note                                                                                                                                                                                                                                                                        |
| :-- | :-- | :-- | :-- | :-------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|interface [Throwable](http://php.net/manual/ja/class.throwable.php)                                                                                    |||||                                                                                                                                                                                                                                                                            |
|     | [Error](http://php.net/manual/ja/class.error.php)                                                                                                ||||PHP のすべての内部エラーの基底クラスです。                                                                                                                                                                                                                                  |
|     |     | [ArithmeticError](http://php.net/manual/ja/class.arithmeticerror.php)                                                                       |||数学的な操作でエラーが発生した場合にスローされます。                                                                                                                                                                                                                        |
|     |     |     | [DivisionByZeroError](http://php.net/manual/ja/class.divisionbyzeroerror.php)                                                          ||数値をゼロで割ろうとした場合にスローされます。                                                                                                                                                                                                                              |
|     |     | [AssertionError](http://php.net/manual/ja/class.assertionerror.php)                                                                         |||[assert()](http://php.net/manual/ja/function.assert.php)によるアサーションが失敗したときにスローされます。                                                                                                                                                                  |
|     |     | [ParseError](http://php.net/manual/ja/class.parseerror.php)                                                                                 |||[eval()](http://php.net/manual/ja/function.eval.php)を呼んだときなどの PHP コードのパースに失敗した場合にスローされます。                                                                                                                                                   |
|     |     | [TypeError](http://php.net/manual/ja/class.typeerror.php)                                                                                   |||以下の三つの場合です。 まず、関数に渡された引数の型が、関数の宣言時に指定された型と一致しない場合。 次に、関数の戻り値の型が、関数の宣言時に指定された型と一致しない場合。 そして、PHP 組み込みの関数に渡す引数の数を間違えた場合 (これは、strict モードの場合に限ります)。 |
|     | [Exception](http://php.net/manual/ja/class.exception.php)                                                                                        ||||すべてのユーザー例外の基底クラス                                                                                                                                                                                                                                            |
|     |     | [ErrorException](http://php.net/manual/ja/class.errorexception.php)                                                                         |||エラー例外です。                                                                                                                                                                                                                                                            |
|     |     | [LogicException](http://php.net/manual/ja/class.logicexception.php) (extends [Exception](http://php.net/manual/ja/class.exception.php))     |||プログラムのロジック内でのエラーを表す例外です。 この類の例外が出た場合は、自分が書いたコードを修正すべきです。                                                                                                                                                             |
|     |     |     | [BadFunctionCallException](http://php.net/manual/ja/class.badfunctioncallexception.php)                                                ||未定義の関数をコールバックが参照したり、引数を指定しなかったりした場合にスローされる例外です。                                                                                                                                                                              |
|     |     |     |     | [BadMethodCallException](http://php.net/manual/ja/class.badmethodcallexception.php)                                               |未定義のメソッドをコールバックが参照したり、引数を指定しなかったりした場合にスローされる例外です。                                                                                                                                                                          |
|     |     |     | [DomainException](http://php.net/manual/ja/class.domainexception.php)                                                                  ||定義したデータドメインに値が従わないときにスローされる例外です。                                                                                                                                                                                                            |
|     |     |     | [InvalidArgumentException](http://php.net/manual/ja/class.invalidargumentexception.php)                                                ||引数の型が期待する型と一致しなかった場合にスローされる例外です。                                                                                                                                                                                                            |
|     |     |     | [LengthException](http://php.net/manual/ja/class.lengthexception.php)                                                                  ||長さが無効な場合にスローされる例外です。                                                                                                                                                                                                                                    |
|     |     |     | [OutOfRangeException](http://php.net/manual/ja/class.outofrangeexception.php)                                                          ||無効なインデックスを要求した場合にスローされる例外です。 これは、コンパイル時に検出しなければなりません。                                                                                                                                                                   |
|     |     | [RuntimeException](http://php.net/manual/ja/class.runtimeexception.php) (extends [Exception](http://php.net/manual/ja/class.exception.php)) |||実行時にだけ発生するようなエラーの際にスローされます。                                                                                                                                                                                                                      |
|     |     |     | [OutOfBoundsException](http://php.net/manual/ja/class.outofboundsexception.php)                                                        ||値が有効なキーでなかった場合にスローされる例外です。 これは、コンパイル時には検出できないエラーです。                                                                                                                                                                       |
|     |     |     | [OverflowException](http://php.net/manual/ja/class.overflowexception.php)                                                              ||いっぱいになっているコンテナに要素を追加した場合にスローされる例外です。                                                                                                                                                                                                    |
|     |     |     | [RangeException](http://php.net/manual/ja/class.rangeexception.php)                                                                    ||プログラムの実行時に範囲エラーが発生したことを示すときにスローされる例外です。                                                                                                                                                                                              |
|     |     |     | [UnderflowException](http://php.net/manual/ja/class.underflowexception.php)                                                            ||空のコンテナ上で無効な操作 (要素の削除など) を試みたときにスローされる例外です。                                                                                                                                                                                            |
|     |     |     | [UnexpectedValueException](http://php.net/manual/ja/class.unexpectedvalueexception.php)                                                ||いくつかの値のセットに一致しない値であった際にスローされる例外です。 これが発生する例としては、ある関数が別の関数をコールしていて、 その関数の返り値が特定の型や値である (そして計算やバッファ関連のエラーがない) ことを想定している場合があります。                        |

## [関数の引数](http://php.net/manual/ja/functions.arguments.php)

タイプヒンティング(・∀・)ｲｲ!!

## Enum

ENUM(列挙型)を導入し、引数にENUM型で宣言する事で制御する。  
そうする事でコード内でin_arrayをする必要がなくなる。

* [PHP7で堅牢なコードを書く - 例外処理、表明プログラミング、契約による設計 / PHP Conference 2016 // Speaker Deck](https://speakerdeck.com/twada/php-conference-2016) [[PDF](https://raw.githubusercontent.com/KazuakiM/dotfiles/beebaa064db0f7c328de3d3b92cc8a9e3f43d3c0/.vim/memolist.vim/phpcon2016-twada-php7-reliable-programming.pdf)]
* [PHPで列挙型(enum)を作る - Qiita](http://qiita.com/Hiraku/items/71e385b56dcaa37629fe)

## [assert()](http://php.net/manual/ja/function.assert.php)

[zend.assertions](http://php.net/manual/ja/ini.core.php#ini.zend.assertions)を本番環境と開発環境で切り替える必要がある。  
[assert()](http://php.net/manual/ja/function.assert.php)は設定されていて当然でしょ系のチェックを行う。重要な事は本番環境では本処理が実行されない事を強く意識する事。

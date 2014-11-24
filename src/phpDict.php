<?php
$outputFile = getenv('HOME').'/.vim/dict/php.dict';

$keywords = array(
    'if',       'else',     'elseif',       'endif',        'while',     'endwhile',   'do',       'as',         'for', 'endfor', 'foreach', 'endforeach',
    'break',    'continue', 'switch',       'endswitch',    'case',      'default',    'declare',  'enddeclare',
    'try',      'catch',    'return',       'exit',         'const',     'class',      'function',
    'require',  'include',  'require_once', 'include_once',
    'abstract', 'final',    'interface',    'private',      'protected', 'public',     'static',
    '__LINE__', '__FILE__', '__DIR__',      '__FUNCTION__', '__CLASS__', '__METHOD__', '__NAMESPACE__',);
$functions  = function_exists( 'get_defined_functions'   ) ? get_defined_functions()   : array();
$constants  = function_exists( 'get_defined_constants'   ) ? get_defined_constants()   : array();
$interfaces = function_exists( 'get_declared_interfaces' ) ? get_declared_interfaces() : array();
$classes    = function_exists( 'get_declared_classes'    ) ? get_declared_classes()    : array();

$arrays = array_unique(array_merge(
    $keywords,
    $functions['internal'],
//  array_keys( $constants ),   // 定数を補完したい場合はこの行を有効にする
    $interfaces,
    $classes));
sort($arrays);

file_put_contents($outputFile, implode("\n", $arrays),LOCK_EX);


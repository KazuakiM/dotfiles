<?php
/*--------------------------------
 * Unicode check Batch
 *
 * @author  kazuakiM
 * @referer http://ash.jp/code/unitbl1.htm
 *------------------------------*/
    if (count($argv) !== 2) {
        $echo = <<<EOL
\tUnicode check Batch

param1:
\tlist:\tUnicode List
\tnumber:\tnumber check

EOL;
        echo($echo);
        exit(0);
    }

    $unicodeCheck = new UnicodeCheck('cui');
    switch ($argv[1]) {
    case 'list':
        $unicodeCheck->getUnicodeList();
        break;
    case 'number':
        $unicodeCheck->getUnicodeNumeric();
        break;
    default:
        break;
    }

/**
 * UnicodeCheck class
 */
class unicodeCheck //{{{
{
    //Class variable {{{
    private static $_pattern = [
        'hiragana' => '/\A[\x{3041}-\x{3096}\x{309d}-\x{309f}]+\z/u',
        'katakana' => '/\A[\x{30a1}-\x{30fa}\x{31f0}-\x{31ff}]+\z/u',];
    private $_mode;
    //}}}

    public function __construct($mode) //{{{
    {
        $this->_mode = $mode;
    } //}}}

    public function getUnicodeList() //{{{
    {
        echo("Unicode,Subject,Numeric,Hiragana\n");
        foreach (range(0x0000, 0xffff) as $point) {
            $subject = mb_convert_encoding("&#{$point};", 'UTF-8', 'HTML-ENTITIES');
            $echo    = 'U+'.dechex($point).",{$subject}"
                .",".$this->pregIsNumeric($subject)
                .','.$this->pregMatch('hiragana', $subject)
                .','.$this->pregMatch('katakana', $subject)."\n";
            echo($echo);
        }
    } //}}}

    public function pregIsNumeric($subject) //{{{
    {
        $result = 'NG';
        if (is_numeric($subject)) {
            $result = 'OK';
        }

        return $result;
    } //}}}

    public function pregMatch($mode, $subject) //{{{
    {
        $result = 'NG';
        if (preg_match(self::$_pattern[$mode], $subject)) {
            $result = 'OK';
        }

        return $result;
    } //}}}

    public function getUnicodeNumeric() //{{{
    {
        $echo = <<<EOL
|
|\tNUMBER(is_numeric)
------------------------------------------------------------------------------------------
Subject\tType\tResult

EOL;
        echo($echo);
        $isNumericArray = [
            1,   -1,   0,    1.1,
            '1', '-1', '0',  '1.1',
            'a', "'1", "1'", null, ];
        foreach ($isNumericArray as $subjectRow) {
            echo("{$subjectRow}\t".gettype($subjectRow)."\t".$this->pregIsNumeric($subjectRow)."\n");
        }
    } //}}}
} //}}}

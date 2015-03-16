<?php
/*--------------------------------
 * Unicode check Batch
 *
 * @author  kazuakiM
 * @referer http://ash.jp/code/unitbl1.htm
 * @referer http://tama-san.com/Unicodeで「漢字」の正規表現/
 *------------------------------*/
    ini_set('memory_limit', '512M');

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
    private $_pattern;
    private $_mode;
    //}}}

    public function __construct($mode) //{{{
    {
        $this->_mode    = $mode;
        //JP: Hiragana + Katakana + Kanji
        $this->_pattern = [
            'hiragana' => '/\A[\x{3040}-\x{3096}\x{309d}-\x{309f}]+\z/u',
            'katakana' => '/\A[\x{30a0}-\x{30ff}\x{31f0}-\x{31ff}]+\z/u',
            'kanji'    => '/\A[\x{3005}\x{3007}\x{303B}\x{3400}-\x{9fff}\x{f900}-\x{faff}\x{20000}-\x{2ffff}]+\z/u',
            'jp'       =>
                '/\A[\x{3005}\x{3007}\x{303B}\x{3040}-\x{3096}\x{30a0}-\x{30ff}\x{309d}-\x{309f}\x{31f0}-\x{31ff}\x{3400}-\x{9fff}\x{f900}-\x{faff}'.
                '\x{20000}-\x{2ffff}]+\z/u'];
    } //}}}

    public function getUnicodeList() //{{{
    {
        echo("Unicode,Subject,Numeric,Hiragana,Katakana,Kanji,JP\n");
        foreach (range(0x0000, 0x30000) as $point) {
            $subject = mb_convert_encoding("&#{$point};", 'UTF-8', 'HTML-ENTITIES');
            echo('U+'.dechex($point).",{$subject}"
                .",".$this->pregIsNumeric($subject)
                .','.$this->pregMatch('hiragana', $subject)
                .','.$this->pregMatch('katakana', $subject)
                .','.$this->pregMatch('kanji',    $subject)
                .','.$this->pregMatch('jp',       $subject)
                ."\n");
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
        if (preg_match($this->_pattern[$mode], $subject)) {
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

<?php
/*--------------------------------
 * Unicode check Batch
 *
 * @author  kazuakiM
 * @referer http://ash.jp/code/unitbl1.htm
 *------------------------------*/
    if(count($argv) !== 2) {
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
class UnicodeCheck //{{{
{
    //Class variable {{{
    private static $_pattern = [
        'hiragana' => '/\A[\x{3041}-\x{3096}\x{309D}-\x{309F}]+\z/u'];
    private $_mode;
    //}}}
    public function __construct($mode) //{{{
    {
        $this->_mode = $mode;
    } //}}}
    public function getUnicodeList() //{{{
    {
        foreach (range(0x3040, 0x309F) as $point) {
            $subject = mb_convert_encoding("&#{$point};", 'UTF-8', 'HTML-ENTITIES');

            echo('U+'.dechex($point).",{$subject}");
            $this->pregIsNumeric($subject);
            echo(",\n");
        }
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
            echo("{$subjectRow}\t".gettype($subjectRow)."\t");
            $this->pregIsNumeric($subjectRow);
            echo("\n");
        }
    } //}}}
    public function pregIsNumeric($subject) //{{{
    {
        $result = 'fail';
        if (is_numeric($subject)) {
            $result = 'success';
        }
        $this->output($result);
    } //}}}
    public function pregMatch($pattern, $subject) //{{{
    {
        $result = 'fail';
        if (preg_match(self::$_pattern[$pattern], $subject)) {
            $result = 'success';
        }
        echo("{$subject}\t".gettype($subject)."\t");
        $this->output($result);
    } //}}}
    public function output($result) //{{{
    {
        switch ($this->_mode) {
        case 'cui':
            switch ($result) {
            case 'success':
                echo('OK');
                break;
            default:
                echo('NG');
                break;
            }
            break;
        default:
            break;
        }
    } //}}}
} //}}}

<?php
/*--------------------------------
 * Unicode check Batch
 *
 * @author  kazuakiM
 * @referer http://ash.jp/code/unitbl1.htm
 *------------------------------*/
// NUMBER {{{
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
    'a', "'1", "1'", null];
foreach ($isNumericArray as $subjectRow) {
    UnicodeCheck::pregIsNumeric($subjectRow);
}
//}}}
// ひらがな {{{
$echo = <<<EOL
|
|\tひらがな
------------------------------------------------------------------------------------------
Subject\tType\tResult

EOL;
echo($echo);
$patternArray = array();

//}}}
class unicodeCheck //{{{
{
    //Class variable {{{
    private static $_result = [
        'success' => ['color' => 32],
        'fail'    => ['color' => 31],];
    //}}}
    public function __construct() //{{{
    {
    } //}}}
    public static function pregIsNumeric($subject) //{{{
    {
        $result = 'fail';
        if (is_numeric($subject)) {
            $result = 'success';
        }

        return self::colorEcho($result, $subject);
    } //}}}
    public static function pregMatch($pattern, $subject) //{{{
    {
        $result = 'fail';
        if (preg_match($pattern, $subject)) {
            $result = 'success';
        }

        return self::colorEcho($result, $subject);
    } //}}}
    public static function colorEcho($result, $subject) //{{{
    {
        $color = self::$_result[$result]['color'];
        echo("{$subject}\t".gettype($subject)."\t");
        system("echo '[\e[{$color}m {$result} \e[m]'");
    } //}}}
} //}}}

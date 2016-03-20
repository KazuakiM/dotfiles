/*+
 * ESLINT
 *
 * @url https://github.com/eslint/eslint
 * @url http://eslint.org/docs/rules/
 * @url https://github.com/yannickcr/eslint-plugin-react
 */

"use strict";

module.exports = {
    "env": {
        "es6": true},
    "parserOptions": {
        "ecmaFeatures": {
            "jsx": true}},
    //MEMO:I don't use now.
    //"plugins": [
    //    "react"],
    "rules": {
        //Possible Errors {{{
        "comma-dangle":   [2, "never"],
        "no-cond-assign": 2,
        // no-console
        // no-constant-condition
        // no-control-regex
        // no-debugger
        "no-dupe-args":      2,
        "no-dupe-keys":      2,
        "no-duplicate-case": 2,
        // no-empty-character-class
        "no-empty":              2,
        "no-ex-assign":          2,
        "no-extra-boolean-cast": 2,
        // no-extra-parens
        // no-extra-semi
        "no-func-assign": 2,
        // no-inner-declarations
        // no-invalid-regexp
        "no-irregular-whitespace": 2,
        "no-negated-in-lhs":       2,
        "no-obj-calls":            2,
        "no-regex-spaces":         2,
        "no-sparse-arrays":        2,
        "no-unexpected-multiline": 2,
        // no-unreachable
        "use-isnan": 2,
        // valid-jsdoc
        // valid-typeof
        //}}}
        //Best Practices {{{
        // accessor-pairs
        // array-callback-return
        "block-scoped-var": 2,
        // complexity
        "consistent-return": 2,
        "curly":             2,
        // default-case
        "dot-location": [2, "property"],
        "dot-notation": 2,
        //XXX: "eqeqeq":       [2, "allow-null"],
        // guard-for-in
        // no-alert
        // no-caller
        // no-case-declarations
        // no-div-regex
        "no-else-return": 2,
        // no-empty-function
        // no-empty-pattern
        //XXX: "no-eq-null": 2,
        "no-eval": 2,
        // no-extend-native
        // no-extra-bind (es6)
        // no-extra-label
        "no-fallthrough":       2,
        "no-floating-decimal":  2,
        "no-implicit-coercion": 2,
        //XXX: "no-implicit-globals": 2,
        // no-implied-eval
        // no-invalid-this (es6)
        // no-iterator
        // no-labels
        // no-lone-blocks (es6)
        // no-loop-func (es6)
        //XXX: "no-magic-numbers": [2, {"ignoreArrayIndexes": true }],
        // no-multi-spaces
        "no-multi-str": 2,
        // no-native-reassign
        // no-new-func
        // no-new-wrappers
        "no-new": 2,
        // no-octal-escape
        "no-octal": 2,
        // no-param-reassign
        "no-process-env": 2,
        "no-proto":       2,
        "no-redeclare":   [2, {"builtinGlobals": true }],
        // no-return-assign
        // no-script-url
        //XXX: "no-self-assign": 2,
        "no-self-compare": 2,
        // no-sequences
        // no-throw-literal (es6)
        // no-unmodified-loop-condition
        // no-unused-expressions
        // no-unused-labels
        // no-useless-call
        // no-useless-concat (es6)
        // no-void
        // no-warning-comments
        "no-with": 2,
        // radix
        // vars-on-top
        // wrap-iife
        // yoda
        //}}}
        //Strict Mode {{{
        "strict": [2, "global"],
        //}}}
        //Variables {{{
        // init-declarations (es6)
        "no-catch-shadow": 2,
        "no-delete-var":   2,
        "no-label-var":    2,
        // no-restricted-globals
        // no-shadow (es6)
        "no-shadow-restricted-names": 2,
        //XXX:no-undef
        // no-undef-init (es6)
        "no-undefined": 2,
        // no-unused-vars
        // no-use-before-define (es6)
        //}}}
        //Node.js and CommonJS {{{
        //MEMO: If I get "JavaScript Power", I set this section.
        //}}}
        //Stylistic Issues {{{
        "array-bracket-spacing": [2, "never"],
        "block-spacing":         [2, "never"],
        "brace-style":           2,
        "jsx-quotes":            [1, "prefer-double"]
        //}}}
    }
};

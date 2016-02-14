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
    "plugins": [
        "react"],
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
        "eqeqeq":       [2, "allow-null"],
        // guard-for-in
        // no-alert
        // no-caller
        // no-case-declarations
        // no-div-regex
        "no-else-return": 2,
        // no-empty-function
        // no-empty-pattern
        "no-eq-null": 2,
        "no-eval":    2,
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
        //XXX: "no-magic-numbers": 2,
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
        //
        //TODO:now writing.
        //
        //}}}
        //Node.js and CommonJS {{{
        //}}}
        //Stylistic Issues {{{
        "array-bracket-spacing": [2, "never"],
        "block-spacing":         [2, "never"],
        "brace-style":           [2, "stroustrup"],
        "jsx-quotes":            [1, "prefer-double"],
        //}}}
        //eslint-plugin-react {{{
        "react/display-name":                 1,
        "react/forbid-prop-types":            1,
        "react/jsx-boolean-value":            1,
        "react/jsx-closing-bracket-location": 1,
        "react/jsx-curly-spacing":            1,
        "react/jsx-equals-spacing":           1,
        "react/jsx-handler-names":            1,
        "react/jsx-indent-props":             1,
        "react/jsx-indent":                   1,
        "react/jsx-key":                      1,
        "react/jsx-max-props-per-line":       1,
        "react/jsx-no-bind":                  1,
        "react/jsx-no-duplicate-props":       1,
        "react/jsx-no-literals":              1,
        "react/jsx-no-undef":                 1,
        "react/jsx-pascal-case":              1,
        "react/jsx-sort-prop-types":          1,
        "react/jsx-sort-props":               1,
        "react/jsx-uses-react":               1,
        "react/jsx-uses-vars":                1,
        "react/no-danger":                    1,
        "react/no-deprecated":                1,
        "react/no-did-mount-set-state":       1,
        "react/no-did-update-set-state":      1,
        "react/no-direct-mutation-state":     1,
        "react/no-is-mounted":                1,
        "react/no-multi-comp":                1,
        "react/no-set-state":                 1,
        "react/no-string-refs":               1,
        "react/no-unknown-property":          1,
        "react/prefer-es6-class":             1,
        "react/prop-types":                   1,
        "react/react-in-jsx-scope":           1,
        "react/require-extension":            1,
        "react/self-closing-comp":            1,
        "react/sort-comp":                    1,
        "react/wrap-multilines":              1
        //}}}
    }
};

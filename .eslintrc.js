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
        //Possible Errors
        "comma-dangle":      [2, "never"],
        "no-dupe-args":      2,
        "no-dupe-keys":      2,
        "no-duplicate-case": 2,
        "no-empty":          2,
        "no-ex-assign":      2,
        //Best Practices
        "consistent-return": 2,
        "curly":             2,
        "dot-location":      [2, "property"],
        "eqeqeq":            [2, "allow-null"],
        //Strict Mode
        "strict": [2, "global"],
        //eslint-plugin-react
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
        "react/jsx-quotes":                   1,
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
        "react/wrap-multilines":              1}
};

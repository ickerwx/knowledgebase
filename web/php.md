# PHP

## Juggling
* often weak comparisons are used "==" instead of "===" which doesnt check the type and gives often wrong results, e.g. a string comparison can be bypassed by comparing with the number 1

## Retrieve PHP source via filter
`index.php?m=php://filter/convert.base64-encode/resource=index`

tags: php filter
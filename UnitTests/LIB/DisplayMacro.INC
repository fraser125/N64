macro DisplayResults(pass, fail) {
	li a0, {pass}
	li a1, {fail}
	jal DisplayResult
	nop
}
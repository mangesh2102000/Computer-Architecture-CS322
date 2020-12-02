	.file	"static-local.c"
	.text
	.data
	.align 4
	.type	x, @object
	.size	x, 4
x:
	.long	15
	.text
	.globl	f
	.type	f, @function
f:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	x.1795(%rip), %eax
	leal	1(%rax), %edx
	movl	%edx, x.1795(%rip)
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	f, .-f
	.globl	g
	.type	g, @function
g:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	x.1798(%rip), %eax
	addl	$14, %eax
	movl	%eax, x.1798(%rip)
	movl	x.1798(%rip), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	g, .-g
	.globl	h
	.type	h, @function
h:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	x(%rip), %eax
	addl	$27, %eax
	movl	%eax, x(%rip)
	movl	x(%rip), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	h, .-h
	.data
	.align 4
	.type	x.1795, @object
	.size	x.1795, 4
x.1795:
	.long	17
	.align 4
	.type	x.1798, @object
	.size	x.1798, 4
x.1798:
	.long	19
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits

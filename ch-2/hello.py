from bcc import BPF

# creating the function that will be inserted in the kernel using C code.
program = r"""
int hello(void *ctx) {
    bpf_trace_printk("Hello World!");
    return 0;
}
"""

# creating a BPF object with the program (in C language) we created before
b = BPF(text=program)

# get the execve syscal. This syscall is called everytime we execute a program
syscall = b.get_syscall_fnname("execve")

# everytime the syscall 'execve' is trigged the function hello is trigged too using kprobe.
#
# ChatGPT explanation about kprobe:
#
# Q: Can you explain me in a nutshell what is kprobe?
# A: Kprobe allows developers and system administrators to dynamically insert small code snippets, called probes, at various locations in the kernel code.
#
# Q: Explains me kprobe in the context of ebpf.
# A: eBPF programs can attach kprobes to specific kernel functions or instructions and execute custom code whenever those functions or instructions are called or executed.
b.attach_kprobe(event=syscall, fn_name="hello")

# trace_print will loop indefinitely (until ctrl+C), displaying any trace from the kernel.
#
# you can check it by doing a cat in the following file:
# sudo cat /sys/kernel/debug/tracing/trace_pipe
b.trace_print()
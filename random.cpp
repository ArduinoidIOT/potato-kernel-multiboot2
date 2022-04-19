unsigned int rdrand() {
    asm("rdrand %eax");
}

unsigned int rdseed() {
    asm("rdseed %eax");
}
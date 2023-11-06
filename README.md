# Master_de_big_data_USC

configuración del sistema 

    lsb_release -a
    No LSB modules are available.
    Distributor ID:	Ubuntu
    Description:	Ubuntu 22.04.3 LTS
    Release:	22.04
    Codename:	jammy

Hardware

    Arquitectura:                            x86_64
    modo(s) de operación de las CPUs:      32-bit, 64-bit
    Address sizes:                         48 bits physical, 48 bits virtual
    Orden de los bytes:                    Little Endian
    CPU(s):                                  16
    Lista de la(s) CPU(s) en línea:        0-15
    ID de fabricante:                        AuthenticAMD
    Nombre del modelo:                     AMD Ryzen 9 5900HX with Radeon Graphics
        Familia de CPU:                      25
        Modelo:                              80
        Hilo(s) de procesamiento por núcleo: 2
        Núcleo(s) por «socket»:              8
        «Socket(s)»                          1
        Revisión:                            0
        Frequency boost:                     enabled
        CPU MHz máx.:                        4679,2959
        CPU MHz mín.:                        1200,0000
        BogoMIPS:                            6587.32
        Indicadores:                         fpu vme de pse tsc msr pae mce cx8 apic
                                            sep mtrr pge mca cmov pat pse36 clflus
                                            h mmx fxsr sse sse2 ht syscall nx mmxex
                                            t fxsr_opt pdpe1gb rdtscp lm constant_t
                                            sc rep_good nopl nonstop_tsc cpuid extd
                                            _apicid aperfmperf rapl pni pclmulqdq m
                                            onitor ssse3 fma cx16 sse4_1 sse4_2 mov
                                            be popcnt aes xsave avx f16c rdrand lah
                                            f_lm cmp_legacy svm extapic cr8_legacy 
                                            abm sse4a misalignsse 3dnowprefetch osv
                                            w ibs skinit wdt tce topoext perfctr_co
                                            re perfctr_nb bpext perfctr_llc mwaitx 
                                            cpb cat_l3 cdp_l3 hw_pstate ssbd mba ib
                                            rs ibpb stibp vmmcall fsgsbase bmi1 avx
                                            2 smep bmi2 erms invpcid cqm rdt_a rdse
                                            ed adx smap clflushopt clwb sha_ni xsav
                                            eopt xsavec xgetbv1 xsaves cqm_llc cqm_
                                            occup_llc cqm_mbm_total cqm_mbm_local c
                                            lzero irperf xsaveerptr rdpru wbnoinvd 
                                            cppc arat npt lbrv svm_lock nrip_save t
                                            sc_scale vmcb_clean flushbyasid decodea
                                            ssists pausefilter pfthreshold avic v_v
                                            msave_vmload vgif v_spec_ctrl umip pku 
                                            ospke vaes vpclmulqdq rdpid overflow_re
                                            cov succor smca fsrm
    Virtualization features:                 
    Virtualización:                        AMD-V
    Caches (sum of all):                     
    L1d:                                   256 KiB (8 instances)
    L1i:                                   256 KiB (8 instances)
    L2:                                    4 MiB (8 instances)
    L3:                                    16 MiB (1 instance)
    NUMA:                                    
    Modo(s) NUMA:                          1
    CPU(s) del nodo NUMA 0:                0-15
    Vulnerabilities:                         
    Gather data sampling:                  Not affected
    Itlb multihit:                         Not affected
    L1tf:                                  Not affected
    Mds:                                   Not affected
    Meltdown:                              Not affected
    Mmio stale data:                       Not affected
    Retbleed:                              Not affected
    Spec store bypass:                     Mitigation; Speculative Store Bypass di
                                            sabled via prctl
    Spectre v1:                            Mitigation; usercopy/swapgs barriers an
                                            d __user pointer sanitization
    Spectre v2:                            Mitigation; Retpolines, IBPB conditiona
                                            l, IBRS_FW, STIBP always-on, RSB fillin
                                            g, PBRSB-eIBRS Not affected
    Srbds:                                 Not affected
    Tsx async abort:                       Not affected



## git 

$ ssh-keygen -t ed25519 -C "ajlorenzo.1315@gmail.com"

Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/alourido/.ssh/id_ed25519): 
Created directory '/home/alourido/.ssh'.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/alourido/.ssh/id_ed25519
Your public key has been saved in /home/alourido/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:sh40m1JK+lNC+AsBPKIwchRWo2mKF5lbQ84q/EHpjec ajlorenzo.1315@gmail.com
The key's randomart image is:
+--[ED25519 256]--+
|..+o+            |
|*+.O..           |
|=+O+=            |
|+o==+.           |
|+.+B.o= S        |
| ooo*+.*         |
|  .ooE=          |
|   .oo .         |
|    ...          |
+----[SHA256]-----+

$ eval "$(ssh-agent -s)"
Agent pid 6377

$ ssh-add ~/.ssh/id_ed25519

Identity added: /home/alourido/.ssh/id_ed25519 (ajlorenzo.1315@gmail.com)

$ cat ~/.ssh/id_ed25519.pub

ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJT4n/7aiMazahN8LXlYPg/ns6dTzeJNbzJy7yN6L4Ur ajlorenzo.1315@gmail.com


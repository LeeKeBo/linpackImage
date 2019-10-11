#linpack image 

+ introduction
    + a Dockerfile for linpack and netperf test in IBM power use redhat
 
+ explanation
    + you need to get redhat image first,which can not get from dockerhub.You need to get it from [Redhat](https://access.redhat.com/containers/?tab=changeSummary&scrollTo=imageAdvisory#/registry.access.redhat.com/rhel7/rhel/images/7.7-310)
    + myself.repo is used for a yum repo, which need to config by yourself ,you can download the centos iso to make it. [how to do](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/5/html/deployment_guide/s1-yum-upgrade-system) 
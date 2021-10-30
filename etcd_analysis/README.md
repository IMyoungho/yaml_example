# etcd 정보 parsing
ETCD_AD=$(kubectl get pod -n kube-system etcd-m-k8s -o jsonpath='{.spec.containers[].command[1]}' | cut -d '=' -f 2)  
=> 편의를 위해서 etcd의 주소 및 포트 정보를 ETCD_AD에 저장(눈으로보고 데이터를 꺼내올때 변수대신 사용해도 무관)  
=> 현재 사용중인 etcd pod에서 정보 parsing  
=> 이게 귀찮으면 그냥 /etc/kubernetes/manifest/etcd.yaml 에서 봐도됨(etcd는 static pod)  



# etcd 데이터를 꺼내옴
kubectl exec -n kube-system etcd-m-k8s -- sh -c "ETCDCTL_API=3 etcdctl \
--endpoints $ETCD_AD \
--cacert /etc/kubernetes/pki/etcd/ca.crt \
--key /etc/kubernetes/pki/etcd/server.key \
--cert /etc/kubernetes/pki/etcd/server.crt \
get \"\" --prefix=true -w json" > etcd-test.json



# vi를 열어 etcd-test.json을 정렬시킴
:%!python -m json.tool



# decode_key.sh 
=> etcd 데이터에 저장된 key의 정보들을 복호화하고 key정보들을 출력시킴  
=> 해당 sh을 실행하려면 jq가 있어야함  
=> 이외의버전은 알아서 설치하자  
=> brew install jq  
=> apt-get install jq  

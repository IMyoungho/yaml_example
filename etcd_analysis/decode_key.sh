for key in $(cat etcd-test.json | jq '.kvs[].key' | cut -d '"' -f 2);
do
echo $key | base64 -d;
echo;
done


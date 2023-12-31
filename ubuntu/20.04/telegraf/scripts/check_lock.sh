echo "######### Checking apt lock"
echo "######### lslocks | grep '/var/lib/dpkg/lock-frontend'"
lslocks | grep '/var/lib/dpkg/lock-frontend'
while lslocks | grep '/var/lib/dpkg/lock-frontend'
do
    echo "######### File /var/lib/dpkg/lock-frontend already locked!"
    echo "######### lslocks"
    lslocks
    echo "######### sudo ps aux | grep -i apt"
    ps aux | grep -i apt
    echo "######### sudo lsof /var/lib/dpkg/lock-frontend"
    lsof /var/lib/dpkg/lock-frontend
    echo "######### Seeping a bit..."
    sleep 15
done
echo "######### apt lock is not present, continuing..."
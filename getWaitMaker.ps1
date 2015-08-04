$ip=""
$exit=0
$log = "C:\Windows\Panther\getWaitMaker.log"
$vmName=($env:computername).ToLower()
$RG="orbiteratestdrive"+$vmName.Replace('gate','')
while ($ip.Length -lt 7) {
	echo "Uploading resource group name...$RG " >> $log
	   #(new-object net.webclient).DownloadString('http://168.62.183.34/azurecheck.php?group='+$RG)
	$ip=(new-object net.webclient).DownloadString('http://168.62.183.34/azurecheck.php?group='+$RG)
	$z=$ip.Length
    date >> $log
	echo "(WaitMaker) Length: $z ip: $ip" >> $log
	start-sleep -s 15
}
date >> $log
echo "(WaitMaker) Script End" >> $log
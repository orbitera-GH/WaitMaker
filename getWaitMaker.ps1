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
echo "Configure NetAppStorage.RDP" >> $log
while ($exit -eq 0) {
    if (Test-Path -Path "C:\Users\Public\Desktop") {
		if (!(Test-Path -Path "C:\Users\Public\Desktop\NetAppStorage.RDP")) {
			(Get-Content C:\Windows\OEM\NetAppStorage.RDP).Replace('10.10.1.23',"$ip") | Set-Content C:\Windows\OEM\NetAppStorage.RDP
			Move-Item -Path C:\Windows\OEM\NetAppStorage.RDP -Destination C:\Users\Public\Desktop -Force
			date >> $log
			echo "(WaitMaker) NetAppStorage.RDP created " >> $log
			$exit=1
		} else {
			date >> $log
			echo "(WaitMaker) Waiting for directory..." >> $log
		}
    }else{
        date >> $log
        echo "(WaitMaker) Waiting for directory..." >> $log
	    start-sleep -s 15
    }
}
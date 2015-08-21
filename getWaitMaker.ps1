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
	start-sleep -s 5
}
date >> $log
echo "(WaitMaker) Script End" >> $log

$ip_port=$ip +":3395"
echo "change NetAppStorage.RDP" >> C:\Windows\Panther\get.log
while ($exit -eq 0) {
    if (Test-Path -Path "C:\Users\Public\Desktop") {
		echo "wait for move shortcut by get.ps1" >> $log
		if (!(Test-Path -Path "C:\Windows\OEM\NetAppStorage.RDP")) {
			(Get-Content C:\Users\Public\Desktop\NetAppStorage.RDP).Replace($ip,"$ip_port") | Set-Content C:\Users\Public\Desktop\NetAppStorage.RDP
			#Move-Item -Path C:\Windows\OEM\NetAppStorage.RDP -Destination C:\Users\Public\Desktop -Force
			date >> C:\Windows\Panther\get.log
			echo "NetAppStorage.RDP changed" >> C:\Windows\Panther\get.log
				echo "Rename shortcut" >> C:\Windows\Panther\get.log
				Rename-Item C:\Users\Public\Desktop\NetAppStorage.RDP "C:\Users\Public\Desktop\SQL Server.RDP"
			$exit=1
		}
		start-sleep -s 2
    }else{
        date >> C:\Windows\Panther\get.log
        echo "Waiting for NetAppStorage.RDP..." >> C:\Windows\Panther\get.log
	    start-sleep -s 5
    }
}
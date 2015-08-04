configuration WaitMaker 
{ 
  
$seconds = 33
$log = "c:\windows\temp\WaitMaker.txt"
date >> $log
echo "WaitMaker start" >> $log
echo "Start sleep... $seconds" >> $log
start-sleep -s $seconds
date >> $log
echo "WaitMaker stop" >> $log

} 
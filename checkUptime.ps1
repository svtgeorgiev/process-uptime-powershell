$procName = "svchost"
# process name
$process = Get-Process $procName
# get process details
if($process){
    # if process is running collect starttime in array
    $data = @($process | select starttime)
    # create array list to store time duration
    $thList = [System.Collections.ArrayList]::new()
    # start for loop in $data array
    foreach ($d in $data){
        $intHours = [int]((Get-Date).Subtract(($d).StartTime)| select TotalHours).TotalHours
        # subtract current date and time by start time of the instance, select the output by total hours and convert to integer
        $thList.Add($intHours)}
        # add the output of row 12 to array list
    if(($thList | Measure-Object -Maximum).Maximum -ge 3){
    # checks for the greatest element in the array and compare if greater or equal 3
    Write-Output "-1: Process is running for more than 3 hours"}
    #report to PRTG monitoring software
    else{
        Write-Output "1: Process is OK"}}
else{
    Write-Output "-1: Process not found"}

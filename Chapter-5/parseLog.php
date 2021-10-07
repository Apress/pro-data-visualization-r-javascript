<html>
<head></head>
<body>
<?php
$logfile = "access_log";
$chartingData = "accessLogData.txt";
$logArr = parseLog($logfile);
writeRLog($logArr, $chartingData);
function parseLog($file){
        $logArray = array();
        $file_handle = fopen($file, "r");
        while (!feof($file_handle)) {
           $line = fgets($file_handle);
           $lineArr = parseLogLine($line);
           $lineArr = getLocationbyIP($lineArr);
           $logArray[count($logArray)] = $lineArr;
        }
        fclose($file_handle);
        return $logArray;
}
function parseLogLine($logLine){
        $pattern = '/^([\d.:]+) (\S+) (\S+) \[([\w\/]+):([\w:]+)\s([+\-]\d{4})\] "(.+?) (.+?) (.+?)" (\d{3}) (\d+|(?:.+?)) "([^"]*|(?:.+?))" "([^"]*|(?:.+?))"/';
        preg_match($pattern,$logLine,$logs);
        $logArray = array();
        $logArray['ip'] = gethostbyname($logs[1]);
        $logArray['identity'] = $logs[2];
        $logArray['user'] = $logs[2];
        $logArray['date'] = $logs[4];
        $logArray['time'] = $logs[5];
        $logArray['timezone'] = $logs[6];
        $logArray['method'] = $logs[7];
        $logArray['path'] = $logs[8];
        $logArray['protocol'] = $logs[9];
        $logArray['status'] = $logs[10];
        $logArray['bytes'] = $logs[11];
        $logArray['referer'] = $logs[12];
        $logArray['useragent'] = $logs[13];
        return $logArray;
}
function getLocationbyIP($arr){
        $IPAddress = $arr['ip'];
        $IPCheckURL = "http://api.hostip.info/get_json.php?ip=$IPAddress";
        $jsonResponse =  file_get_contents($IPCheckURL);
        $geoInfo = json_decode($jsonResponse);
        $arr['country'] = $geoInfo->{"country_code"};
        $arr['city'] = explode(",",$geoInfo->{"city"})[0];
        $arr['state'] = explode(",",$geoInfo->{"city"})[1];
        return $arr;
}
function writeRLog($arr, $file){
        $writeFlag = "w";
        if(file_exists($file)){
                $writeFlag = "a";
        }
        $fh = fopen($file, $writeFlag) or die("can't open file");
        for($x = 0; $x < count($arr); $x++){
                if($arr[$x]['country'] != "XX"){
                        $data = $arr[$x]['ip'] . "," . $arr[$x]['date'] . "," . $arr[$x]['status'] . "," . $arr[$x]['country'] . "," . $arr[$x]['state'] . "," . $arr[$x]['city'];
                }
                fwrite($fh, $data . "\n");
        }
        fclose($fh);
        echo "log created";
}
?>
</body>
</html>

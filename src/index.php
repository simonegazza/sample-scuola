<?
echo "YEAH!!";

$hostname='mysql';
$username='root';
$password='r00t';

try {
    $dbh = new PDO("mysql:host=$hostname;dbname=mysql",$username,$password);

    $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); // <== add this line
    echo 'Connected to Database<br/>';

    $sql = "SELECT * FROM user";
foreach ($dbh->query($sql) as $row)
    {
    echo $row["User"] ." - ". $row["plugin"] ."<br/>";
    }

    $dbh = null;
    }
catch(PDOException $e)
    {
    echo $e->getMessage();
    }

?>


<?php
# Fill our vars and run on cli
# $ php -f db-connect-test.php
// $dbname = 'sos';
// $dbuser = 'sosuser';
// $dbpass = 'sosPWD!';
// $dbhost = 'db';
// $link = mysqli_connect($dbhost, $dbuser, $dbpass) or die("Unable to Connect to '$dbhost'");
// mysqli_select_db($link, $dbname) or die("Could not open the db '$dbname'");
// $test_query = "SHOW TABLES FROM $dbname";
// $result = mysqli_query($link, $test_query);
// $tblCnt = 0;
// while($tbl = mysqli_fetch_array($result)) {
//   $tblCnt++;
//   #echo $tbl[0]."<br />\n";
// }
// if (!$tblCnt) {
//   echo "There are no tables<br />\n";
// } else {
//   echo "There are $tblCnt tables<br />\n";
// }
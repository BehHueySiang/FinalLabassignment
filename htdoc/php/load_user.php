<?php
include_once("dbconnect.php");
$userid = $_POST['userid'];
$sqlloaduser = "SELECT * FROM `tbl_users` WHERE user_id = '$userid'";
$result = $conn->query($sqlloaduser);
if ($result->num_rows > 0) {
      $users["users"] = array();
while ($row = $result->fetch_assoc()) {
        $userlist = array();
        $userlist['user_id'] = $row['id'];
        $userlist['user_email'] = $row['email'];
        $userlist['user_name'] = $row['name'];
        $userlist['user_password'] = $row['password'];
        $userlist['user_phone'] = $row['phone'];
		$userlist['user_datereg'] = $row['datereg'];
		$userlist['otp'] = $row['otp'];


     
       array_push($users["users"],$userlist);
    }
    $response = array('status' => 'success', 'data' => $users);
    sendJsonResponse($response);
}else{
     $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}
function sendJsonResponse($sentArray)
{
    header('Content‐Type: application/json');
    echo json_encode($sentArray);
}
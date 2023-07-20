<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");


if (!isset($_POST['itemid']) || !isset($_POST['itemname']) || !isset($_POST['itemdesc']) || !isset($_POST['itemvalue']) || !isset($_POST['itemqty']) || !isset($_POST['type'])) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}//The isset() function is used to check if a variable is set or not. If any of the variables listed above are not set, meaning they haven't been passed in the POST request, the condition !isset($_POST['variable']) will evaluate to true.

//If any of these variables are not set, the code block inside the curly braces will be executed. In this case, it sets the $response array with a status of 'failed' and a null value for the 'data' key. Then, the sendJsonResponse() function is called to send this response as a JSON object. Finally, the die() function is called to terminate the script execution.

//Essentially, this code checks for the presence of required $_POST variables, and if any are missing, it sends a failed response and stops the execution of the script. This helps ensure that all the necessary data is provided before proceeding with the database update operation.

$itemid = $_POST['itemid'];
$item_name = $_POST['itemname'];
$item_desc = $_POST['itemdesc'];
$item_value = $_POST['itemvalue'];
$item_qty = $_POST['itemqty'];
$item_type = $_POST['type'];


$sqlupdate = "UPDATE `tbl_items` SET `item_name`='$item_name',`item_desc`='$item_desc',`item_value`='$item_value',`item_qty`='$item_qty',`item_type`='$item_type' WHERE `item_id` = '$itemid'";

if ($conn->query($sqlupdate) === TRUE) {
	$response = array('status' => 'success', 'data' => null);
    sendJsonResponse($response);
}else{
	$response = array('status' => 'failed', 'data' => null);
	sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>
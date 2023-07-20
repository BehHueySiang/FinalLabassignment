<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$userid = $_POST['userid'];
$item_name = $_POST['itemname'];
$item_desc = $_POST['itemdesc'];
$item_value = $_POST['itemvalue'];
$item_qty = $_POST['itemqty'];
$item_type = $_POST['type'];
$latitude = $_POST['latitude'];
$longitude = $_POST['longitude'];
$state = $_POST['state'];
$locality = $_POST['locality'];
$image = $_POST['image'];
$image1 = $_POST['image1'];
$image2 = $_POST['image2'];

$sqlinsert = "INSERT INTO `tbl_items`(`userid`,`item_name`, `item_desc`, `item_type`, `item_value`, `item_qty`, `item_lat`, `item_long`, `item_state`, `item_locality`,`image`,`image1`,`image2`) VALUES ('$userid','$item_name','$item_desc','$item_type','$item_value','$item_qty','$latitude','$longitude','$state','$locality','$image','$image1','$image2')";

if ($conn->query($sqlinsert) === TRUE) {
	$filename = mysqli_insert_id($conn);
	$response = array('status' => 'success', 'data' => null);
	 $decoded_string = base64_decode($image);
    $path = 'C:/xampp/htdocs/mybarter/assets/items/'.$filename.'_image0.png';
    $decoded_string1 = base64_decode($image1);
    $path1 = 'C:/xampp/htdocs/mybarter/assets/items/'.$filename.'_image1.png';
    $decoded_string2 = base64_decode($image2);
    $path2 = 'C:/xampp/htdocs/mybarter/assets/items/'.$filename.'_image2.png';
	file_put_contents($path, $decoded_string);
	file_put_contents($path1, $decoded_string1);
	file_put_contents($path2, $decoded_string2);
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